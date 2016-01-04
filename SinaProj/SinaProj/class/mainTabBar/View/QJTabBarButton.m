//
//  QJTabBarButton.m
//  SinaProj
//
//  Created by 杨丽娟 on 15/12/26.
//  Copyright © 2015年 Qin.Yu. All rights reserved.
//

#import "QJTabBarButton.h"
#import "UIImage+QJImage.h"
#import "QJBageButton.h"

//image ratio
#define QJTabBarButtonImageRatio 0.6

@interface QJTabBarButton ()
@property(nonatomic, weak) QJBageButton *bageBtn;
@end

@implementation QJTabBarButton

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //只需要设置一次的放置在这里
        self.imageView.contentMode = UIViewContentModeCenter;
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.titleLabel.font = [UIFont systemFontOfSize:11];
        [self setTitleColor:RGB(248, 139, 0) forState:UIControlStateSelected];
        
        if (!iOS7_OR_LATER) {
            [self setBackgroundImage:[UIImage imageWithName:@"tabbar_slider"] forState:UIControlStateSelected];
        }
        else
        {
            [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        }
        
        QJBageButton *bageBtn = [[QJBageButton alloc]init];
        [bageBtn setImage:[UIImage resizedImageWithName:@"main_badge"] forState:UIControlStateNormal];
        bageBtn.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleBottomMargin;
        bageBtn.userInteractionEnabled = NO;
        [bageBtn.titleLabel setFont:[UIFont systemFontOfSize:11]];
        self.bageBtn = bageBtn;
        [self addSubview:self.bageBtn];
        
    }
    return self;
}

//重写该方法可以去除长按按钮时出现的高亮效果
- (void)setHighlighted:(BOOL)highlighted
{
    
}

-(CGRect)imageRectForContentRect:(CGRect)contentRect
{
    CGFloat imageW = contentRect.size.width;
    CGFloat imageH = contentRect.size.height*QJTabBarButtonImageRatio;
    
    return CGRectMake(0, 0, imageW, imageH);
}

-(CGRect)titleRectForContentRect:(CGRect)contentRect
{
    CGFloat titleY = contentRect.size.height*QJTabBarButtonImageRatio;
    CGFloat titleW = contentRect.size.width;
    CGFloat titleH = contentRect.size.height - titleY;
    
    return CGRectMake(0, titleY, titleW, titleH);
}

- (void)setTabBarItem:(UITabBarItem *)tabBarItem
{
    _tabBarItem = tabBarItem;
    // KVO 监听属性改变
    [tabBarItem addObserver:self forKeyPath:@"badgeValue" options:0 context:nil];
    
    [self observeValueForKeyPath:nil ofObject:nil change:nil context:nil];
}

- (void)dealloc
{
    [self.tabBarItem removeObserver:self forKeyPath:@"badgeValue"];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context
{
    [self setTitle:self.tabBarItem.title forState:UIControlStateNormal];
    [self setImage:self.tabBarItem.image forState:UIControlStateNormal];
    [self setImage:self.tabBarItem.selectedImage forState:UIControlStateSelected];
    
    self.bageBtn.badgeValue = self.tabBarItem.badgeValue;
    // 设置提醒数字的位置
    CGFloat badgeY = 5;
    CGFloat badgeX = self.frame.size.width - self.bageBtn.frame.size.width - 10;
    CGRect badgeF = self.bageBtn.frame;
    badgeF.origin.x = badgeX;
    badgeF.origin.y = badgeY;
    self.bageBtn.frame = badgeF;
}
@end
