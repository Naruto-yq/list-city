//
//  QJMeItem.m
//  SinaProj
//
//  Created by 杨丽娟 on 16/1/7.
//  Copyright © 2016年 Qin.Yu. All rights reserved.
//

#import "QJMeItem.h"

@implementation QJMeItem
+ (instancetype)itemWithIcon:(NSString *)icon title:(NSString *)title
{
    QJMeItem *item = [self item];
    item.icon = icon;
    item.title = title;
    return item;
}

+ (instancetype)itemWithTitle:(NSString *)title
{
    return [self itemWithIcon:nil title:title];
}

+ (instancetype)item
{
    return [[self alloc]init];
}
@end
