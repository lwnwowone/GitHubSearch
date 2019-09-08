//
//  ClassUtil.m
//  GitHubSearch
//
//  Created by alanc on 09/09/2019.
//  Copyright © 2019 刘文楠. All rights reserved.
//

#import "ClassUtil.h"
#import <objc/runtime.h>
#import <dlfcn.h>
#import <mach-o/ldsyms.h>

static ClassUtil *sharedInstance;

@implementation ClassUtil

+(instancetype)sharedInstance{
    if(!sharedInstance){
        sharedInstance = [self new];
    }
    return sharedInstance;
}

-(NSSet<Class> *)allClasses{
    if(!_allClasses){
        _allClasses = [self allClassesInProject];
    }
    return _allClasses;
}

-(NSSet<Class> *)allClassesImplementedProtocal:(NSArray<Protocol *> *)protocols{
    NSMutableSet *resultSet = [NSMutableSet new];
    
    NSSet<Class> *classes = [self allClasses];
    
    for (Class aClass in classes) {
        bool result = true;
        for (Protocol *protocol in protocols) {
            if(![aClass conformsToProtocol:protocol]){
                result = false;
            }
        }
        if(result){
            [resultSet addObject:aClass];
        }
    }
    
    return [resultSet copy];
}

-(NSSet<Class> *)allClassesInProject{
    NSMutableSet *resultSet = [NSMutableSet new];
    
    unsigned int classCount;
    const char **classes;
    Dl_info info;
    
    dladdr(&_mh_execute_header, &info);
    classes = objc_copyClassNamesForImage(info.dli_fname, &classCount);
    
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(1);
    dispatch_apply(classCount, dispatch_get_global_queue(0, 0), ^(size_t index) {
        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
        NSString *className = [NSString stringWithCString:classes[index] encoding:NSUTF8StringEncoding];
        Class class = NSClassFromString(className);
        [resultSet addObject:class];
        dispatch_semaphore_signal(semaphore);
    });
    
    return [resultSet copy];
}

@end
