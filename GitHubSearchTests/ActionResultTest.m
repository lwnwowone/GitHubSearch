//
//  ActionResultTest.m
//  GitHubSearchTests
//
//  Created by alanc on 08/09/2019.
//  Copyright © 2019 刘文楠. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "ActionResult.h"

@interface ActionResultTest : XCTestCase

@end

@implementation ActionResultTest

-(void)test_init{
    ActionResult *result = [ActionResult new];
    
    XCTAssertFalse(result.isSucceeded);
    XCTAssertTrue(9999 == result.statusCode);
    XCTAssertTrue([result.errorMsg isEqualToString:@"uniinitialized error"]);
    XCTAssertNil(result.data);
}

-(void)test_updateState{
    ActionResult *result = [ActionResult new];
    result.isSucceeded = true;
    
    XCTAssertTrue(result.isSucceeded);
    XCTAssertTrue(0 == result.statusCode);
    XCTAssertTrue([result.errorMsg isEqualToString:@""]);
    XCTAssertNil(result.data);
}

-(void)test_readErrorSucceeded{
    ActionResult *resultO = [ActionResult new];
    resultO.statusCode = 1;
    resultO.errorMsg = @"error_msg";
    
    ActionResult *result = [ActionResult new];
    XCTAssertTrue([result readErrorMsg:resultO]);
    XCTAssertFalse(result.isSucceeded);
    XCTAssertTrue(1 == result.statusCode);
    XCTAssertTrue([result.errorMsg isEqualToString:@"error_msg"]);
}

-(void)test_readErrorFailed{
    ActionResult *resultO = [ActionResult new];
    resultO.isSucceeded = true;
    
    ActionResult *result = [ActionResult new];
    XCTAssertFalse([result readErrorMsg:resultO]);
}

@end
