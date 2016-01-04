//
//  DimensMacros.h
//  SinaProj
//
//  Created by 杨丽娟 on 15/12/24.
//  Copyright © 2015年 Qin.Yu. All rights reserved.
//

#ifndef DimensMacros_h
#define DimensMacros_h


#define STATUS_BAR_HEIGHT 20

//NavBar高度

#define NAVIGATION_BAR_HEIGHT 44

//状态栏 ＋ 导航栏 高度

#define STATUS_AND_NAVIGATION_HEIGHT ((STATUS_BAR_HEIGHT) + (NAVIGATION_BAR_HEIGHT))


//屏幕 rect

#define SCREEN_RECT ([UIScreen mainScreen].bounds)


#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)


#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)


#define CONTENT_HEIGHT (SCREEN_HEIGHT - NAVIGATION_BAR_HEIGHT - STATUS_BAR_HEIGHT)

//屏幕分辨率

#define SCREEN_RESOLUTION (SCREEN_WIDTH * SCREEN_HEIGHT * ([UIScreen mainScreen].scale))



#endif /* DimensMacros_h */
