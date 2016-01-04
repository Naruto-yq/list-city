//
//  QJStatusCell.h
//  SinaProj
//
//  Created by 杨丽娟 on 15/12/29.
//  Copyright © 2015年 Qin.Yu. All rights reserved.
//

#import <UIKit/UIKit.h>

@class QJStatusFrame;
@interface QJStatusCell : UITableViewCell
+ (instancetype)cellWithTableView:(UITableView *)tableView;
@property(nonatomic, strong)QJStatusFrame *statusFrame;
@end
