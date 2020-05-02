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

// 获取当前时间戳
+ (NSString *)getNowTimeTimestamp;

@end

NS_ASSUME_NONNULL_END
