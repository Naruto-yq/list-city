//
//  QJNewfeatureController.m
//  SinaProj
//
//  Created by 杨丽娟 on 15/12/28.
//  Copyright © 2015年 Qin.Yu. All rights reserved.
//

#import "QJNewfeatureController.h"
#import "QJMainTabBarController.h"

#define NewFeatureImageCount 3

@interface QJNewfeatureController ()<UIScrollViewDelegate>
@property(nonatomic, weak) UIPageControl *pageCtl;
@end

@implementation QJNewfeatureController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //add a background
//    UIImageView *bgImage = [[UIImageView alloc]init];
//    bgImage.image = [UIImage imageWithName:@"new_feature_background"];
//    bgImage.frame = self.view.bounds;
//    [self.view addSubview:bgImage];
    //self.view.backgroundColor = RGB(246, 246, 246);
    
    [self SetupScrollView];
    
    [self SetupPageControl];
    
}

- (void)SetupScrollView
{
    UIScrollView * scrollView = [[UIScrollView alloc]init];
    scrollView.frame = self.view.bounds;
    [self.view addSubview:scrollView];
    
    CGFloat imageW = scrollView.frame.size.width;
    CGFloat imageH= scrollView.frame.size.height;
    for (int nIndex = 0; nIndex < NewFeatureImageCount; nIndex++) {
        UIImageView *imageView = [[UIImageView alloc] init];
        NSString *imageName = [NSString stringWithFormat:@"new_feature_%d", nIndex+1];
        imageView.image = [UIImage imageNamed:imageName];
        CGFloat imageX = nIndex * imageW;
        imageView.frame = CGRectMake(imageX, 0, imageW, imageH);
        [scrollView addSubview: imageView];
        
        if (nIndex == NewFeatureImageCount - 1) {
            [self SetupLastImageView:imageView];
        }
    }
    
    scrollView.contentSize = CGSizeMake(imageW *NewFeatureImageCount, 0);
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.pagingEnabled = YES;
    scrollView.bounces = NO;
    scrollView.delegate = self;
}


- (void)SetupLastImageView:(UIImageView *)imageView
{
    imageView.userInteractionEnabled = YES;
    
    UIButton *startBtn = [[UIButton alloc]init];
    [startBtn setBackgroundImage:[UIImage imageWithName:@"new_feature_finish_button"] forState:UIControlStateNormal];
    [startBtn setBackgroundImage:[UIImage imageWithName:@"new_feature_finish_button_highlighted"] forState:UIControlStateHighlighted];
    CGFloat startBtnX = self.view.frame.size.width * 0.5;
    CGFloat startBtnY = self.view.frame.size.height*0.6;
    startBtn.center = CGPointMake(startBtnX, startBtnY);
    startBtn.bounds = (CGRect){CGPointZero, startBtn.currentBackgroundImage.size};
    [startBtn setTitle:@"立即体验" forState:UIControlStateNormal];
    [startBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [startBtn addTarget:self action:@selector(Newfeature_Click_StartBtn) forControlEvents:UIControlEventTouchUpInside];
    [imageView addSubview:startBtn];
    
    UIButton *checkBtn = [[UIButton alloc]init];
    [checkBtn setTitle:@"分享给好友" forState:UIControlStateNormal];
    checkBtn.titleLabel.font = [UIFont systemFontOfSize:12];
    [checkBtn setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    checkBtn.selected = YES;
    [checkBtn setImage:[UIImage imageNamed:@"new_feature_share_true"] forState:UIControlStateSelected];
    [checkBtn setImage:[UIImage imageNamed:@"new_feature_share_false"] forState:UIControlStateNormal];
    checkBtn.bounds = startBtn.bounds;
    CGFloat checkBtnX = self.view.frame.size.width * 0.5;
    CGFloat checkBtnY = self.view.frame.size.height*0.5;
    checkBtn.center = CGPointMake(checkBtnX, checkBtnY);
    checkBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
    [checkBtn addTarget:self action:@selector(Newfeature_Click_CheckBtn:) forControlEvents:UIControlEventTouchUpInside];
    [imageView addSubview:checkBtn];
}

- (void)Newfeature_Click_StartBtn
{
    APPD.statusBarHidden = NO;
    //两种方法
    //self.view.window.rootViewController = [[QJMainTabBarController alloc]init];
    APPD.keyWindow.rootViewController = [[QJMainTabBarController alloc]init];
}

- (void)Newfeature_Click_CheckBtn: (UIButton *)checkBtn
{
    checkBtn.selected = !checkBtn.isSelected;
}


- (void)SetupPageControl
{
    UIPageControl *pageCtl = [[UIPageControl alloc]init];
    pageCtl.numberOfPages = NewFeatureImageCount;
    CGFloat pageCenterX = self.view.frame.size.width * 0.5;
    CGFloat pageCenterY = self.view.frame.size.height - 30;
    pageCtl.center = CGPointMake(pageCenterX, pageCenterY);
    pageCtl.bounds = CGRectMake(0, 0, 100, 30);
    pageCtl.userInteractionEnabled = NO;
    pageCtl.currentPageIndicatorTintColor = RGB(253, 98, 42);//[UIColor colorWithPatternImage:[UIImage imageNamed:@"new_feature_pagecontrol_checked_point"]];
    pageCtl.pageIndicatorTintColor = RGB(189, 189, 189);//[UIColor colorWithPatternImage:[UIImage imageNamed:@"new_feature_pagecontrol_point"]];
#warning---   //用图片使用自定义的pagectl，以后写
    
    [self.view addSubview:pageCtl];
    self.pageCtl = pageCtl;
}


#pragma -- scrollView delegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat offsetX = scrollView.contentOffset.x;
    double dPageNum = offsetX/scrollView.frame.size.width;
    int nPageNum = (int)(dPageNum + 0.5);
    self.pageCtl.currentPage = nPageNum;
}

@end
