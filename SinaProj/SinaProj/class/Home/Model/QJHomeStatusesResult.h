//
//  QJHomeStatusesResult.h
//  SinaProj
//
//  Created by 杨丽娟 on 16/1/5.
//  Copyright © 2016年 Qin.Yu. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface QJHomeStatusesResult : NSObject
@property(nonatomic, strong) NSArray *statuses;

@property(nonatomic, strong)NSNumber *previous_cursor;
@property(nonatomic, strong)NSNumber *next_cursor;
@property(nonatomic, strong)NSNumber *total_number;
@end
