//
//  QJStatusTool.m
//  SinaProj
//
//  Created by 杨丽娟 on 16/1/4.
//  Copyright © 2016年 Qin.Yu. All rights reserved.
//

#import "QJStatusTool.h"
#import "QJHttpTool.h"
#import "QJHomeStatusesResult.h"
#import "QJHomeStatusParam.h"
#import "MJExtension.h"

@implementation QJStatusTool

+ (void)homeStatusWithParam:(QJHomeStatusParam *)param success:(void (^)(QJHomeStatusesResult *))success failure:(void (^)(NSError *))failure
{
    
    [QJHttpTool getWithURL:QJAPPGet_Status_Url params:param.keyValues success:^(id responseJson) {
        if (success) {
            QJHomeStatusesResult *result = [QJHomeStatusesResult objectWithKeyValues:responseJson];
            success(result);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];

}
@end
