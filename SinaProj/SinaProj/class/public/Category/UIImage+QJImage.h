//
//  UIImage+QJImage.h
//  SinaProj
//
//  Created by 杨丽娟 on 15/12/25.
//  Copyright © 2015年 Qin.Yu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (QJImage)
+ (instancetype)imageWithName:(NSString *)imageName;
//拉伸图片
+ (UIImage *)resizedImageWithName:(NSString *)imageName;

+ (UIImage *)resizedImageWithName:(NSString *)imageName left:(CGFloat)left top:(CGFloat)top;
@end
