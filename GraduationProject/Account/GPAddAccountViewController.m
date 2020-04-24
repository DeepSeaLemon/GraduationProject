//
//  GPAddAccountViewController.m
//  GraduationProject
//
//  Created by CYM on 2020/4/23.
//  Copyright © 2020年 CYM. All rights reserved.
//

#import "GPAddAccountViewController.h"
#import "GPTagSelecteView.h"

@interface GPAddAccountViewController ()<GPTagSelecteViewDelegate>

@property (nonatomic, strong)UITextField      *moneyTextFiled;
@property (nonatomic, strong)UILabel          *sineLabel;
@property (nonatomic, strong)UIButton         *payButton;
@property (nonatomic, strong)UIButton         *incomeButton;
@property (nonatomic, strong)UITextField      *reasonTextFiled;
@property (nonatomic, strong)GPTagSelecteView *tagSelecteView;
@end

@implementation GPAddAccountViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTitle:@"添加账目"];
    [self setLeftBackButton];
    [self setRightText:@"完成"];
    [self initUI];
}

- (void)initUI {
    [self.view addSubview:self.moneyTextFiled];
    [self.moneyTextFiled mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.height.mas_equalTo(70);
        make.top.mas_equalTo(65);
    }];
    
    [self.view addSubview:self.sineLabel];
    [self.sineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-20);
        make.centerY.equalTo(self.moneyTextFiled);
    }];
    
    [self.view addSubview:self.payButton];
    [self.payButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.width.mas_equalTo(SCREEN_WIDTH/2);
        make.top.equalTo(self.moneyTextFiled.mas_bottom).offset(1);
        make.height.mas_equalTo(50);
    }];
    
    [self.view addSubview:self.incomeButton];
    [self.incomeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(0);
        make.width.mas_equalTo(SCREEN_WIDTH/2);
        make.top.equalTo(self.moneyTextFiled.mas_bottom).offset(1);
        make.height.mas_equalTo(50);
    }];
    
    [self.view addSubview:self.reasonTextFiled];
    [self.reasonTextFiled mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.height.mas_equalTo(50);
        make.top.equalTo(self.payButton.mas_bottom).offset(1);
    }];
    
    [self.view addSubview:self.tagSelecteView];
    [self.tagSelecteView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(0);
        make.top.equalTo(self.reasonTextFiled.mas_bottom).offset(1);
    }];
}

// 完成
- (void)clickRightButton:(UIButton *)sender {
    
}

- (void)clickIncomeButton:(UIButton *)sender {
    [_incomeButton setBackgroundColor:GPBlueColor];
    [_incomeButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_payButton setBackgroundColor:[UIColor whiteColor]];
    [_payButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    
}

- (void)clickPayButton:(UIButton *)sender {
    [_payButton setBackgroundColor:GPBlueColor];
    [_payButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_incomeButton setBackgroundColor:[UIColor whiteColor]];
    [_incomeButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
}

#pragma mark - GPTagSelecteViewDelegate
- (void)tagSelecteView:(GPTagSelecteView *)tagSelecteView didSelectTagViewAtIndex:(NSInteger)index selectContent:(NSString *)content {
    
}

- (void)tagSelecteView:(GPTagSelecteView *)tagSelecteView longPressSelectTagViewAtIndex:(NSInteger)index selectContent:(NSString *)content{
    
}

- (void)addTagButtonClicked {
    
}

#pragma mark - lazy
- (UITextField *)moneyTextFiled {
    if (!_moneyTextFiled) {
        _moneyTextFiled = [[UITextField alloc] init];
        _moneyTextFiled.placeholder = @"    输入金额";
        _moneyTextFiled.font = [UIFont systemFontOfSize:19];
        _moneyTextFiled.textColor = [UIColor blackColor];
        _moneyTextFiled.backgroundColor = [UIColor whiteColor];
    }
    return _moneyTextFiled;
}

- (UILabel *)sineLabel {
    if (!_sineLabel) {
        _sineLabel = [[UILabel alloc] init];
        _sineLabel.textAlignment = NSTextAlignmentRight;
        _sineLabel.font = [UIFont systemFontOfSize:19];
        _sineLabel.textColor = [UIColor blackColor];
        _sineLabel.text = @"￥";
    }
    return _sineLabel;
}

- (UIButton *)payButton {
    if (!_payButton) {
        _payButton = [[UIButton alloc] init];
        [_payButton setTitle:@"支出" forState:UIControlStateNormal];
        [_payButton setBackgroundColor:GPBlueColor];
        [_payButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_payButton addTarget:self action:@selector(clickPayButton:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _payButton;
}

- (UIButton *)incomeButton {
    if (!_incomeButton) {
        _incomeButton = [[UIButton alloc] init];
        [_incomeButton setTitle:@"收入" forState:UIControlStateNormal];
        [_incomeButton setBackgroundColor:[UIColor whiteColor]];
        [_incomeButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [_incomeButton addTarget:self action:@selector(clickIncomeButton:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _incomeButton;
}

- (UITextField *)reasonTextFiled {
    if (!_reasonTextFiled) {
        _reasonTextFiled = [[UITextField alloc] init];
        _reasonTextFiled.placeholder = @"    输入事由";
        _reasonTextFiled.font = [UIFont systemFontOfSize:18];
        _reasonTextFiled.textColor = [UIColor blackColor];
        _reasonTextFiled.backgroundColor = [UIColor whiteColor];
    }
    return _reasonTextFiled;
}

- (GPTagSelecteView *)tagSelecteView {
    if (!_tagSelecteView) {
        _tagSelecteView = [[GPTagSelecteView alloc] init];
        _tagSelecteView.tagDelegate = self;
        [_tagSelecteView setupSubViewsWithTitles:@[@"测试1",@"测试2",@"测试3",@"测试4",@"测试5",@"测试6",@"测试7",@"测试8",@"测试9",@"测试10",@"测试11",@"测试12",@"测试13",@"测试14",@"测试15",@"测试16",@"测试17",@"测试18",@"测试19",@"测试20"]];
    }
    return _tagSelecteView;
}
@end
