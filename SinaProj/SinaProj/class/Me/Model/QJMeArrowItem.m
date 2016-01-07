//
//  QJMeArrowItem.m
//  SinaProj
//
//  Created by 杨丽娟 on 16/1/7.
//  Copyright © 2016年 Qin.Yu. All rights reserved.
//

#import "QJMeArrowItem.h"

@implementation QJMeArrowItem
+ (instancetype)itemWithIcon:(NSString *)icon title:(NSString *)title destVcClass:(Class)destVcClass
{
    QJMeArrowItem *item = [self itemWithIcon:icon title:title];
    item.destVcClass = destVcClass;
    return item;
}

+ (instancetype)itemWithTitle:(NSString *)title destVcClass:(Class)destVcClass
{
    return [self itemWithIcon:nil title:title destVcClass:destVcClass];
}
@end
