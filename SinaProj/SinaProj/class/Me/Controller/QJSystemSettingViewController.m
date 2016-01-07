//
//  QJSystemSettingViewController.m
//  SinaProj
//
//  Created by 杨丽娟 on 16/1/7.
//  Copyright © 2016年 Qin.Yu. All rights reserved.
//

#import "QJSystemSettingViewController.h"
#import "QJGeneralViewController.h"

@implementation QJSystemSettingViewController
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"设置";
    
    [self setupGroup0];
    [self setupGroup1];
    [self setupGroup2];
    [self setupGroup3];
    
    [self setupFooter];
}

- (void)setupFooter
{
    // 按钮
    UIButton *logoutButton = [[UIButton alloc] init];
    CGFloat logoutX = 5 + 2;
    CGFloat logoutY = 10;
    CGFloat logoutW = self.tableView.frame.size.width - 2 * logoutX;
    CGFloat logoutH = 44;
    logoutButton.frame = CGRectMake(logoutX, logoutY, logoutW, logoutH);
    
    // 背景和文字
    [logoutButton setBackgroundImage:[UIImage resizedImageWithName:@"common_button_red"] forState:UIControlStateNormal];
    [logoutButton setBackgroundImage:[UIImage resizedImageWithName:@"common_button_red_highlighted"] forState:UIControlStateHighlighted];
    [logoutButton setTitle:@"退出当前帐号" forState:UIControlStateNormal];
    logoutButton.titleLabel.font = [UIFont systemFontOfSize:14];
    [logoutButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    // footer
    UIView *footer = [[UIView alloc] init];
    CGFloat footerH = logoutH + 20;
    footer.frame = CGRectMake(0, 0, 0, footerH);
    self.tableView.tableFooterView = footer;
    [footer addSubview:logoutButton];
}

- (void)setupGroup0
{
    QJMeGroupItem *group = [self addGroup];
    
    QJMeArrowItem *account = [QJMeArrowItem itemWithTitle:@"帐号管理"];
    group.items = @[account];
}

- (void)setupGroup1
{
    QJMeGroupItem *group = [self addGroup];
    
    QJMeArrowItem *theme = [QJMeArrowItem itemWithTitle:@"主题、背景" destVcClass:nil];
    group.items = @[theme];
}

- (void)setupGroup2
{
    QJMeGroupItem *group = [self addGroup];
    
    QJMeArrowItem *notice = [QJMeArrowItem itemWithTitle:@"通知和提醒"];
    QJMeArrowItem *general = [QJMeArrowItem itemWithTitle:@"通用设置" destVcClass:[QJGeneralViewController class]];
    QJMeArrowItem *safe = [QJMeArrowItem itemWithTitle:@"隐私与安全"];
    group.items = @[notice, general, safe];
}

- (void)setupGroup3
{
    QJMeGroupItem *group = [self addGroup];
    
    QJMeArrowItem *opinion = [QJMeArrowItem itemWithTitle:@"意见反馈"];
    QJMeArrowItem *about = [QJMeArrowItem itemWithTitle:@"关于微博"];
    group.items = @[opinion, about];
}

@end
