//
//  GPAccountViewModel.h
//  GraduationProject
//
//  Created by CYM on 2020/5/3.
//  Copyright © 2020年 CYM. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class GPAccountModel;
@class GPAccountMonthModel;

@interface GPAccountViewModel : NSObject

@property (nonatomic, strong) NSMutableArray<GPAccountModel *>* modelArray;

@property (nonatomic, assign) double payMoney;
@property (nonatomic, assign) double incomeMoney;

@property (nonatomic, assign) double statisticsPayMoney;
@property (nonatomic, assign) double statisticsIncomeMoney;

@property (nonatomic, strong) NSMutableArray <GPAccountMonthModel *>*statisticsArray;

- (instancetype)initWithData;

- (void)calculateDataOfThisYear;

@end

NS_ASSUME_NONNULL_END
