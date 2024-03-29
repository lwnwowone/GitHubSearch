//
//  HomeView.h
//  GitHubSearch
//
//  Created by alanc on 08/09/2019.
//  Copyright © 2019 刘文楠. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomeViewProtocol.h"
#import "IphoneViewProtocol.h"

@interface HomeView : UIView<HomeViewProtocol, IphoneViewProtocol>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, assign) int currentPage;

@property (nonatomic, copy) void(^textChangedEvent)(int page, NSString *text);

-(void)hideKeyboard;

-(void)beginSearch;
-(void)searchDone;

-(void)showDataWithCurrentPage:(int)currentPage totalPage:(int)totalPage;

@end
