//
//  ActionResult.m
//  GitHubSearch
//
//  Created by alanc on 08/09/2019.
//  Copyright © 2019 刘文楠. All rights reserved.
//

#import "ActionResult.h"

@implementation ActionResult

-(id)init{
    self = [super init];
    _isSucceeded = false;
    _statusCode = 9999;
    _errorMsg = @"uniinitialized error";
    return self;
}

-(void)setIsSucceeded:(bool)isSucceeded{
    _isSucceeded = isSucceeded;
    if(isSucceeded){
        _statusCode = 0;
        _errorMsg = @"";
    }
}

-(bool)readErrorMsg:(ActionResult *)actionResult{
    if(actionResult.isSucceeded){
        NSLog(@"#### Warning tring to read succeeded result! ####");
        return false;
    }
    _isSucceeded = false;
    _statusCode = actionResult.statusCode;
    _errorMsg = actionResult.errorMsg;
    return true;
}

@end
