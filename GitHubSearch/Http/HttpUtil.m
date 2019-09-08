//
//  HttpUtil.m
//  GitHubSearch
//
//  Created by alanc on 08/09/2019.
//  Copyright © 2019 刘文楠. All rights reserved.
//

#import "HttpUtil.h"

@implementation HttpUtil

+(NSString *)queryStringFromDictionary:(NSDictionary *)queryParameters{
    NSString *result = @"";
    if(queryParameters && queryParameters.allKeys.count > 0){
        for (NSString *key in queryParameters.allKeys) {
            NSString *value = queryParameters[key];
            NSString *tmpStr = [NSString stringWithFormat:@"%@=%@&", key, value];
            result = [result stringByAppendingString:tmpStr];
        }
        result = [result substringWithRange:NSMakeRange(0, result.length - 1)];
    }
    return result;
}

@end
