//
//  GitSearchDataManager.h
//  GitHubSearch
//
//  Created by alanc on 08/09/2019.
//  Copyright © 2019 刘文楠. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ActionResult.h"
#import "HttpClient.h"
#import "GitSearchAPIDataMeta.h"

@interface GitSearchDataManager : NSObject

@property (nonatomic, strong) HttpClient *httpClient;

-(ActionResult<GitSearchAPIDataMeta *> *)searchWithKeyWord:(NSString *)keyWord;
-(ActionResult<GitSearchAPIDataMeta *> *)searchWithKeyWord:(NSString *)keyWord page:(int)index;

@end
