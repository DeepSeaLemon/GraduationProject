//
//  GPAccountModel.m
//  GraduationProject
//
//  Created by CYM on 2020/5/3.
//  Copyright © 2020年 CYM. All rights reserved.
//

#import "GPAccountModel.h"

@implementation GPAccountModel

- (instancetype)initWith:(NSString *)amountStr isInput:(BOOL)isInput content:(NSString *)content {
    if (self = [super init]) {
        double money = [amountStr doubleValue];
        if (!isInput) {
            money = 0 - money;
        }
        self.amount = [NSNumber numberWithDouble:money];
        self.isInput = [NSNumber numberWithBool:isInput];
        self.content = content;
        [NSDate getNowTime:^(NSNumber * _Nonnull year) {
            self.year = year;
        } month:^(NSNumber * _Nonnull month) {
            self.month = month;
        } day:^(NSNumber * _Nonnull day) {
            self.day = day;
        } date:^(NSString * _Nonnull dateStr) {
            self.dateStr = dateStr;
        } time:^(NSString * _Nonnull timeStr) {
            self.timeStr = timeStr;
        }];
        self.numberStr = [NSDate getNowTimeTimestamp];
    }
    return self;
}

@end
