//
//  HttpUtilTest.m
//  GitHubSearchTests
//
//  Created by alanc on 08/09/2019.
//  Copyright © 2019 刘文楠. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "HttpUtil.h"

@interface HttpUtilTest : XCTestCase

@end

@implementation HttpUtilTest

- (void)test_createHttpGetQueryByNullDictionary {
    NSDictionary *tmpDic = nil;

    NSString *queryStr = [HttpUtil queryStringFromDictionary:tmpDic];
    NSString *expectedQuertStr = @"";
    
    XCTAssertTrue([queryStr isEqualToString:expectedQuertStr]);
}

- (void)test_createHttpGetQueryByEmptyDictionary {
    NSDictionary *tmpDic = @{};
    
    NSString *queryStr = [HttpUtil queryStringFromDictionary:tmpDic];
    NSString *expectedQuertStr = @"";
    
    XCTAssertTrue([queryStr isEqualToString:expectedQuertStr]);
}

- (void)test_createHttpGetQueryBySingleeParameter {
    NSDictionary *tmpDic = @{@"key0":@"value0"};
    
    NSString *queryStr = [HttpUtil queryStringFromDictionary:tmpDic];
    NSString *expectedQuertStr = @"key0=value0";
    
    XCTAssertTrue([queryStr isEqualToString:expectedQuertStr]);
}

- (void)test_createHttpGetQueryByMultipleParameters {
    NSDictionary *tmpDic = @{@"key0":@"value0", @"key1":@"value1"};
    
    NSString *queryStr = [HttpUtil queryStringFromDictionary:tmpDic];
    
    NSString *expectedQuertStr = @"key0=value0&key1=value1";
    NSString *expectedQuertStr2 = @"key1=value1&key0=value0";
    
    XCTAssertTrue([queryStr isEqualToString:expectedQuertStr] || [queryStr isEqualToString:expectedQuertStr2]);
}

@end
