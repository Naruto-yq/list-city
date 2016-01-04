//
//  UIBarButtonItem+QJBarButtonItem.h
//  SinaProj
//
//  Created by 杨丽娟 on 15/12/26.
//  Copyright © 2015年 Qin.Yu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (QJBarButtonItem)
+ (UIBarButtonItem *)barButtonItemWithImage:(NSString *)imageName selectedImageName:(NSString *)selectedImageName taget:(id)taget action:(SEL)action;
@end
