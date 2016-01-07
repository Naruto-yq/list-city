//
//  QJStatueCacheTool.h
//  SinaProj
//
//  Created by 杨丽娟 on 16/1/6.
//  Copyright © 2016年 Qin.Yu. All rights reserved.
//

#import <Foundation/Foundation.h>

@class QJHomeStatusParam;

@interface QJStatueCacheTool : NSObject

+ (void)addStatues:(NSDictionary *)dict;

+ (void)addStatuses:(NSArray *)dictArray;

+ (NSArray *)statuesWithParam:(QJHomeStatusParam *)param;
@end
