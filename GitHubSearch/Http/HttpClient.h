//
//  HttpClient.h
//  GitHubSearch
//
//  Created by alanc on 08/09/2019.
//  Copyright © 2019 刘文楠. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ActionResult.h"

@interface HttpClient : NSObject

-(ActionResult *)getWithURLString:(NSString *)url query:(NSDictionary *)quertDic;

@end
