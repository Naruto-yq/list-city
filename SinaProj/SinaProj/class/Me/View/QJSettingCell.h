//
//  QJSettingCell.h
//  SinaProj
//
//  Created by 杨丽娟 on 16/1/7.
//  Copyright © 2016年 Qin.Yu. All rights reserved.
//

#import <UIKit/UIKit.h>

@class QJMeItem;
@interface QJSettingCell : UITableViewCell
@property (strong, nonatomic) QJMeItem *item;
@property (nonatomic, strong) NSIndexPath *indexPath;
+ (instancetype)cellWithTableView:(UITableView *)tableView;
@end
