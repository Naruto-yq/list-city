//
//  QJTabBar.m
//  SinaProj
//
//  Created by 杨丽娟 on 15/12/25.
//  Copyright © 2015年 Qin.Yu. All rights reserved.
//

#import "QJTabBar.h"
#import "UIImage+QJImage.h"
#import "QJTabBarButton.h"

@interface QJTabBar ()
@property(nonatomic, strong)NSMutableArray *tabBarBtnArray;
@property(nonatomic, weak) UIButton *plusBtn;
@property(nonatomic, weak) QJTabBarButton *selectedBtn;
@end

@implementation QJTabBar

-(NSMutableArray *)tabBarBtnArray
{
    if (_tabBarBtnArray == nil) {
        _tabBarBtnArray = [NSMutableArray array];
    }
    return _tabBarBtnArray;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        if (!iOS7_OR_LATER) {
            self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageWithName:@"tabbar_background"]];
        }
        UIButton *plusBtn = [[UIButton alloc]init];
        [plusBtn setBackgroundImage:[UIImage imageWithName:@"tabbar_compose_button"] forState:UIControlStateNormal];
        [plusBtn setBackgroundImage:[UIImage imageWithName:@"tabbar_compose_button_highlighted"] forState:UIControlStateHighlighted];
        [plusBtn setImage:[UIImage imageNamed:@"tabbar_compose_icon_add"] forState:UIControlStateNormal];
        [plusBtn setImage:[UIImage imageNamed:@"tabbar_compose_icon_add_highlighted"] forState:UIControlStateHighlighted];
        plusBtn.bounds = CGRectMake(0, 0, plusBtn.currentBackgroundImage.size.width, plusBtn.currentBackgroundImage.size.height);
        [plusBtn addTarget:self action:@selector(TabBar_plusBtn_Click) forControlEvents:UIControlEventTouchUpInside];
        self.plusBtn = plusBtn;
        [self addSubview:self.plusBtn];

    }
    return self;
}

- (void)TabBar_plusBtn_Click
{
    if ([self.delegate respondsToSelector: @selector(tabBarDidClickedPlusButton:)]) {
        [self.delegate tabBarDidClickedPlusButton:self];
    }
}

- (void)addTabBarButtonWithItem:(UITabBarItem *)tabBarItem
{
    QJTabBarButton *button = [[QJTabBarButton alloc]init];
    [self addSubview:button];
    [self.tabBarBtnArray addObject:button];
    button.tabBarItem = tabBarItem;
    
    [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchDown];
    
    //默认选中第0个按钮
    if (self.tabBarBtnArray.count == 1) {
        [self buttonClick:button];
    }
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.plusBtn.center = CGPointMake(self.frame.size.width*0.5, self.frame.size.height*0.5);
    
    CGFloat buttonW = self.frame.size.width/self.subviews.count;
    CGFloat buttonH = self.frame.size.height;
    CGFloat buttonY = 0;
    
    for (int nIndex = 0; nIndex < self.tabBarBtnArray.count; nIndex++) {
        CGFloat buttonX = buttonW*nIndex;
        QJTabBarButton *button = self.tabBarBtnArray[nIndex];
        if (nIndex > 1) {
            buttonX += buttonW;
        }
        button.frame = CGRectMake(buttonX, buttonY, buttonW, buttonH);
        button.tag = nIndex;
    }
}

- (void)buttonClick:(QJTabBarButton *)button
{
    if ([self.delegate respondsToSelector:@selector(tabBar:didSelectedButtonFrom:to:)]) {
        [self.delegate tabBar:self didSelectedButtonFrom:self.selectedBtn.tag to:button.tag];
    }
    
    self.selectedBtn.selected = NO;
    button.selected = YES;
    self.selectedBtn = button;
}
@end
