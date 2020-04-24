//
//  GPStatisticsTableHeaderView.m
//  GraduationProject
//
//  Created by CYM on 2020/4/24.
//  Copyright © 2020年 CYM. All rights reserved.
//

#import "GPStatisticsTableHeaderView.h"

@interface GPStatisticsTableHeaderView ()

@property (nonatomic, strong) UIView *backView;

@property (nonatomic, strong) UILabel *payLabel;
@property (nonatomic, strong) UILabel *incomeLabel;

@property (nonatomic, strong) UILabel *payTextLabel;
@property (nonatomic, strong) UILabel *incomeTextLabel;

@property (nonatomic, strong) UILabel *yearLabel;

@property (nonatomic, strong) UIView *statisticsView;

@end

@implementation GPStatisticsTableHeaderView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = GPBackgroundColor;
        [self initUI];
    }
    return self;
}

- (void)initUI {
    [self addSubview:self.backView];
    [self.backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.right.mas_equalTo(-10);
        make.top.mas_equalTo(15);
        make.height.mas_equalTo(70);
    }];
    
    [self addSubview:self.statisticsView];
    [self.statisticsView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.equalTo(self.backView.mas_bottom).offset(15);
        make.height.mas_equalTo(200);
    }];
    
    [self.backView addSubview:self.payTextLabel];
    [self.payTextLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(20);
        make.top.mas_equalTo(10);
    }];
    
    [self.backView addSubview:self.payLabel];
    [self.payLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(20);
        make.bottom.mas_equalTo(-10);
    }];
    
    [self.backView addSubview:self.yearLabel];
    [self.yearLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.centerY.equalTo(self.backView);
    }];
    
    [self.backView addSubview:self.incomeTextLabel];
    [self.incomeTextLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-20);
        make.top.mas_equalTo(10);
    }];
    
    [self.backView addSubview:self.incomeLabel];
    [self.incomeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-20);
        make.bottom.mas_equalTo(-10);
    }];
    
    
}

#pragma mark - lazy

- (UIView *)backView {
    if (!_backView) {
        _backView = [[UIView alloc] init];
        _backView.backgroundColor = [UIColor whiteColor];
        _backView.layer.masksToBounds = YES;
        _backView.layer.cornerRadius = 5.0f;
    }
    return _backView;
}


- (UILabel *)payTextLabel {
    if (!_payTextLabel) {
        _payTextLabel = [[UILabel alloc] init];
        _payTextLabel.textColor = [UIColor blackColor];
        _payTextLabel.font = [UIFont systemFontOfSize:15];
        _payTextLabel.text = @"总支出";
    }
    return _payTextLabel;
}

- (UILabel *)incomeTextLabel {
    if (!_incomeTextLabel) {
        _incomeTextLabel = [[UILabel alloc] init];
        _incomeTextLabel.textColor = [UIColor blackColor];
        _incomeTextLabel.font = [UIFont systemFontOfSize:15];
        _incomeTextLabel.text = @"总收入";
    }
    return _incomeTextLabel;
}

- (UILabel *)payLabel {
    if (!_payLabel) {
        _payLabel = [[UILabel alloc] init];
        _payLabel.textColor = [UIColor blackColor];
        _payLabel.font = [UIFont systemFontOfSize:19];
        _payLabel.text = @"¥5000";
    }
    return _payLabel;
}

- (UILabel *)incomeLabel {
    if (!_incomeLabel) {
        _incomeLabel = [[UILabel alloc] init];
        _incomeLabel.textColor = [UIColor blackColor];
        _incomeLabel.font = [UIFont systemFontOfSize:19];
        _incomeLabel.text = @"¥1000";
    }
    return _incomeLabel;
}

- (UILabel *)yearLabel {
    if (!_yearLabel) {
        _yearLabel = [[UILabel alloc] init];
        _yearLabel.font = [UIFont systemFontOfSize:19];
        _yearLabel.textColor = [UIColor blackColor];
        _yearLabel.text = @"2020年";
    }
    return _yearLabel;
}

- (UIView *)statisticsView {
    if (!_statisticsView) {
        _statisticsView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 300)];
        _statisticsView.backgroundColor = [UIColor whiteColor];
    }
    return _statisticsView;
}

@end
