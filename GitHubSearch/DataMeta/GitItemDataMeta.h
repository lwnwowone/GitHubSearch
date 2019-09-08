//
//  GitItemDataMeta.h
//  GitHubSearch
//
//  Created by alanc on 08/09/2019.
//  Copyright © 2019 刘文楠. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ActionResult.h"

@interface GitItemDataMeta : NSObject

@property (nonatomic, assign) long itemID;
@property (nonatomic, assign) long starCount;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *language;
@property (nonatomic, strong) NSString *projectHome;

-(ActionResult *)loadDataFromJSON:(NSDictionary *)json;

@end
