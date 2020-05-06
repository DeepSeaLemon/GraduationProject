//
//  NSDate+GP.m
//  GraduationProject
//
//  Created by CYM on 2020/4/30.
//  Copyright © 2020年 CYM. All rights reserved.
//

#import "NSDate+GP.h"

@implementation NSDate (GP)

+ (int)computingTimeWith:(NSString *)startTimeStr {
    NSDate *datenow = [NSDate date];
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    NSInteger unitFlags = NSCalendarUnitYear;
    comps = [calendar components:unitFlags fromDate:datenow];
    NSDateFormatter *dateFormater = [[NSDateFormatter alloc] init];
    [dateFormater setDateFormat:@"yyyy-MM-dd HH:mm"];
    NSDate *startDate = [dateFormater dateFromString:[NSString stringWithFormat:@"%ld-%@",(long)[comps year],startTimeStr]];
    //得到倒计时时间
    int timeout = (int)[NSDate calculationTimeDifferenceSecondWith:datenow endDate:startDate];
    return timeout;
}

+ (BOOL)compareDateWithNow:(NSString *)time {
    NSDate *datenow = [NSDate date];
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    NSInteger unitFlags = NSCalendarUnitYear;
    comps = [calendar components:unitFlags fromDate:datenow];
    NSDateFormatter *dateFormater = [[NSDateFormatter alloc] init];
    [dateFormater setDateFormat:@"yyyy-MM-dd HH:mm"];
    NSDate *endTimeDate = [dateFormater dateFromString:[NSString stringWithFormat:@"%ld-%@",(long)[comps year],time]];
    NSComparisonResult result = [datenow compare:endTimeDate];
    if (result == NSOrderedSame){
        return NO;
    } else if (result == NSOrderedAscending) {
        // 现在时间大于开始时间
        return YES;
    } else if (result == NSOrderedDescending) {
        // 现在时间小于开始时间
        return NO;
    }
    return NO;
}

+ (NSString *)setAadditionSubtractionWithTimeInterval:(NSTimeInterval)secsToBeAdded sinceTime:(NSString *)sinceTime {
    NSDateFormatter *dateFormater = [[NSDateFormatter alloc] init];
    [dateFormater setDateFormat:@"MM-dd HH:mm"];
    NSDate *sinceTimeDate = [dateFormater dateFromString:sinceTime];
    NSDate *afterDate = [[NSDate alloc] initWithTimeInterval:secsToBeAdded sinceDate:sinceTimeDate];
    return [dateFormater stringFromDate:afterDate];
}

+ (NSInteger)calculationTimeDifferenceWith:(NSDate *)startDate endDate:(NSDate *)endDate {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSCalendarUnit type = NSCalendarUnitDay;
    NSDateComponents *cmps = [calendar components:type fromDate:startDate toDate:endDate options:0];
    return cmps.day;
}

+ (NSInteger)calculationTimeDifferenceSecondWith:(NSDate *)startDate endDate:(NSDate *)endDate {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSCalendarUnit type = NSCalendarUnitSecond;
    NSDateComponents *cmps = [calendar components:type fromDate:startDate toDate:endDate options:0];
    return cmps.second;
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


+ (NSString *)getNowTimeTimestamp{
    NSDate *datenow = [NSDate date];
    NSString *timeSp = [NSString stringWithFormat:@"%ld", (long)[datenow timeIntervalSince1970]];
    return timeSp;
}

+ (void)getNowTime:(void(^)(NSNumber *year))year month:(void(^)(NSNumber *month))month day:(void(^)(NSNumber *day))day date:(void(^)(NSString *dateStr))dateStr time:(void(^)(NSString *timeStr))time {
    NSDate *datenow = [NSDate date];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"HH:mm:ss"];
    NSString *currentTimeString = [formatter stringFromDate:datenow];
    !time?:time(currentTimeString);
    
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSString *currentDateString = [formatter stringFromDate:datenow];
    !dateStr?:dateStr(currentDateString);
    
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    NSInteger unitFlags = NSCalendarUnitYear |NSCalendarUnitMonth |NSCalendarUnitDay;
    comps = [calendar components:unitFlags fromDate:datenow];
    !year?:year([NSNumber numberWithInteger:[comps year]]);
    !month?:month([NSNumber numberWithInteger:[comps month]]);
    !day?:day([NSNumber numberWithInteger:[comps day]]);
}

+ (NSInteger)getThisYear {
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    NSInteger unitFlags = NSCalendarUnitYear;
    NSDate *datenow = [NSDate date];
    comps = [calendar components:unitFlags fromDate:datenow];
    return [comps year];
}
@end
