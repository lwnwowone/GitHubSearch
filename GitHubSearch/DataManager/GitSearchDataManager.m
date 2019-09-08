//
//  GitSearchDataManager.m
//  GitHubSearch
//
//  Created by alanc on 08/09/2019.
//  Copyright © 2019 刘文楠. All rights reserved.
//

#import "GitSearchDataManager.h"
#import "PorjectConfig.h"

#define GITHUB_API_HOST @"https://api.github.com"
#define GITHUB_SEARCH_REPO_API_PATH @"search/repositories"

@implementation GitSearchDataManager

-(id)init{
    self = [super init];
    _httpClient = [HttpClient new];
    return self;
}

-(ActionResult<GitSearchAPIDataMeta *> *)searchWithKeyWord:(NSString *)keyWord{
    return [self searchWithKeyWord:keyWord page:1];
}

-(ActionResult<GitSearchAPIDataMeta *> *)searchWithKeyWord:(NSString *)keyWord page:(int)index{
    ActionResult<GitSearchAPIDataMeta *> *searchResult = [ActionResult new];
    
    NSDictionary *queryDic = @{@"q":keyWord,
                               @"per_page":[NSString stringWithFormat:@"%d", PER_PAGE_CONT]};
    NSString *requestURLString = [NSString stringWithFormat:@"%@/%@", GITHUB_API_HOST, GITHUB_SEARCH_REPO_API_PATH];
    
    ActionResult<NSString *> *httpResult = [_httpClient getWithURLString:requestURLString
                                                                   query:queryDic];
    if(httpResult.isSucceeded){
        GitSearchAPIDataMeta *apiResultData = [GitSearchAPIDataMeta new];
        ActionResult *loadDataResult = [apiResultData loadDataFromJSON:httpResult.data];
        
        if(loadDataResult){
            searchResult.isSucceeded = true;
            searchResult.data = apiResultData;
        }
        else{
            [searchResult readErrorMsg:loadDataResult];
        }
    }
    else{
        [searchResult readErrorMsg:httpResult];
    }
    
    return searchResult;
}

@end
