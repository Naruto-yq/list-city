//
//  QJTabBar.h
//  SinaProj
//
//  Created by 杨丽娟 on 15/12/25.
//  Copyright © 2015年 Qin.Yu. All rights reserved.
//

#import <UIKit/UIKit.h>
@class QJTabBar;
@protocol QJTabBarDelegate <NSObject>

@optional
- (void)tabBar:(QJTabBar *)tabBar didSelectedButtonFrom:(long)FromBtnTag to:(long)toBtnTag;

- (void)tabBarDidClickedPlusButton:(QJTabBar *)tabBar;
@end

@interface QJTabBar : UIView

@property(nonatomic, weak) id<QJTabBarDelegate> delegate;

- (void)addTabBarButtonWithItem:(UITabBarItem *)tabBarItem;

@end
