//
//  ObjectFactory.m
//  GitHubSearch
//
//  Created by alanc on 09/09/2019.
//  Copyright © 2019 刘文楠. All rights reserved.
//

#import "ObjectFactory.h"
#import "ClassUtil.h"

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

@end
