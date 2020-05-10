//
//  GPCurriculumModel.m
//  GraduationProject
//
//  Created by CYM on 2020/4/28.
//  Copyright © 2020年 CYM. All rights reserved.
//

#import "GPCurriculumModel.h"

@implementation GPCurriculumModel

- (instancetype)init {
    if (self = [super init]) {
        self.week = -1;
        self.section = -1;
        self.curriculum = @"";
        self.classroom = @"";
        self.teacher = @"";
        self.curriculum2 = @"";
        self.classroom2 = @"";
        self.teacher2 = @"";
        self.isDouble = NO;
        self.isSingle = NO;
        self.numberStr = @"";
    }
    return self;
}

@end
