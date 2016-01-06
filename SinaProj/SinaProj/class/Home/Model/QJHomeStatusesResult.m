//
//  QJHomeStatusesResult.m
//  SinaProj
//
//  Created by 杨丽娟 on 16/1/5.
//  Copyright © 2016年 Qin.Yu. All rights reserved.
//

#import "QJHomeStatusesResult.h"
#import "QJStatus.h"
#import "MJExtension.h"

@implementation QJHomeStatusesResult
- (NSDictionary *)objectClassInArray
{
    return @{@"statuses": [QJStatus class]};
}

@end
