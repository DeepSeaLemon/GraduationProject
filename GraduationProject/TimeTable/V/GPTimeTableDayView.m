//
//  GPTimeTableDayView.m
//  GraduationProject
//
//  Created by CYM on 2020/4/26.
//  Copyright © 2020年 CYM. All rights reserved.
//

#import "GPTimeTableDayView.h"

@interface GPTimeTableDayView ()

@property (nonatomic, strong) UILabel *weekDayLabel;
@property (nonatomic, strong) UILabel *dateLabel;

@end

@implementation GPTimeTableDayView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        [self initUI];
    }
    return self;
}

- (void)setWeekDay:(NSString *)weekDay date:(NSString *)date {
    self.weekDayLabel.text = weekDay;
    self.dateLabel.text = date;
    [self setNeedsLayout];
    [self layoutSubviews];
}

- (void)initUI {
    [self addSubview:self.weekDayLabel];
    [self.weekDayLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(5);
        make.height.mas_equalTo(20);
    }];
    
    [self addSubview:self.dateLabel];
    [self.dateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.bottom.mas_equalTo(-5);
        make.height.mas_equalTo(20);
        make.top.equalTo(self.weekDayLabel.mas_bottom);
    }];
}

#pragma mark - lazy
- (UILabel *)weekDayLabel {
    if (!_weekDayLabel) {
        _weekDayLabel = [[UILabel alloc] init];
        _weekDayLabel.font = [UIFont systemFontOfSize:15];
        _weekDayLabel.text = @"周一";
        _weekDayLabel.textColor = [UIColor blackColor];
        _weekDayLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _weekDayLabel;
}

- (UILabel *)dateLabel {
    if (!_dateLabel) {
        _dateLabel = [[UILabel alloc] init];
        _dateLabel.font = [UIFont systemFontOfSize:13];
        _dateLabel.text = @"3-23";
        _dateLabel.textColor = GPDeepGrayColor;
        _dateLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _dateLabel;
}

@end
