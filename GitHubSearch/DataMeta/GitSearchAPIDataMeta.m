//
//  GitSearchAPIDataMeta.m
//  GitHubSearch
//
//  Created by alanc on 08/09/2019.
//  Copyright © 2019 刘文楠. All rights reserved.
//

#import "GitSearchAPIDataMeta.h"

@implementation GitSearchAPIDataMeta

-(id)initWithJson:(NSString *)json{
    self = [super init];
    [self loadDataFromJSON:json];
    return self;
}

-(ActionResult *)loadDataFromJSON:(NSString *)json{
    ActionResult *result = [ActionResult new];
    NSError *error;
    NSDictionary *jsonDic = [NSJSONSerialization JSONObjectWithData:[json dataUsingEncoding:NSUTF8StringEncoding]
                                                            options:0
                                                              error:&error];
    if(!error && jsonDic && [jsonDic isKindOfClass:[NSDictionary class]]){
        if([jsonDic.allKeys containsObject:@"total_count"]
           && [jsonDic.allKeys containsObject:@"incomplete_results"]
           && [jsonDic.allKeys containsObject:@"items"]){
            _totalCount = [jsonDic[@"total_count"] intValue];
            _incompleteResults = [jsonDic[@"incomplete_results"] boolValue];
            NSMutableArray *tArray = [NSMutableArray new];
            if(_totalCount > 0 && [jsonDic[@"items"] isKindOfClass:[NSArray class]]){
                NSArray *dataArray = jsonDic[@"items"];
                for (NSDictionary *itemInfo in dataArray) {
                    GitItemDataMeta *item = [GitItemDataMeta new];
                    ActionResult *loadResult = [item loadDataFromJSON:itemInfo];
                    if(loadResult.isSucceeded){
                        [tArray addObject:item];
                    }
                    else{
                        NSLog(@"#### Warning!!! One item has been lost, error = %@", loadResult.errorMsg);
                    }
                }
            }
            _items = [tArray copy];
            tArray = nil;
            result.isSucceeded = true;
        }
        else{
            result.errorMsg = [NSString stringWithFormat:@"%s: parse json failed, key lost", __PRETTY_FUNCTION__];
        }
    }
    else{
        result.errorMsg = [NSString stringWithFormat:@"%s: parse json failed, invalid json", __PRETTY_FUNCTION__];
    }
    return result;
}

-(NSString *)description{
    NSString *firstPart = [NSString stringWithFormat:@"totalCount = %d", _totalCount];
    NSString *secondPart = [NSString stringWithFormat:@"totalCount = %@", _incompleteResults?@"T":@"F"];
    NSString *thridPart = [_items description];
    return [NSString stringWithFormat:@"%@\n%@\n%@\n", firstPart, secondPart, thridPart];
}

@end
