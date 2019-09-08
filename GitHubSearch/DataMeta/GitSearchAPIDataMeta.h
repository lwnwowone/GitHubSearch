//
//  GitSearchAPIDataMeta.h
//  GitHubSearch
//
//  Created by alanc on 08/09/2019.
//  Copyright © 2019 刘文楠. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GitItemDataMeta.h"
#import "ActionResult.h"

@interface GitSearchAPIDataMeta : NSObject

@property (nonatomic, assign) int totalCount;
@property (nonatomic, assign) bool incompleteResults;
@property (nonatomic, strong) NSArray<GitItemDataMeta *> *items;

-(ActionResult *)loadDataFromJSON:(NSString *)json;

@end
