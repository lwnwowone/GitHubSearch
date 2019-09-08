//
//  HttpClientTest.m
//  GitHubSearchTests
//
//  Created by alanc on 08/09/2019.
//  Copyright © 2019 刘文楠. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <OHHTTPStubs/OHHTTPStubs.h>
#import "HttpClient.h"

@interface HttpClientTest : XCTestCase

@end

@implementation HttpClientTest

-(void)test_getInternalError{
    HttpClient *client = [HttpClient new];
    ActionResult<NSString *> *httpResult = [client getWithURLString:@"http://unknown_host.com:12345/unknown_path" query:nil];
    
    XCTAssertNotNil(httpResult);
    XCTAssertFalse(httpResult.isSucceeded);
    XCTAssertTrue(9999 == httpResult.statusCode);
    XCTAssertTrue(httpResult.errorMsg.length > 0);
    XCTAssertTrue(nil == httpResult.data);
}

-(void)test_getDataSucceeded{
    [OHHTTPStubs stubRequestsPassingTest:^BOOL(NSURLRequest *request) {
        return [request.URL.host isEqualToString:@"www.test_host_success.com"];
    } withStubResponse:^OHHTTPStubsResponse*(NSURLRequest *request) {
        return [OHHTTPStubsResponse responseWithData:[@"Test_response" dataUsingEncoding:NSUTF8StringEncoding]
                                          statusCode:200
                                             headers:@{@"Content-Type":@"application/json"}];
    }];
    
    HttpClient *client = [HttpClient new];
    ActionResult<NSString *> *httpResult = [client getWithURLString:@"http://www.test_host_success.com" query:nil];
    
    XCTAssertNotNil(httpResult);
    XCTAssertTrue(httpResult.isSucceeded);
    XCTAssertTrue(200 == httpResult.statusCode);
    XCTAssertTrue(0 == httpResult.errorMsg.length);
    XCTAssertTrue(httpResult.data.length > 0);
}

-(void)test_getData500Error{
    [OHHTTPStubs stubRequestsPassingTest:^BOOL(NSURLRequest *request) {
        return [request.URL.host isEqualToString:@"www.test_host_fail.com"];
    } withStubResponse:^OHHTTPStubsResponse*(NSURLRequest *request) {
        return [OHHTTPStubsResponse responseWithData:[@"Test_error_response" dataUsingEncoding:NSUTF8StringEncoding]
                                          statusCode:500
                                             headers:@{@"Content-Type":@"application/json"}];
    }];
    
    HttpClient *client = [HttpClient new];
    ActionResult<NSString *> *httpResult = [client getWithURLString:@"http://www.test_host_fail.com" query:nil];
    
    XCTAssertNotNil(httpResult);
    XCTAssertFalse(httpResult.isSucceeded);
    XCTAssertTrue(500 == httpResult.statusCode);
    XCTAssertTrue(httpResult.errorMsg.length > 0);
    XCTAssertTrue(nil == httpResult.data);
}

-(void)test_getDataWithParameterSucceeded{
    [OHHTTPStubs stubRequestsPassingTest:^BOOL(NSURLRequest *request) {
        return [request.URL.query isEqualToString:@"key0=value0"];
    } withStubResponse:^OHHTTPStubsResponse*(NSURLRequest *request) {
        return [OHHTTPStubsResponse responseWithData:[@"Test_response" dataUsingEncoding:NSUTF8StringEncoding]
                                          statusCode:200
                                             headers:@{@"Content-Type":@"application/json"}];
    }];

    HttpClient *client = [HttpClient new];
    ActionResult<NSString *> *httpResult = [client getWithURLString:@"http://www.test_host.com" query:@{@"key0":@"value0"}];
    
    XCTAssertNotNil(httpResult);
    XCTAssertTrue(httpResult.isSucceeded);
    XCTAssertTrue(200 == httpResult.statusCode);
    XCTAssertTrue(0 == httpResult.errorMsg.length);
    XCTAssertTrue(httpResult.data.length > 0);
}

@end
