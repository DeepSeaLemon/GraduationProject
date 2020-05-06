//
//  NSDate+GP.h
//  GraduationProject
//
//  Created by CYM on 2020/4/30.
//  Copyright © 2020年 CYM. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSDate (GP)

// 获取本周的7天日期
+ (NSArray *)getCurrentWeekDays;

// 获取当前是周几（中国标准 周日是7）
+ (NSInteger)getCurrentWeekDayCN;

// 获取本周的第一天
+ (NSDate *)getFirstDayOfWeek;

// 计算时间相差几天
+ (NSInteger)calculationTimeDifferenceWith:(NSDate *)startDate endDate:(NSDate *)endDate;

// 计算时间相差几秒
+ (NSInteger)calculationTimeDifferenceSecondWith:(NSDate *)startDate endDate:(NSDate *)endDate;

// 获取当前时间戳
+ (NSString *)getNowTimeTimestamp;

// 获取今年年份
+ (NSInteger)getThisYear;

// 获取当前时间的年月日时分秒
+ (void)getNowTime:(void(^)(NSNumber *year))year month:(void(^)(NSNumber *month))month day:(void(^)(NSNumber *day))day date:(void(^)(NSString *dateStr))dateStr time:(void(^)(NSString *timeStr))time;

// 对时间进行加减
+ (NSString *)setAadditionSubtractionWithTimeInterval:(NSTimeInterval)secsToBeAdded sinceTime:(NSString *)sinceTime;

// 比较时间与当前时间的关系
+ (BOOL)compareDateWithNow:(NSString *)time;

// 距离当前时间多少秒
+ (int)computingTimeWith:(NSString *)startTimeStr;

@end

NS_ASSUME_NONNULL_END
