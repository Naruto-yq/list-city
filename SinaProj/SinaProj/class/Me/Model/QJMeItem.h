//
//  QJMeItem.h
//  SinaProj
//
//  Created by 杨丽娟 on 16/1/7.
//  Copyright © 2016年 Qin.Yu. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^QJMeItemOperation) ();

@interface QJMeItem : NSObject
@property(nonatomic, copy)NSString *icon;
@property(nonatomic, copy)NSString *title;
@property(nonatomic, copy)NSString *subtitle ;
@property(nonatomic, copy)QJMeItemOperation operation;
@property (nonatomic, copy) NSString *badgeValue;

+ (instancetype)itemWithIcon:(NSString *)icon title:(NSString *)title;
+ (instancetype)itemWithTitle:(NSString *)title;
+ (instancetype)item;
@end
