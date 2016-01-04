//
//  PathMacros.h
//  SinaProj
//
//  Created by 杨丽娟 on 15/12/24.
//  Copyright © 2015年 Qin.Yu. All rights reserved.
//

#ifndef PathMacros_h
#define PathMacros_h

#define kPathTemp                   NSTemporaryDirectory()

#define kPathDocument               [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0]

#define kPathCache                  [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0]

#define kPathSearch                 [kPathDocument stringByAppendingPathComponent:@"Search.plist"]
#define accoutPathSearch                 [kPathDocument stringByAppendingPathComponent:@"account.dat"]

#define ArchiveAccount(account) [NSKeyedArchiver archiveRootObject:account toFile:accoutPathSearch]
#define unArchiveAccount() [NSKeyedUnarchiver unarchiveObjectWithFile:accoutPathSearch];

#define kPathMagazine               [kPathDocument stringByAppendingPathComponent:@"Magazine"]

#define kPathDownloadedMgzs         [kPathMagazine stringByAppendingPathComponent:@"DownloadedMgz.plist"]

#define kPathDownloadURLs           [kPathMagazine stringByAppendingPathComponent:@"DownloadURLs.plist"]

#define kPathOperation              [kPathMagazine stringByAppendingPathComponent:@"Operation.plist"]



#define kPathSplashScreen           [kPathCache stringByAppendingPathComponent:@"splashScreen"]

#endif /* PathMacros_h */
