//
//  ObjectFactory.m
//  GitHubSearch
//
//  Created by alanc on 09/09/2019.
//  Copyright © 2019 刘文楠. All rights reserved.
//

#import "ObjectFactory.h"
#import "ClassUtil.h"
#import "IphoneViewProtocol.h"
#import "IpadViewProtocol.h"

@implementation ObjectFactory

+(id)objectForProtocols:(NSArray<Protocol *> *)protocols{
    NSSet<Class> *classes = [[ClassUtil sharedInstance] allClassesImplementedProtocal:protocols];
    if(!classes || 0 == classes.count){
        NSString *errMsg = [NSString stringWithFormat:@"There is no implementation in current context, protocols = %@", protocols];
        @throw [NSException exceptionWithName:@"object creating exception" reason:errMsg userInfo:nil];
    }
    else if(classes.count > 1){
        NSString *errMsg =  [NSString stringWithFormat:@"There is multiple implementations in current context, protocols = %@", protocols];
        @throw [NSException exceptionWithName:@"object creating exception" reason:errMsg userInfo:nil];
    }
    
    Class targetClass = [[classes allObjects] objectAtIndex:0];
    return [targetClass new];
}

+(UIView *)viewForProtocols:(NSArray<Protocol *> *)protocols{
    NSMutableArray *pArray = [[NSMutableArray alloc] initWithArray:protocols];
    
    NSString *deviceType = [[UIDevice currentDevice] model]; // for current device
    if([deviceType isEqualToString:@"iPhone"]){
        [pArray addObject:@protocol(IphoneViewProtocol)];
    }
    else if([deviceType isEqualToString:@"iPad"]){
        [pArray addObject:@protocol(IpadViewProtocol)];
    }
    else{
        NSString *errMsg = [NSString stringWithFormat:@"There is no implementation view in current context, protocols = %@", protocols];
        @throw [NSException exceptionWithName:@"object creating exception" reason:errMsg userInfo:nil];
    }
    
    return [self objectForProtocols:pArray];
}

@end
