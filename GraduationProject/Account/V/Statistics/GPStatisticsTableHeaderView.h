//
//  GPStatisticsTableHeaderView.h
//  GraduationProject
//
//  Created by CYM on 2020/4/24.
//  Copyright © 2020年 CYM. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface GPStatisticsTableHeaderView : UIView

- (void)setPayMoney:(double)pay incomeMoney:(double)income year:(NSInteger)year;
- (void)refreshBarChartViewWithArray:(NSMutableArray *)arr;
@end

NS_ASSUME_NONNULL_END
