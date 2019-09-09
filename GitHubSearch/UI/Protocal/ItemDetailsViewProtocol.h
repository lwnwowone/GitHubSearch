//
//  ItemDetailsViewProtocol.h
//  GitHubSearch
//
//  Created by AlancLiu on 2019/9/9.
//  Copyright © 2019 刘文楠. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GitItemDataMeta.h"

@protocol ItemDetailsViewProtocol <NSObject>

@property (nonatomic, strong) GitItemDataMeta *dataMeta;

@end
