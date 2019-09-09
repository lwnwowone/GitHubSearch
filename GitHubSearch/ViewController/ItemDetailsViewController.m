//
//  ItemDetailsViewController.m
//  GitHubSearch
//
//  Created by AlancLiu on 2019/9/9.
//  Copyright © 2019 刘文楠. All rights reserved.
//

#import "ItemDetailsViewController.h"
#import "ItemDetailsViewProtocol.h"
#import "ObjectFactory.h"

@interface ItemDetailsViewController ()

@end

@implementation ItemDetailsViewController{
    @private UIView<ItemDetailsViewProtocol> *_itemView;
}

-(void)loadView{
    _itemView = (UIView<ItemDetailsViewProtocol> *)[ObjectFactory viewForProtocols:@[@protocol(ItemDetailsViewProtocol)]];
    self.view = _itemView;
    if(_dataMeta){
        _itemView.dataMeta = _dataMeta;
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(void)setDataMeta:(GitItemDataMeta *)dataMeta{
    _dataMeta = dataMeta;
    _itemView.dataMeta = dataMeta;
}

@end
