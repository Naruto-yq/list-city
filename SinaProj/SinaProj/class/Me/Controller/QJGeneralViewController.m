//
//  QJGeneralViewController.m
//  SinaProj
//
//  Created by 杨丽娟 on 16/1/7.
//  Copyright © 2016年 Qin.Yu. All rights reserved.
//

#import "QJGeneralViewController.h"
#import "MBProgressHUD+MJ.h"
#import "SDWebImageManager.h"

@implementation QJGeneralViewController
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setupGroup0];
    [self setupGroup1];
    [self setupGroup2];
    [self setupGroup3];
    [self setupGroup4];
}

- (void)setupGroup0
{
    QJMeGroupItem *group = [self addGroup];
    
    QJMeArrowItem *read = [QJMeArrowItem itemWithTitle:@"阅读模式" destVcClass:nil];
    
    QJMeArrowItem *font = [QJMeArrowItem itemWithTitle:@"字号大小" destVcClass:nil];
    
    QJMeSwitchItem *mark = [QJMeSwitchItem itemWithTitle:@"显示备注"];
    
    group.items = @[read, font, mark];
}

- (void)setupGroup1
{
    QJMeGroupItem *group = [self addGroup];
    
    QJMeArrowItem *picture = [QJMeArrowItem itemWithTitle:@"图片质量设置" destVcClass:nil];
    group.items = @[picture];
}

- (void)setupGroup2
{
    QJMeGroupItem *group = [self addGroup];
    
    QJMeSwitchItem *voice = [QJMeSwitchItem itemWithTitle:@"声音"];
    group.items = @[voice];
}

- (void)setupGroup3
{
    QJMeGroupItem *group = [self addGroup];
    
    QJMeSwitchItem *language = [QJMeSwitchItem itemWithTitle:@"多语言环境"];
    group.items = @[language];
}

- (void)setupGroup4
{
    QJMeGroupItem *group = [self addGroup];
    
    QJMeArrowItem *clearCache = [QJMeArrowItem itemWithTitle:@"清除图片缓存"];
    clearCache.operation = ^{
        // 弹框
        [MBProgressHUD showMessage:@"哥正在帮你拼命清理中..."];
        
        // 执行清除缓存
        NSFileManager *mgr = [NSFileManager defaultManager];
        NSString *cachePath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
        [mgr removeItemAtPath:cachePath error:nil];
        
        // 关闭弹框
        [MBProgressHUD hideHUD];

        [MBProgressHUD showMessage:@"清楚成功"];
        
        [MBProgressHUD hideHUD];

        // 计算缓存文件夹的大小
        //        NSArray *subpaths = [mgr subpathsAtPath:cachePath];
        //        long long totalSize = 0;
        //        for (NSString *subpath in subpaths) {
        //            NSString *fullpath = [cachePath stringByAppendingPathComponent:subpath];
        //            BOOL dir = NO;
        //            [mgr fileExistsAtPath:fullpath isDirectory:&dir];
        //            if (dir == NO) {// 文件
        //                totalSize += [[mgr attributesOfItemAtPath:fullpath error:nil][NSFileSize] longLongValue];
        //            }
        //        }
    };
    
    QJMeArrowItem *clearHistory = [QJMeArrowItem itemWithTitle:@"清空搜索历史"];
    group.items = @[clearCache, clearHistory];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.tableView reloadData];
}
@end
