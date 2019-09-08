//
//  ClassUtil.h
//  GitHubSearch
//
//  Created by alanc on 09/09/2019.
//  Copyright © 2019 刘文楠. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ClassUtil : NSObject

+(instancetype)sharedInstance;

@property (nonatomic, strong) NSSet<Class> *allClasses;

-(NSSet<Class> *)allClassesImplementedProtocal:(NSArray<Protocol *> *)protocols;

@end
