//
//  HomeViewController.m
//  GitHubSearch
//
//  Created by alanc on 08/09/2019.
//  Copyright © 2019 刘文楠. All rights reserved.
//

#import "HomeViewController.h"
#import "HomeView.h"
#import "CommonMacros.h"
#import "ObjectFactory.h"
#import "HomeViewProtocol.h"
#import "GitSearchDataManager.h"
#import "ViewUtil.h"
#import "PorjectConfig.h"
#import "ItemDetailsViewController.h"

#define HOME_TABLE_CELL_ID @"home_cell_id"

@interface HomeViewController()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) NSArray<GitItemDataMeta *> *items;

@end

@implementation HomeViewController{
    @private GitSearchDataManager *dataManager;
    @private UIView<HomeViewProtocol> *_homeView;
    @private bool _isSearching;
}

-(void)loadView{
    _homeView = (UIView<HomeViewProtocol> *)[ObjectFactory viewForProtocols:@[@protocol(HomeViewProtocol)]];
    self.view = _homeView;
}

-(void)viewDidLoad{
    self->_items = [NSArray new];
    
    dataManager = [GitSearchDataManager new];
    
    self.title = @"GitHubSearch";

    _homeView.tableView.delegate = self;
    _homeView.tableView.dataSource = self;
    
    __TO_WEAK_SELF
    _homeView.textChangedEvent = ^(int page, NSString *text) {
        __TO_STRONG_SELF
        [self searchEventTriggered:page text:text];
    };
}

#pragma data setter

-(void)setItems:(NSArray<GitItemDataMeta *> *)items{
    _items = items;
    dispatch_async(dispatch_get_main_queue(), ^{
        [_homeView.tableView reloadData];
    });
}

#pragma search logic

-(void)searchEventTriggered:(int)index text:(NSString *)searchText{
    if(_isSearching){
        NSLog(@"search is running, please try later");
    }
    else{
        _isSearching = true;
        NSLog(@"triggerTextChangedEvent, page = %d, value = %@", index, searchText);
        [_homeView beginSearch];

        __TO_WEAK_SELF
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            __TO_STRONG_SELF
            ActionResult<GitSearchAPIDataMeta *> *searchResult = [dataManager searchWithKeyWord:searchText page:index];
            if(searchResult.isSucceeded){
                GitSearchAPIDataMeta *data = searchResult.data;
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self->_homeView showDataWithCurrentPage:index totalPage:(data.totalCount / PER_PAGE_CONT + 1)];
                    self.items = data.items;
                });
            }
            else{
                dispatch_async(dispatch_get_main_queue(), ^{
                    [ViewUtil showAlertAtController:self title:@"get data failed" message:searchResult.errorMsg];
                });
            }
            
            [self->_homeView searchDone];
            
            self->_isSearching = false;
        });
    }
}

#pragma TableView DataSource & Delegate

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self->_items.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:HOME_TABLE_CELL_ID];

    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:HOME_TABLE_CELL_ID];
    }
    
    cell.textLabel.text = [self->_items objectAtIndex:indexPath.row].name;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [_homeView.tableView deselectRowAtIndexPath:indexPath animated:true];
    ItemDetailsViewController *itemVC = [ItemDetailsViewController new];
    itemVC.dataMeta = [self->_items objectAtIndex:indexPath.row];
    [self.navigationController pushViewController:itemVC animated:true];
}

@end
