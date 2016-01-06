//
//  APIStringMacros.h
//  SinaProj
//
//  Created by 杨丽娟 on 15/12/24.
//  Copyright © 2015年 Qin.Yu. All rights reserved.
//

#ifndef APIStringMacros_h
#define APIStringMacros_h

//接口名称相关
#define QJAPPKey @"110611978"

#define QJAPPRedirect_Url @"http://ios.itcast.cn"

#define QJAPP_POST_ForAccessToken @"https://api.weibo.com/oauth2/access_token"

#define QJAPPLoginUrl [NSString stringWithFormat:@"https://api.weibo.com/oauth2/authorize?client_id=%@&redirect_uri=%@", QJAPPKey, QJAPPRedirect_Url]

#define QJAPPGet_Status_Url @"https://api.weibo.com/2/statuses/home_timeline.json"

#define QJAPPGet_User_Url @"https://api.weibo.com/2/users/show.json"

#define QJAPP_POST_Compose_Status @"https://api.weibo.com/2/statuses/update.json"

#define QJAPP_POST_Compose_Picture_Status @"https://upload.api.weibo.com/2/statuses/upload.json"

#define QJAPP_GET_Unread_count @"https://rm.api.weibo.com/2/remind/unread_count.json"
#endif /* APIStringMacros_h */
