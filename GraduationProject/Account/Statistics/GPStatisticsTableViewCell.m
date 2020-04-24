//
//  GPStatisticsTableViewCell.m
//  GraduationProject
//
//  Created by CYM on 2020/4/24.
//  Copyright © 2020年 CYM. All rights reserved.
//

#import "GPStatisticsTableViewCell.h"

@interface GPStatisticsTableViewCell ()

@property (nonatomic, strong) UIView *backView;

@property (nonatomic, strong) UILabel *payLabel;
@property (nonatomic, strong) UILabel *incomeLabel;

@property (nonatomic, strong) UILabel *payTextLabel;
@property (nonatomic, strong) UILabel *incomeTextLabel;

@property (nonatomic, strong) UILabel *moonLabel;
@end

@implementation GPStatisticsTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.contentView.backgroundColor = GPBackgroundColor;
        [self initUI];
    }
    return self;
}

- (void)initUI {
    [self.contentView addSubview:self.backView];
    [self.backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.right.mas_equalTo(-10);
        make.top.mas_equalTo(15);
        make.bottom.mas_equalTo(0);
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
    
    [self.backView addSubview:self.moonLabel];
    [self.moonLabel mas_makeConstraints:^(MASConstraintMaker *make) {
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

- (UILabel *)moonLabel {
    if (!_moonLabel) {
        _moonLabel = [[UILabel alloc] init];
        _moonLabel.font = [UIFont systemFontOfSize:19];
        _moonLabel.textColor = [UIColor blackColor];
        _moonLabel.text = @"1月";
    }
    return _moonLabel;
}
@end
