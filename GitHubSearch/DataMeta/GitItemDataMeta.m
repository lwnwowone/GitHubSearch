//
//  GitItemDataMeta.m
//  GitHubSearch
//
//  Created by alanc on 08/09/2019.
//  Copyright © 2019 刘文楠. All rights reserved.
//

#import "GitItemDataMeta.h"

@implementation GitItemDataMeta

-(ActionResult *)loadDataFromJSON:(NSDictionary *)jsonDic{
    ActionResult *result = [ActionResult new];

    if(jsonDic && [jsonDic isKindOfClass:[NSDictionary class]]){
        if([jsonDic.allKeys containsObject:@"id"]
           && [jsonDic.allKeys containsObject:@"stargazers_count"]
           && [jsonDic.allKeys containsObject:@"name"]
           && [jsonDic.allKeys containsObject:@"language"]
           && [jsonDic.allKeys containsObject:@"html_url"]){
            _itemID = [jsonDic[@"id"] longValue];
            _starCount = [jsonDic[@"stargazers_count"] longValue];
            _name = jsonDic[@"name"];
            _language = jsonDic[@"language"];
            _projectHome = jsonDic[@"html_url"];
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
    return [NSString stringWithFormat:@"id = %ld\nstart = %ld\nname= %@\nlanguage= %@\nprojectHome= %@\n", _itemID, _starCount, _name, _language, _projectHome];
}

@end
