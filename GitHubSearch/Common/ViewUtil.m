//
//  ViewUtil.m
//  GitHubSearch
//
//  Created by alanc on 09/09/2019.
//  Copyright © 2019 刘文楠. All rights reserved.
//

#import "ViewUtil.h"

@implementation ViewUtil

+(void)showAlertAtController:(UIViewController *)vc
                       title:(NSString *)title
                     message:(NSString *)message{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"Close" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        //Nothing but close the alert
    }];
    [alertController addAction:okAction];
    [vc presentViewController:alertController animated:YES completion:nil];
}

@end
