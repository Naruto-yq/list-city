//
//  QJHttpTool.m
//  SinaProj
//
//  Created by 杨丽娟 on 16/1/4.
//  Copyright © 2016年 Qin.Yu. All rights reserved.
//

#import "QJHttpTool.h"
#import "AFNetworking.h"

@implementation QJHttpTool



+ (void)getWithURL:(NSString *)url params:(NSDictionary *)params success:(void(^)(id))success failure:(void(^)(NSError *))failure
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    [manager GET:url parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (success) {
            success(responseObject);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (failure) {
            failure(error);
        }
    }];

}

+ (void)postWithURL:(NSString *)url params:(NSDictionary *)params success:(void(^)(id))success failure:(void(^)(NSError *))failure
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    [manager POST:url parameters:params success:^(AFHTTPRequestOperation *operation, NSDictionary *responseObject) {
        if (success) {
            success(responseObject);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (failure) {
            failure(error);
        }
    }];

    
}

+ (void)postWithURL:(NSString *)url params:(NSDictionary *)params imageArray:(NSArray *)imageArray success:(void(^)(id))success failure:(void(^)(NSError *))failure
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    [manager POST:url parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        for (UIImage *image in imageArray) {
            NSData *data = UIImageJPEGRepresentation(image, 0.0001);
            [formData appendPartWithFileData:data name:@"pic" fileName:@"" mimeType:@"image/jpeg"];
        }
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (success) {
            success(responseObject);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
    
}
@end
