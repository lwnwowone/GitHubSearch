//
//  ViewUtil.h
//  GitHubSearch
//
//  Created by alanc on 09/09/2019.
//  Copyright © 2019 刘文楠. All rights reserved.
//

#import <UIKit/UIKit.h>

static float topBarHeight = 0;

@interface ViewUtil : NSObject

+(void)showAlertAtController:(UIViewController *)vc
                       title:(NSString *)title
                     message:(NSString *)message;

+(void)setTopBarHeight:(float)height;

+(float)topBarHeight;

@end
