//
//  GPAccountMonthModel.m
//  GraduationProject
//
//  Created by CYM on 2020/5/3.
//  Copyright © 2020年 CYM. All rights reserved.
//

#import "GPAccountMonthModel.h"

@implementation GPAccountMonthModel

- (instancetype)init {
    if (self = [super init]) {
        self.payMoney = 0;
        self.incomeMoney = 0;
        self.month = 0;
    }
    return self;
}
@end
