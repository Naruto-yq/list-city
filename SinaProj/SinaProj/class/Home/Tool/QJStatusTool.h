//
//  QJStatusTool.h
//  SinaProj
//
//  Created by 杨丽娟 on 16/1/4.
//  Copyright © 2016年 Qin.Yu. All rights reserved.
//

#import <Foundation/Foundation.h>

@class QJHomeStatusParam, QJHomeStatusesResult;

@interface QJStatusTool : NSObject

+ (void)homeStatusWithParam:(QJHomeStatusParam *)param success:(void (^)(QJHomeStatusesResult *result))success failure:(void (^)(NSError *error))failure;

@end
