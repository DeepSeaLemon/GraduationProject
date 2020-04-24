//
//  GPAccountTableHeaderView.m
//  GraduationProject
//
//  Created by CYM on 2020/4/23.
//  Copyright © 2020年 CYM. All rights reserved.
//

#import "GPAccountTableHeaderView.h"

@interface GPAccountTableHeaderView()

@property (nonatomic, strong) UIView *backView;

@property (nonatomic, strong) UILabel *payLabel;
@property (nonatomic, strong) UILabel *incomeLabel;

@property (nonatomic, strong) UILabel *payTextLabel;
@property (nonatomic, strong) UILabel *incomeTextLabel;

@property (nonatomic, strong) UIButton *statisticsButton;

@end

@implementation GPAccountTableHeaderView

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
        make.bottom.mas_equalTo(-15);
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
    
    [self.backView addSubview:self.statisticsButton];
    [self.statisticsButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.centerY.equalTo(self.backView);
        make.width.height.mas_equalTo(40);
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

- (void)clickStatisticsButton:(UIButton *)sender {
    if(self.delegate && [self.delegate respondsToSelector:@selector(clickStatisticsButton:)]){
        [self.delegate  clickStatisticsButton:sender];
    }
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

- (UIButton *)statisticsButton {
    if (!_statisticsButton) {
        _statisticsButton = [[UIButton alloc] init];
        [_statisticsButton setImage:[UIImage imageNamed:@"statistics"] forState:UIControlStateNormal];
        [_statisticsButton addTarget:self action:@selector(clickStatisticsButton:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _statisticsButton;
}

@end
