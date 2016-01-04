//
//  QJStatusTool.h
//  SinaProj
//
//  Created by 杨丽娟 on 16/1/4.
//  Copyright © 2016年 Qin.Yu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QJStatusTool : NSObject

+ (void)homeStatusWithParams:(NSDictionary *)params success:(void (^)(id response))success failure:(void (^)(NSError *error))failure;

@end
