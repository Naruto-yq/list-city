//
//  QJStatus.m
//  SinaProj
//
//  Created by 杨丽娟 on 15/12/29.
//  Copyright © 2015年 Qin.Yu. All rights reserved.
//  一个status对象一条微博

#import "QJStatus.h"
#import "MJExtension.h"
#import "QJPhoto.h"

#define DeltaWithNow(calendar, createDate) [calendar components:(NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond) fromDate:createDate toDate:[NSDate date] options:0]
@implementation QJStatus
- (NSDictionary *)objectClassInArray
{
    return @{@"pic_urls": [QJPhoto class]};
}


- (NSString *)created_at
{
    NSDateFormatter *fmt = [[NSDateFormatter alloc]init];
                    //"Tue May 31 17:46:55 +0800 2011"
    fmt.dateFormat = @"EEE MMM dd HH:mm:ss Z yyyy";
    
    // 设置格式本地化,日期格式字符串需要知道是哪个国家的日期，才知道怎么转换
    fmt.locale = [NSLocale localeWithLocaleIdentifier:@"en_us"];
    
    NSDate *createDate = [fmt dateFromString:_created_at];
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    if([calendar isDateInToday:createDate]){
        if (DeltaWithNow(calendar, createDate).hour >= 1) {
            return [NSString stringWithFormat:@"%d小时前", (int)DeltaWithNow(calendar, createDate).hour];
        }else if(DeltaWithNow(calendar, createDate).minute >= 1){
            return [NSString stringWithFormat:@"%d分钟前", (int)DeltaWithNow(calendar, createDate).minute];
        }else{
            return @"刚刚";
        }
    }else if([calendar isDateInYesterday:createDate]){
        fmt.dateFormat = @"昨天 HH:mm";
        return [fmt stringFromDate:createDate];
    }else if([calendar isDateInWeekend:createDate]){
        fmt.dateFormat = @"MM-dd HH:mm";
        return [fmt stringFromDate:createDate];
    }else{
        fmt.dateFormat = @"yyyy-MM-dd HH:mm";
        return [fmt stringFromDate:createDate];
    }
}

//使用set方法而不用get方法，原因是滚动tableview刷新时只调用一次（字典转模型时调用），get会时时调用
- (void)setSource:(NSString *)source
{
    int loc = (int)[source rangeOfString:@">"].location + 1;
    int length = (int)[source rangeOfString:@"</"].location -loc;
    _source = [NSString stringWithFormat:@"来自%@", [source substringWithRange:NSMakeRange(loc, length)]];
}

//+ (instancetype)statusWithDict:(NSDictionary *)dict;
//{
//    return [[self alloc]initWithDict:dict];
//}
//
//- (instancetype)initWithDict:(NSDictionary *)dict
//{
//    if (self = [super init]) {
//        self.idstr = dict[@"idstr"];
//        self.text = dict[@"text"];
//        self.source = dict[@"source"];
//        self.reposts_count = [dict[@"reposts_count"] intValue];
//        self.comments_count = [dict[@"comments_count"] intValue];
//        self.user = [QJUser userWithDict:dict[@"user"]];
//    }
//    return self;
//}
@end


