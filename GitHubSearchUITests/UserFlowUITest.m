//
//  UserFlowUITest.m
//  GitHubSearchUITests
//
//  Created by AlancLiu on 2019/9/9.
//  Copyright © 2019 刘文楠. All rights reserved.
//

#import <XCTest/XCTest.h>

#define DELAY_FOR_NETWORK_OPERATION 10 //increase it if you cannot get http response from github in time

@interface UserFlowUITest : XCTestCase

@end

@implementation UserFlowUITest{
    @private XCUIApplication *app;
}

-(void)setUp{
    app = [[XCUIApplication alloc] init];
    [app launch];
}

-(void)testUserSearchFlow{
    XCUIElement *mainTable = app.tables[@"data_list"];
    NSArray *cellsArray = [mainTable.cells allElementsBoundByIndex];
    XCTAssertTrue(0 == cellsArray.count);
    
    XCUIElement *lbPageInfo = app.staticTexts[@"lb_page_info"];
    XCTAssertTrue([lbPageInfo exists]);
    XCTAssertTrue([lbPageInfo.label isEqualToString:@"0 / 0"]);

    XCUIElement *tfSearch = [app.textFields elementBoundByIndex:0];
    [tfSearch tap];
    sleep(1);
    [tfSearch typeText:@"cocoahttp"];
    
    sleep(DELAY_FOR_NETWORK_OPERATION);//serval seconds for loading data
    
    cellsArray = [mainTable.cells allElementsBoundByIndex];
    XCTAssertTrue(20 == cellsArray.count); //20 is the max items count per page
    XCTAssertTrue([lbPageInfo.label isEqualToString:@"1 / 2"]);
    
    XCUIElement *firstCell = [cellsArray objectAtIndex:0];
    [firstCell tap];
    sleep(1);
    
    //Go into the details page
    XCUIElement *firstText = [app.staticTexts elementBoundByIndex:0];
    XCTAssertTrue([firstText.label isEqualToString:@"robbiehanson/CocoaHTTPServer"]);
    
    XCUIElement *firstButton = app.buttons[@"btn_project_home"];
    [firstButton tap];

    XCUIApplication *safari = [[XCUIApplication alloc] initWithBundleIdentifier:@"com.apple.mobilesafari"];
    XCTAssertTrue([safari waitForState:XCUIApplicationStateRunningForeground timeout:30]);
    
    XCUIElement *btnAddress = safari.buttons[@"URL"];
    [btnAddress tap];
    sleep(1);
    
    XCUIElement *tfAddress = safari.textFields[@"URL"];
    XCTAssertTrue([tfAddress.value isEqualToString:@"https://github.com/robbiehanson/CocoaHTTPServer"]);
    
    [app activate];
    sleep(1);
    
    XCUIElement *btnBack = app.buttons[@"GitHubSearch"];
    [btnBack tap];
    sleep(1);
    
    XCTAssertTrue([[tfSearch valueForKey:@"hasKeyboardFocus"] boolValue]);
    [mainTable swipeDown];
    sleep(3);
    XCTAssertFalse([[tfSearch valueForKey:@"hasKeyboardFocus"] boolValue]);

    XCUIElement *btnPre = app.buttons[@"btn_pre"];
    XCUIElement *btnNext = app.buttons[@"btn_next"];
    XCTAssertFalse(btnPre.enabled);
    XCTAssertTrue(btnNext.enabled);

    [btnNext tap];
    
    sleep(DELAY_FOR_NETWORK_OPERATION);//serval seconds for loading data
    
    cellsArray = [mainTable.cells allElementsBoundByIndex];
    XCTAssertTrue(cellsArray.count < 20); //27 total for now, not sure if it will be more, should smaller than 20
    
    lbPageInfo = app.staticTexts[@"lb_page_info"];
    XCTAssertTrue([lbPageInfo.label isEqualToString:@"2 / 2"]);
    
    NSLog(@"Test case - UserSearchFlow finished, stop in 3 seconds...");
    sleep(3);
}

@end
