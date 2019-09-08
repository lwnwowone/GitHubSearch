//
//  ActionResult.h
//  GitHubSearch
//
//  Created by alanc on 08/09/2019.
//  Copyright © 2019 刘文楠. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ActionResult<T> : NSObject

@property (nonatomic, assign) bool isSucceeded;
@property (nonatomic, assign) long statusCode;
@property (nonatomic, strong) NSString *errorMsg;
@property (nonatomic, strong) T data;

-(bool)readErrorMsg:(ActionResult *)actionResult;

@end
