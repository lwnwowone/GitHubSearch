//
//  ObjectFactory.h
//  GitHubSearch
//
//  Created by alanc on 09/09/2019.
//  Copyright © 2019 刘文楠. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ObjectFactory : NSObject

+(id)objectForProtocols:(NSArray<Protocol *> *)protocols;

@end