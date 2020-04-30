//
//  NSDate+GP.m
//  GraduationProject
//
//  Created by CYM on 2020/4/30.
//  Copyright © 2020年 CYM. All rights reserved.
//

#import "NSDate+GP.h"

@implementation NSDate (GP)

+ (NSInteger)calculationTimeDifferenceWith:(NSDate *)startDate endDate:(NSDate *)endDate {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSCalendarUnit type = NSCalendarUnitDay;
    NSDateComponents *cmps = [calendar components:type fromDate:startDate toDate:endDate options:0];
    return cmps.day;
}

+ (NSDate *)getFirstDayOfWeek {
    NSDate *nowDate = [NSDate date];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *comp = [calendar components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitWeekday  fromDate:nowDate];
    // 获取今天是周几(外国标准 1是周日)
    NSInteger weekDay = [comp weekday];
    // 计算当前日期和本周的星期一和星期天相差天数
    long firstDiff,lastDiff;
    if (weekDay == 1){
        firstDiff = -6;
        lastDiff = 0;
    } else {
        firstDiff = [calendar firstWeekday] - weekDay + 1;
        lastDiff = 8 - weekDay;
    }
    // 从现在开始的24小时
    NSTimeInterval secondsPerDay = firstDiff * 24 * 60 * 60;
    NSDate *curDate = [NSDate dateWithTimeIntervalSinceNow:secondsPerDay];
    return curDate;
}

+ (NSInteger)getCurrentWeekDayCN {
    NSDate *nowDate = [NSDate date];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *comp = [calendar components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitWeekday  fromDate:nowDate];
    // 获取今天是周几(外国标准 1是周日)
    NSInteger weekDay = [comp weekday];
    if (weekDay == 1) {
        return 7;
    } else {
        return weekDay - 1;
    }
}

+ (NSArray *)getCurrentWeekDays {
    NSDate *nowDate = [NSDate date];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *comp = [calendar components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitWeekday  fromDate:nowDate];
    // 获取今天是周几(外国标准 1是周日)
    NSInteger weekDay = [comp weekday];
    // 计算当前日期和本周的星期一和星期天相差天数
    long firstDiff,lastDiff;
    if (weekDay == 1){
        firstDiff = -6;
        lastDiff = 0;
    } else {
        firstDiff = [calendar firstWeekday] - weekDay + 1;
        lastDiff = 8 - weekDay;
    }
    // 设定起止时间
    NSMutableArray *eightArr = [[NSMutableArray alloc] init];
    for (NSInteger i = firstDiff; i < lastDiff + 1; i ++) {
        //从现在开始的24小时
        NSTimeInterval secondsPerDay = i * 24*60*60;
        NSDate *curDate = [NSDate dateWithTimeIntervalSinceNow:secondsPerDay];
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"MM-dd"];
        NSString *dateStr = [dateFormatter stringFromDate:curDate];
        [dateFormatter setLocale:[NSLocale localeWithLocaleIdentifier:@"zn_CN"]];
        NSString *strTime = [NSString stringWithFormat:@"%@",dateStr];
        [eightArr addObject:strTime];
    }
    return eightArr;
}

@end
