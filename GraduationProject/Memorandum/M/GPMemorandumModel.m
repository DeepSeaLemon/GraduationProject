//
//  GPMemorandumModel.m
//  GraduationProject
//
//  Created by CYM on 2020/5/5.
//  Copyright © 2020年 CYM. All rights reserved.
//

#import "GPMemorandumModel.h"

@implementation GPMemorandumModel

- (instancetype)initWith:(NSString *)content startTime:(NSString *)startTime endTime:(NSString *)endTime isCountDown:(BOOL)isCountDown isRemind:(BOOL)isRemind isEveryday:(BOOL)isEveryday timeAhead:(NSInteger)timeAhead {
    if (self = [super init]) {
        self.content = content;
        self.startTime = startTime;
        self.endTime = endTime;
        if (isRemind) {
            self.remindTime = [NSDate setAadditionSubtractionWithTimeInterval:(0 - timeAhead*60) sinceTime:startTime];
        } else {
            self.remindTime = @"";
        }
        self.isCountDown = [NSNumber numberWithBool:isCountDown];
        self.isRemind = [NSNumber numberWithBool:isRemind];
        self.isEveryday = [NSNumber numberWithBool:isEveryday];
        self.numberStr = [NSDate getNowTimeTimestamp];
        self.sortTime = [NSNumber numberWithInt:[NSDate computingTimeWith:startTime]];
    }
    return self;
}

@end
