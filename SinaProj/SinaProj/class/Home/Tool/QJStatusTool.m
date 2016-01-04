//
//  QJStatusTool.m
//  SinaProj
//
//  Created by 杨丽娟 on 16/1/4.
//  Copyright © 2016年 Qin.Yu. All rights reserved.
//

#import "QJStatusTool.h"
#import "QJHttpTool.h"

@implementation QJStatusTool

+ (void)homeStatusWithParams:(NSDictionary *)params success:(void (^)(id response))success failure:(void (^)(NSError *error))failure
{
    [QJHttpTool getWithURL:QJAPPGet_Status_Url params:params success:^(id responseJson) {
        if (success) {
            success(responseJson);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];

}
@end
