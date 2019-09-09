//
//  HomeViewProtocal.h
//  GitHubSearch
//
//  Created by alanc on 09/09/2019.
//  Copyright © 2019 刘文楠. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GitItemDataMeta.h"

@protocol HomeViewProtocol <NSObject>

//Table for show data
@property (nonatomic, strong) UITableView *tableView;

//Event for user search operation
@property (nonatomic, copy) void(^textChangedEvent)(int page, NSString *text);

//Search animation
-(void)beginSearch;
-(void)searchDone;

-(void)showDataWithCurrentPage:(int)currentPage totalPage:(int)totalPage;

@end
