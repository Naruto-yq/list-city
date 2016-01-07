//
//  QJSettingViewController.h
//  SinaProj
//
//  Created by 杨丽娟 on 16/1/7.
//  Copyright © 2016年 Qin.Yu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QJMeGroupItem.h"
#import "QJMeArrowItem.h"
#import "QJMeSwitchItem.h"

@class QJMeGroupItem;
@interface QJSettingViewController : UITableViewController
@property (strong, nonatomic) NSMutableArray *groups;

- (QJMeGroupItem *)addGroup;
@end
