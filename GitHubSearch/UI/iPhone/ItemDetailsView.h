//
//  ItemDetailsView.h
//  GitHubSearch
//
//  Created by AlancLiu on 2019/9/9.
//  Copyright © 2019 刘文楠. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ItemDetailsViewProtocol.h"
#import "IphoneViewProtocol.h"
#import "GitItemDataMeta.h"

@interface ItemDetailsView : UIView<ItemDetailsViewProtocol, IphoneViewProtocol>

@property (nonatomic, strong) GitItemDataMeta *dataMeta;

@end
