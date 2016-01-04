//
//  UIImage+QJImage.m
//  SinaProj
//
//  Created by 杨丽娟 on 15/12/25.
//  Copyright © 2015年 Qin.Yu. All rights reserved.
//

#import "UIImage+QJImage.h"

@implementation UIImage (QJImage)

+ (UIImage *)imageWithName:(NSString *)imageName
{
    if (iOS7_OR_LATER) {
        NSString *newImageName = [imageName stringByAppendingString:@"_os7"];
        UIImage *image = [UIImage imageNamed:newImageName];
        if(image == nil){
            image = [UIImage imageNamed:imageName];
        }
        return image;
    }
    return [UIImage imageNamed:imageName];
}

+ (UIImage *)resizedImageWithName:(NSString *)imageName
{
    return [self resizedImageWithName:imageName left:0.5 top:0.5];
}

+ (UIImage *)resizedImageWithName:(NSString *)imageName left:(CGFloat)left top:(CGFloat)top
{
    UIImage *image = [self imageWithName:imageName];
    return [image stretchableImageWithLeftCapWidth:image.size.width*left topCapHeight:image.size.height*top];
}
@end
