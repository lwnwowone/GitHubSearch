//
//  ItemDetailsView.m
//  GitHubSearch
//
//  Created by AlancLiu on 2019/9/9.
//  Copyright © 2019 刘文楠. All rights reserved.
//

#import "ItemDetailsView.h"
#import "ViewUtil.h"

#define ITEM_PADDING 10
#define ITEM_INSIDE_PADDING 10

@implementation ItemDetailsView{
    @private UILabel *_lbName;
    @private UILabel *_lbID;
    @private UILabel *_lsStartCount;
    @private UILabel *_lbLanguage;
    @private UIButton *_btnOpenProjectHome;
}

-(id)init{
    self = [super init];
    self.backgroundColor = [UIColor whiteColor];
    
    _lbName = [UILabel new];
    [self addSubview:_lbName];
    
    _lbID = [UILabel new];
    [self addSubview:_lbID];
    
    _lsStartCount = [UILabel new];
    [self addSubview:_lsStartCount];
    
    _lbLanguage = [UILabel new];
    [self addSubview:_lbLanguage];
    
    _btnOpenProjectHome = [UIButton new];
    _btnOpenProjectHome.accessibilityIdentifier = @"btn_project_home";
    [_btnOpenProjectHome setTitle:@"Project Home" forState:UIControlStateNormal];
    [_btnOpenProjectHome setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [_btnOpenProjectHome setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
    [_btnOpenProjectHome addTarget:self action:@selector(openProjectInSafari) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_btnOpenProjectHome];
    
    return self;
}

-(void)setDataMeta:(GitItemDataMeta *)dataMeta{
    _dataMeta = dataMeta;
    _lbName.text = dataMeta.name;
    _lbID.text = [NSString stringWithFormat:@"ID: %ld", dataMeta.itemID];
    _lsStartCount.text = [NSString stringWithFormat:@"start: %ld", dataMeta.starCount];
    _lbLanguage.text = [NSString stringWithFormat:@"language: %@", dataMeta.language];
}

-(void)layoutSubviews{
    float tfHeight = 50;
    float itemWidth = self.bounds.size.width - 2 * ITEM_PADDING;
    _lbName.frame = CGRectMake(ITEM_PADDING, [ViewUtil topBarHeight], itemWidth, tfHeight);
    _lbID.frame = CGRectMake(ITEM_PADDING, CGRectGetMaxY(_lbName.frame) + ITEM_INSIDE_PADDING, itemWidth, tfHeight);
    _lsStartCount.frame = CGRectMake(ITEM_PADDING, CGRectGetMaxY(_lbID.frame) + ITEM_INSIDE_PADDING, itemWidth, tfHeight);
    _lbLanguage.frame = CGRectMake(ITEM_PADDING, CGRectGetMaxY(_lsStartCount.frame) + ITEM_INSIDE_PADDING, itemWidth, tfHeight);
    _btnOpenProjectHome.frame = CGRectMake(ITEM_PADDING, CGRectGetMaxY(_lbLanguage.frame) + ITEM_INSIDE_PADDING, itemWidth, tfHeight);
}

-(void)openProjectInSafari{
    NSURL *url = [NSURL URLWithString:_dataMeta.projectHome];
    if ([[UIApplication sharedApplication] canOpenURL:url]) {
        [[UIApplication sharedApplication] openURL:url];
    }
    else{
        NSLog(@"Cannot open url!");
    }
}

@end
