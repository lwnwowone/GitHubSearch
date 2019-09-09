//
//  HomeView.m
//  GitHubSearch
//
//  Created by alanc on 08/09/2019.
//  Copyright © 2019 刘文楠. All rights reserved.
//

#import "HomeView.h"
#import "BottomIndexView.h"
#import "ViewUtil.h"

#define ITEM_PADDING 10
#define ITEM_INSIDE_PADDING 10
#define SEARCH_FILED_HEIGHT 30

#define EVENT_TRIGGER_DELY 1

@implementation HomeView{
    @private UITextField *_tfSearch;
    @private UIActivityIndicatorView *_indicator;
    @private BottomIndexView *_bottomIndexView;
}

-(id)init{
    self = [super init];
    self.backgroundColor = [UIColor whiteColor];

    _tfSearch = [UITextField new];
    _tfSearch.backgroundColor = [UIColor lightGrayColor];
    _tfSearch.placeholder = @"Input search key";
    _tfSearch.autocorrectionType = UITextAutocorrectionTypeNo;
    _tfSearch.autocapitalizationType = UITextAutocapitalizationTypeNone;
    [_tfSearch addTarget:self action:@selector(textChanged) forControlEvents:UIControlEventEditingChanged];
    [self addSubview:_tfSearch];
    
    _indicator = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(0, 0, SEARCH_FILED_HEIGHT, SEARCH_FILED_HEIGHT)];
    _indicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyleGray;
    _indicator.hidesWhenStopped = YES;
    _indicator.color = [UIColor grayColor];
    [self addSubview:_indicator];

    _tableView = [UITableView new];
    [self addSubview:_tableView];
    
    _bottomIndexView = [BottomIndexView new];
    [_bottomIndexView showDataWithCurrentPage:0 totalPage:0];
    [self addSubview:_bottomIndexView];
    
    __weak typeof(self) weakSelf = self;
    _bottomIndexView.gotoPreviousPageEvent = ^(int pageIndex) {
        __strong typeof(self) strongSelf = weakSelf;
        if(_tfSearch.text.length > 0 && strongSelf.textChangedEvent){
            strongSelf.textChangedEvent(pageIndex, strongSelf->_tfSearch.text);
        }
    };
    _bottomIndexView.gotoNextPageEvent = ^(int pageIndex) {
        __strong typeof(self) strongSelf = weakSelf;
        if(_tfSearch.text.length > 0 && strongSelf.textChangedEvent){
            strongSelf.textChangedEvent(pageIndex, strongSelf->_tfSearch.text);
        }
    };
    
    return self;
}

-(void)beginSearch{
    dispatch_async(dispatch_get_main_queue(), ^{
        [_indicator startAnimating];
    });
}

-(void)searchDone{
    dispatch_async(dispatch_get_main_queue(), ^{
        [_indicator stopAnimating];
    });
}

-(void)showDataWithCurrentPage:(int)currentPage totalPage:(int)totalPage{
    _currentPage = currentPage;
//    NSLog(@"update page info, current = %d, total = %d", currentPage, totalPage);
    [_bottomIndexView showDataWithCurrentPage:currentPage totalPage:totalPage];
}

-(void)gotoPage:(int)pageIndex{
    if(_tfSearch.text.length > 0 && self.textChangedEvent){
        self.textChangedEvent(pageIndex, _tfSearch.text);
    }
}

-(void)hideKeyboard{
    [_tfSearch resignFirstResponder];
}

-(void)textChanged{
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(triggerTextChangedEvent) object:nil];
    [self performSelector:@selector(triggerTextChangedEvent) withObject:nil afterDelay:EVENT_TRIGGER_DELY];
}

-(void)triggerTextChangedEvent{
    if(_tfSearch.text.length > 0 && self.textChangedEvent){
        self.textChangedEvent(1, _tfSearch.text);
    }
}

-(void)layoutSubviews{
    _indicator.frame = CGRectMake(self.bounds.size.width - ITEM_PADDING - SEARCH_FILED_HEIGHT,
                                  ITEM_PADDING + [ViewUtil topBarHeight],
                                  SEARCH_FILED_HEIGHT,
                                  SEARCH_FILED_HEIGHT);
    
    float searchBoxWidth = self.bounds.size.width - ITEM_PADDING - SEARCH_FILED_HEIGHT - ITEM_INSIDE_PADDING;
    _tfSearch.frame = CGRectMake(ITEM_PADDING,
                                 ITEM_PADDING + [ViewUtil topBarHeight],
                                 searchBoxWidth,
                                 SEARCH_FILED_HEIGHT);
    
    float bottomViewHeight = 50;
    _bottomIndexView.frame = CGRectMake(0,
                                        self.bounds.size.height - bottomViewHeight,
                                        self.bounds.size.width,
                                        bottomViewHeight);

    _tableView.frame = CGRectMake(0,
                                  CGRectGetMaxY(_tfSearch.frame) + ITEM_INSIDE_PADDING,
                                  self.bounds.size.width,
                                  self.bounds.size.height - CGRectGetMaxY(_tfSearch.frame) + ITEM_INSIDE_PADDING - bottomViewHeight);
}

@end
