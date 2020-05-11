//
//  GPAccountViewModel.m
//  GraduationProject
//
//  Created by CYM on 2020/5/3.
//  Copyright © 2020年 CYM. All rights reserved.
//

#import "GPAccountViewModel.h"
#import "GPAccountModel.h"
#import "GPAccountMonthModel.h"

@implementation GPAccountViewModel

- (instancetype)initWithData {
    if (self = [super init]) {
        self.incomeMoney = 0;
        self.payMoney    = 0;
        self.statisticsPayMoney    = 0;
        self.statisticsIncomeMoney = 0;
        self.statisticsArray = [NSMutableArray array];
        [[DBTool shareInstance] getAccount:^(NSArray *accounts) {
            self.modelArray = [NSMutableArray arrayWithArray:accounts];
            [self calculationMoney];
        }];
        [self addObserver:self forKeyPath:@"modelArray" options:NSKeyValueObservingOptionNew context:nil];
    }
    return self;
}

- (void)calculateDataOfThisYear {
    self.statisticsIncomeMoney = 0;
    self.statisticsPayMoney = 0;
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    NSInteger unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth;
    NSDate *datenow = [NSDate date];
    comps = [calendar components:unitFlags fromDate:datenow];
    NSMutableArray <GPAccountModel *>*arr = [NSMutableArray array];
    for (GPAccountModel *model in self.modelArray) {
        if ([model.year integerValue] == [comps year]) {
            if ([model.isInput integerValue] == 1) {
                self.statisticsIncomeMoney += [model.amount doubleValue];
            } else {
                self.statisticsPayMoney += [model.amount doubleValue];
            }
            [arr addObject:model];
        }
    }
    for (NSInteger i = [comps month]; i > 0; i--) {
        GPAccountMonthModel *mModel = [[GPAccountMonthModel alloc] init];
        mModel.month = i;
        for (GPAccountModel *model in arr) {
            if ([model.month integerValue] == i) {
                if ([model.isInput integerValue] == 1) {
                    mModel.incomeMoney += [model.amount doubleValue];
                } else {
                    mModel.payMoney += [model.amount doubleValue];
                }
            }
            
        }
        [self.statisticsArray addObject:mModel];
    }
}

- (void)calculationMoney {
    for (GPAccountModel *model in self.modelArray) {
        if ([model.isInput integerValue] == 1) {
            self.incomeMoney += [model.amount doubleValue];
        } else {
            self.payMoney += [model.amount doubleValue];
        }
    }
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    if ([keyPath isEqualToString:@"modelArray"]) {
        [self calculationMoney];
    }
}

- (void)dealloc {
    [self.modelArray removeObserver:self forKeyPath:@"count"];
}
@end
