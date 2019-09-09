//
//  GitHubSearchUITests.m
//  GitHubSearchUITests
//
//  Created by AlancLiu on 2019/9/9.
//  Copyright © 2019 刘文楠. All rights reserved.
//

#import <XCTest/XCTest.h>

@interface GitHubSearchUITests : XCTestCase

@end

@implementation GitHubSearchUITests{
    @private XCUIApplication *app;
}

-(void)setUp{
    app = [[XCUIApplication alloc] init];
    [app launch];
}

-(void)testBasicUIElementCheck{
    XCUIElement *navBar = [app.navigationBars elementBoundByIndex:0];
    XCUIElement *titleView = [navBar.otherElements elementBoundByIndex:0];
    XCTAssertTrue([titleView.label isEqualToString:@"GitHubSearch"]);
    
    XCUIElement *tfSearch = [app.textFields elementBoundByIndex:0];
    XCTAssertTrue([tfSearch.value isEqualToString:@"Input search key"]);
    
    XCUIElement *mainTable = app.tables[@"data_list"];
    XCTAssertTrue ([mainTable exists]);
    
    XCUIElement *btnPre = app.buttons[@"btn_pre"];
    XCTAssertTrue([btnPre exists]);
    XCTAssertFalse([btnPre isEnabled]);
    
    XCUIElement *lbPageInfo = app.staticTexts[@"lb_page_info"];
    XCTAssertTrue([lbPageInfo exists]);
    
    XCUIElement *btnNext = app.buttons[@"btn_next"];
    XCTAssertTrue ([btnNext exists]);
    XCTAssertFalse([btnNext isEnabled]);
}

@end
