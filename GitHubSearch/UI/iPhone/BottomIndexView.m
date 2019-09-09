//
//  BottomIndexView.m
//  GitHubSearch
//
//  Created by alanc on 09/09/2019.
//  Copyright © 2019 刘文楠. All rights reserved.
//

#import "BottomIndexView.h"
#import "CommonMacros.h"

@implementation BottomIndexView{
    @private int _currentPage;
    @private UILabel *_lbInfo;
    @private UIButton *_btnPrevious;
    @private UIButton *_btnNext;
}

-(id)init{
    self = [super init];
    self.backgroundColor = [UIColor whiteColor];

    _lbInfo = [UILabel new];
    _lbInfo.accessibilityIdentifier = @"lb_page_info";
    _lbInfo.textAlignment = NSTextAlignmentCenter;
    [self addSubview:_lbInfo];
    
    _btnPrevious = [UIButton new];
    _btnPrevious.accessibilityIdentifier = @"btn_pre";
    [_btnPrevious setTitle:@"<" forState:UIControlStateNormal];
    [_btnPrevious setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [_btnPrevious setTitleColor:[UIColor blackColor] forState:UIControlStateHighlighted];
    [_btnPrevious setTitleColor:[UIColor grayColor] forState:UIControlStateDisabled];
    [_btnPrevious addTarget:self action:@selector(gotoPreviousPage) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_btnPrevious];
    
    _btnNext = [UIButton new];
    _btnNext.accessibilityIdentifier = @"btn_next";
    [_btnNext setTitle:@">" forState:UIControlStateNormal];
    [_btnNext setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [_btnNext setTitleColor:[UIColor blackColor] forState:UIControlStateHighlighted];
    [_btnNext setTitleColor:[UIColor grayColor] forState:UIControlStateDisabled];
    [_btnNext addTarget:self action:@selector(gotoNextPage) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_btnNext];
    
    return self;
}

-(void)gotoPreviousPage{
    NSLog(@"gotoPreviousPage");
    _currentPage--;
    if(self.gotoPreviousPageEvent){
        self.gotoPreviousPageEvent(_currentPage);
    }
}

-(void)gotoNextPage{
    NSLog(@"gotoNextPage");
    _currentPage++;
    if(self.gotoNextPageEvent){
        self.gotoNextPageEvent(_currentPage);
    }
}

-(void)showDataWithCurrentPage:(int)currentPage totalPage:(int)totalPage{
    _currentPage = currentPage;
    
    _lbInfo.text = [NSString stringWithFormat:@"%d / %d", currentPage, totalPage];
    
    _btnPrevious.enabled = currentPage > 1;
    _btnNext.enabled = currentPage < totalPage;
}

-(void)layoutSubviews{
    float btnWidth = 80;
    _btnPrevious.frame = CGRectMake(0, 0, btnWidth, self.bounds.size.height);
    _btnNext.frame = CGRectMake(self.bounds.size.width - btnWidth, 0, btnWidth, self.bounds.size.height);
    _lbInfo.frame = CGRectMake(btnWidth, 0, self.bounds.size.width - 2 * btnWidth, self.bounds.size.height);
}

@end
