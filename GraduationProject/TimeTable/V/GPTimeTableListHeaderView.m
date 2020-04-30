//
//  GPTimeTableListHeaderView.m
//  GraduationProject
//
//  Created by CYM on 2020/4/26.
//  Copyright © 2020年 CYM. All rights reserved.
//

#import "GPTimeTableListHeaderView.h"
#import "GPTimeTableDayView.h"

@interface GPTimeTableListHeaderView ()

@property (nonatomic, strong) NSMutableArray *dayViews;
@property (nonatomic, strong) UILabel *AMLabel;
@property (nonatomic, strong) UILabel *PMLabel;

@end

@implementation GPTimeTableListHeaderView
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self initUI];
    }
    return self;
}

- (void)initUI {
    CGFloat width = (SCREEN_WIDTH - 7)/8;
    for (NSInteger i = 1; i < 8; i++) {
        GPTimeTableDayView *dayView = [[GPTimeTableDayView alloc] init];
        [dayView setWeekDay:@"周一" date:@"3-28"];
        [self.dayViews addObject:dayView];
        [self addSubview:dayView];
        [dayView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo((width+1)*i);
            make.width.mas_equalTo(width);
            make.top.mas_equalTo(0);
            make.height.mas_equalTo(50);
        }];
    }
    
    [self addSubview:self.AMLabel];
    [self.AMLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.top.mas_equalTo(51);
        make.width.mas_equalTo(width);
        make.height.mas_equalTo(201);
    }];
    
    [self addSubview:self.PMLabel];
    [self.PMLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.top.equalTo(self.AMLabel.mas_bottom).offset(1);
        make.width.mas_equalTo(width);
        make.height.mas_equalTo(201);
    }];
    
}

#pragma mark - lazy
- (NSMutableArray *)dayViews {
    if (!_dayViews) {
        _dayViews = [NSMutableArray array];
    }
    return _dayViews;
}

- (UILabel *)AMLabel {
    if (!_AMLabel) {
        _AMLabel = [[UILabel alloc] init];
        _AMLabel.font = [UIFont systemFontOfSize:17];
        _AMLabel.numberOfLines = 2;
        _AMLabel.backgroundColor = [UIColor whiteColor];
        _AMLabel.textColor = [UIColor blackColor];
        _AMLabel.text = @"上\n午";
        _AMLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _AMLabel;
}

- (UILabel *)PMLabel {
    if (!_PMLabel) {
        _PMLabel = [[UILabel alloc] init];
        _PMLabel.font = [UIFont systemFontOfSize:17];
        _PMLabel.numberOfLines = 2;
        _PMLabel.backgroundColor = [UIColor whiteColor];
        _PMLabel.textColor = [UIColor blackColor];
        _PMLabel.text = @"下\n午";
        _PMLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _PMLabel;
}

@end
