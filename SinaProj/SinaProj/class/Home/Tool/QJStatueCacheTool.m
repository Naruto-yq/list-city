//
//  QJStatueCacheTool.m
//  SinaProj
//
//  Created by 杨丽娟 on 16/1/6.
//  Copyright © 2016年 Qin.Yu. All rights reserved.
//

#import "QJStatueCacheTool.h"
#import "QJAccount.h"
#import "QJHomeStatusParam.h"
#import "FMDB.h"

@implementation QJStatueCacheTool
static FMDatabaseQueue *_queue;
+ (void)setup
{
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
    NSString *file = [path stringByAppendingPathComponent:@"statuses.sqlite"];
    _queue = [FMDatabaseQueue databaseQueueWithPath:file];
    
    [_queue inDatabase:^(FMDatabase *db) {
        [db executeUpdate:@"create table if not exists t_status (id integer primary key autoincrement, access_token text, idstr text, dict blob);"];
    }];
}


+ (void)addStatues:(NSDictionary *)dict
{
    
    [self setup];
    QJAccount *account = unArchiveAccount();
    
    [_queue inDatabase:^(FMDatabase *db) {
        NSString *access_token = account.access_token;
        NSString *idstr = dict[@"idstr"];
        NSData *data = [NSKeyedArchiver archivedDataWithRootObject:dict];
        [db executeUpdate:@"insert into t_status (access_token, idstr, dict) values(?, ?, ?)", access_token, idstr, data];
    }];
    [_queue close];
}

+ (void)addStatuses:(NSArray *)dictArray
{
    for (NSDictionary *dict in dictArray) {
        [self addStatues:dict];
    }
}


+ (NSArray *)statuesWithParam:(QJHomeStatusParam *)param
{
    __block NSMutableArray *dicArray = nil;
    QJAccount *account = unArchiveAccount();
    NSString *access_token = account.access_token;
    
    
    [self setup];
    
    [_queue inDatabase:^(FMDatabase *db) {
        dicArray = [NSMutableArray array];
        
        FMResultSet *rs = nil;
        if (param.since_id) {
            rs = [db executeQuery:@"select * from t_status where access_token = ? and idstr > ? order by idstr desc limit 0,?;", access_token, param.since_id, param.count];
        }else if(param.max_id){
            rs = [db executeQuery:@"select * from t_status where access_token = ? and idstr <= ? order by idstr desc limit 0,?;", access_token, param.max_id, param.count];
        }else{
            rs = [db executeQuery:@"select * from t_status where access_token = ? order by idstr desc limit 0,?;", access_token, param.count];
        }
        
        while (rs.next) {
            NSData *data = [rs dataForColumn:@"dict"];
            NSDictionary *dict = [NSKeyedUnarchiver unarchiveObjectWithData:data];
            [dicArray addObject:dict];
        }
    }];
    
    [_queue close];
    return dicArray;
}
@end
