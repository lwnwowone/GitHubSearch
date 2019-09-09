//
//  BottomIndexView.h
//  GitHubSearch
//
//  Created by alanc on 09/09/2019.
//  Copyright © 2019 刘文楠. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BottomIndexView : UIView

@property (nonatomic, copy) void(^gotoPreviousPageEvent)(int pageIndex);
@property (nonatomic, copy) void(^gotoNextPageEvent)(int pageIndex);

-(void)showDataWithCurrentPage:(int)currentPage totalPage:(int)totalPage;

@end
