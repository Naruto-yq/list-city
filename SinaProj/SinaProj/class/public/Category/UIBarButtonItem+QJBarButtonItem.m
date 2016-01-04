//
//  UIBarButtonItem+QJBarButtonItem.m
//  SinaProj
//
//  Created by 杨丽娟 on 15/12/26.
//  Copyright © 2015年 Qin.Yu. All rights reserved.
//

#import "UIBarButtonItem+QJBarButtonItem.h"
#import "UIImage+QJImage.h"

@implementation UIBarButtonItem (QJBarButtonItem)

+ (UIBarButtonItem *)barButtonItemWithImage:(NSString *)imageName selectedImageName:(NSString *)selectedImageName taget:(id)taget action:(SEL)action
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setBackgroundImage:[UIImage imageWithName:imageName] forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageWithName:selectedImageName] forState:UIControlStateHighlighted];
    button.frame = (CGRect){CGPointZero, button.currentBackgroundImage.size};
    [button addTarget:taget action:action forControlEvents:UIControlEventTouchUpInside];
    return [[UIBarButtonItem alloc]initWithCustomView:button];

}
@end
