//
//  QJMainTabBarController.m
//  SinaProj
//
//  Created by 杨丽娟 on 15/12/24.
//  Copyright © 2015年 Qin.Yu. All rights reserved.
//

#import "QJMainTabBarController.h"
#import "QJNavigationController.h"
#import "QJHomeViewController.h"
#import "QJMessageViewController.h"
#import "QJMeViewController.h"
#import "QJDiscoverViewController.h"
#import "QJComposeViewController.h"
#import "UIImage+QJImage.h"
#import "QJTabBar.h"

@interface QJMainTabBarController ()<QJTabBarDelegate>

@property(nonatomic, weak) QJTabBar *customTabBar;
@end

@implementation QJMainTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //init tabbar
    [self SetupTabbar];
    
    [self SetupAllControllers];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    for (UIView *child in self.tabBar.subviews) {
        if ([child isKindOfClass:[UIControl class]]) {
            [child removeFromSuperview];
        }
    }
}

- (void)SetupTabbar
{
    QJTabBar *customerTabBar = [[QJTabBar alloc]init];
    customerTabBar.frame = self.tabBar.bounds;
    customerTabBar.delegate = self;
    self.customTabBar = customerTabBar;
    [self.tabBar addSubview:self.customTabBar];
}

- (void)SetupAllControllers
{
    NSArray *titlesString = @[@"首页", @"消息", @"广场", @"我"];
    NSArray *imageString = @[@"tabbar_home", @"tabbar_message_center", @"tabbar_discover", @"tabbar_profile"];
    NSArray *seletedImageString = @[@"tabbar_home_selected", @"tabbar_message_center_selected", @"tabbar_discover_selected", @"tabbar_profile_selected"];
    
    QJHomeViewController *homeVc = [[QJHomeViewController alloc]init];
    //homeVc.tabBarItem.badgeValue = @"10";
    QJMessageViewController *MsgVc = [[QJMessageViewController alloc]init];
    //MsgVc.tabBarItem.badgeValue = @"19";
    QJDiscoverViewController *discoverVc = [[QJDiscoverViewController alloc]init];
    //discoverVc.tabBarItem.badgeValue = @"19";
    QJMeViewController *meVc = [[QJMeViewController alloc]init];
    //meVc.tabBarItem.badgeValue = @"90";
    NSArray *viewControllers = @[homeVc, MsgVc, discoverVc, meVc];
    for (int nIndex = 0; nIndex < viewControllers.count; nIndex++) {
        [self setupChildViewController:viewControllers[nIndex] title:titlesString[nIndex] imageName:imageString[nIndex] selectedImageName:seletedImageString[nIndex]];
    }
    

}
#pragma mark -- init child controller
- (void)setupChildViewController:(UIViewController *)childVc title:(NSString *)title imageName:(NSString*)imageName selectedImageName:(NSString *)selectedImageName
{
    childVc.title = title;
    childVc.tabBarItem.image = [UIImage imageWithName:imageName];
    if (iOS7_OR_LATER) {
        childVc.tabBarItem.selectedImage = [[UIImage imageWithName:selectedImageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    }else{
        childVc.tabBarItem.selectedImage = [UIImage imageWithName:selectedImageName];
    }
    QJNavigationController *nav = [[QJNavigationController alloc]initWithRootViewController:childVc];
    [self addChildViewController:nav];
    
    [self.customTabBar addTabBarButtonWithItem:childVc.tabBarItem];
}

#pragma mark -- QJTabBar delegate
- (void)tabBar:(QJTabBar *)tabBar didSelectedButtonFrom:(long)FromBtnTag to:(long)toBtnTag
{
    self.selectedIndex = toBtnTag;
}

- (void)tabBarDidClickedPlusButton:(QJTabBar *)tabBar
{
    QJComposeViewController *composeVc = [[QJComposeViewController alloc]init];
    QJNavigationController *nav = [[QJNavigationController alloc]initWithRootViewController:composeVc];
    
    [self presentViewController:nav animated:YES completion:nil];
}
@end
