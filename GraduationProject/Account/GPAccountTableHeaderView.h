//
//  GPAccountTableHeaderView.h
//  GraduationProject
//
//  Created by CYM on 2020/4/23.
//  Copyright © 2020年 CYM. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol GPAccountTableHeaderViewDelegate <NSObject>

- (void)clickStatisticsButton:(UIButton *)sender;

@end

@interface GPAccountTableHeaderView : UIView

@property(nonatomic, weak) id<GPAccountTableHeaderViewDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
