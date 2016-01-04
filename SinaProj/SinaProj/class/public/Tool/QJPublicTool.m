//
//  QJPublicTool.m
//  SinaProj
//
//  Created by 杨丽娟 on 15/12/29.
//  Copyright © 2015年 Qin.Yu. All rights reserved.
//

#import "QJPublicTool.h"
#import "QJMainTabBarController.h"
#import "QJNewfeatureController.h"

@implementation QJPublicTool
+ (void)chooseRootViewController
{
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    NSString *lastVersion = [userDefault stringForKey:@"lastVerSion"];
    NSString *curVersion = [NSBundle mainBundle].infoDictionary[@"CFBundleVersion"];
    
    if ([curVersion isEqualToString:lastVersion]) {
        APPD.statusBarHidden = YES;
        APPD.keyWindow.rootViewController = [[QJMainTabBarController alloc]init];
    }else{
        APPD.keyWindow.rootViewController = [[QJNewfeatureController alloc]init];
        [userDefault setObject:curVersion forKey:@"lastVerSion"];
        [userDefault synchronize];
    }

}
@end
