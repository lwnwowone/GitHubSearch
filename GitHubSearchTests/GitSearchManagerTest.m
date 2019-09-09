//
//  GitSearchManagerTest.m
//  GitHubSearchTests
//
//  Created by alanc on 08/09/2019.
//  Copyright © 2019 刘文楠. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <OCMock/OCMock.h>
#import "GitSearchDataManager.h"

@interface GitSearchManagerTest : XCTestCase

@end

@implementation GitSearchManagerTest

- (void)test_getDefaultPage {
    NSString *mockFilePath = [[NSBundle mainBundle] pathForResource:@"mock_git_search_result" ofType:@"json"];
    NSString *mockResponse = [NSString stringWithContentsOfFile:mockFilePath encoding:NSUTF8StringEncoding error:nil];
    
    ActionResult *mockHttpResult = [ActionResult new];
    mockHttpResult.isSucceeded = true;
    mockHttpResult.statusCode = 200;
    mockHttpResult.data = mockResponse;
    
    HttpClient *mockClient = OCMClassMock(HttpClient.class);
    OCMStub([mockClient getWithURLString:OCMOCK_ANY query:OCMOCK_ANY]).andReturn(mockHttpResult);
    
    GitSearchDataManager *manager = [GitSearchDataManager new];
    manager.httpClient = mockClient;
    ActionResult<GitSearchAPIDataMeta *> *searchResult = [manager searchWithKeyWord:@"cocoahttp" page:1];
    
    XCTAssertTrue(searchResult.isSucceeded);
    XCTAssertTrue(27 == searchResult.data.totalCount);
    XCTAssertFalse(searchResult.data.incompleteResults);
    XCTAssertTrue(10 == searchResult.data.items.count);
}

- (void)test_getLastPage {
    NSString *mockFilePath = [[NSBundle mainBundle] pathForResource:@"mock_git_search_last_page_result" ofType:@"json"];
    NSString *mockResponse = [NSString stringWithContentsOfFile:mockFilePath encoding:NSUTF8StringEncoding error:nil];
    
    ActionResult *mockHttpResult = [ActionResult new];
    mockHttpResult.isSucceeded = true;
    mockHttpResult.statusCode = 200;
    mockHttpResult.data = mockResponse;
    
    HttpClient *mockClient = OCMClassMock(HttpClient.class);
    OCMStub([mockClient getWithURLString:OCMOCK_ANY query:OCMOCK_ANY]).andReturn(mockHttpResult);
    
    GitSearchDataManager *manager = [GitSearchDataManager new];
    manager.httpClient = mockClient;
    ActionResult<GitSearchAPIDataMeta *> *searchResult = [manager searchWithKeyWord:@"cocoahttp" page:3];
    
    XCTAssertTrue(searchResult.isSucceeded);
    XCTAssertTrue(27 == searchResult.data.totalCount);
    XCTAssertFalse(searchResult.data.incompleteResults);
    XCTAssertTrue(7 == searchResult.data.items.count);
}

@end
