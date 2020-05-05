//
//  GPTimeSelecteView.h
//  GraduationProject
//
//  Created by CYM on 2020/4/24.
//  Copyright © 2020年 CYM. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol GPTimeSelecteViewDelegate <NSObject>

- (void)clickTimeSelectedIsStart:(BOOL)isStart;

@end

@interface GPTimeSelecteView : UIView

@property (nonatomic, strong) id<GPTimeSelecteViewDelegate> delegate;

- (void)setStartTime:(NSString *)timeStr;
- (void)setEndTime:(NSString *)timeStr;
@end

