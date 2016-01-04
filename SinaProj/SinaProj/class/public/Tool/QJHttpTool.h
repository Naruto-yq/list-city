//
//  QJHttpTool.h
//  SinaProj
//
//  Created by 杨丽娟 on 16/1/4.
//  Copyright © 2016年 Qin.Yu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QJHttpTool : NSObject

+ (void)getWithURL:(NSString *)url params:(NSDictionary *)params success:(void(^)(id response))success failure:(void(^)(NSError *error))failure;

+ (void)postWithURL:(NSString *)url params:(NSDictionary *)params success:(void(^)(id response))success failure:(void(^)(NSError *error))failure;

+ (void)postWithURL:(NSString *)url params:(NSDictionary *)params imageArray:(NSArray *)imageArray success:(void(^)(id response))success failure:(void(^)(NSError *error))failure;
@end
