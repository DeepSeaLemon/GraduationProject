//
//  GPAddAccountViewController.m
//  GraduationProject
//
//  Created by CYM on 2020/4/23.
//  Copyright © 2020年 CYM. All rights reserved.
//

#import "GPAddAccountViewController.h"
#import "GPTagSelecteView.h"
#import "GPAccountModel.h"

@interface GPAddAccountViewController ()<GPTagSelecteViewDelegate>

@property (nonatomic, strong)UITextField      *moneyTextFiled;
@property (nonatomic, strong)UILabel          *sineLabel;
@property (nonatomic, strong)UIButton         *payButton;
@property (nonatomic, strong)UIButton         *incomeButton;
@property (nonatomic, strong)UITextField      *reasonTextFiled;
@property (nonatomic, strong)GPTagSelecteView *tagSelecteView;
@property (nonatomic, assign)BOOL              isInput;
@property (nonatomic, strong)NSMutableArray   *titlesArray;

@end

@implementation GPAddAccountViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTitle:@"添加账目"];
    [self setLeftBackButton];
    [self setRightText:@"完成"];
    self.isInput = NO;
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
    // 检查输入情况
    NSString *tips = @"";
    if (self.moneyTextFiled.text.length < 1) {
        tips = @"请输入金额";
    } else if (self.reasonTextFiled.text.length < 1) {
        tips = @"请输入事由标识";
    } else {
        GPAccountModel *model = [[GPAccountModel alloc] initWith:self.moneyTextFiled.text isInput:self.isInput content:self.reasonTextFiled.text];
        [[DBTool shareInstance] saveAccountWith:model complate:^(BOOL success) {
            if (success) {
                !self.returnModelBlock?:self.returnModelBlock(model);
                [self.navigationController popViewControllerAnimated:YES];
            }
        }];
    }
    if (tips.length > 2) {
        [UIAlertController setTipsTitle:@"提示" msg:@"" ctr:self handler:^(UIAlertAction * _Nullable action) {
            // 无操作
        }];
    }
}

- (void)clickIncomeButton:(UIButton *)sender {
    [self.incomeButton setBackgroundColor:GPBlueColor];
    [self.incomeButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.payButton setBackgroundColor:[UIColor whiteColor]];
    [self.payButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    self.isInput = YES;
}

- (void)clickPayButton:(UIButton *)sender {
    [_payButton setBackgroundColor:GPBlueColor];
    [_payButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_incomeButton setBackgroundColor:[UIColor whiteColor]];
    [_incomeButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    self.isInput = NO;
}

#pragma mark - GPTagSelecteViewDelegate

- (void)tagSelecteView:(GPTagSelecteView *)tagSelecteView didSelectTagViewAtIndex:(NSInteger)index selectContent:(NSString *)content {
    self.reasonTextFiled.text = content;
}

- (void)tagSelecteView:(GPTagSelecteView *)tagSelecteView longPressSelectTagViewAtIndex:(NSInteger)index selectContent:(NSString *)content{
    [UIAlertController setTitle:@"提示" msg:[NSString stringWithFormat:@"确认要删除 %@ 吗？",content] ctr:self sureHandler:^(UIAlertAction * _Nonnull action) {
        [self.titlesArray removeObjectAtIndex:index];
        [self.tagSelecteView refreshWithTitles:self.titlesArray];
        NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
        [user setObject:self.titlesArray forKey:key_account_titles];
    } cancelHandler:^(UIAlertAction * _Nonnull action) {
        // 无操作
    }];
}

- (void)addTagButtonClicked {
    if (self.titlesArray.count < 20) {
        [UIAlertController setTextFieldTitle:@"添加标识" msg:@"" placeholder:@"输入自定义标识" ctr:self textReturn:^(NSString * _Nonnull text) {
            [self.titlesArray insertObject:text atIndex:0];
            [self.tagSelecteView refreshWithTitles:self.titlesArray];
            NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
            [user setObject:self.titlesArray forKey:key_account_titles];
        }];
    } else {
        [UIAlertController setTipsTitle:@"提示" msg:@"标识最多只能有20个，请删除多余的表识后再添加" ctr:self handler:^(UIAlertAction * _Nullable action) {
            // 无操作
        }];
    }
    
}

#pragma mark - lazy
- (UITextField *)moneyTextFiled {
    if (!_moneyTextFiled) {
        _moneyTextFiled = [[UITextField alloc] init];
        _moneyTextFiled.placeholder = @"输入金额";
        _moneyTextFiled.font = [UIFont systemFontOfSize:19];
        _moneyTextFiled.textColor = [UIColor blackColor];
        _moneyTextFiled.backgroundColor = [UIColor whiteColor];
        _moneyTextFiled.keyboardType = UIKeyboardTypeNumberPad;
        _moneyTextFiled = [UITextField setTextShowLeftIndent:_moneyTextFiled];
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
        _reasonTextFiled.placeholder = @"输入事由";
        _reasonTextFiled.font = [UIFont systemFontOfSize:18];
        _reasonTextFiled.textColor = [UIColor blackColor];
        _reasonTextFiled.backgroundColor = [UIColor whiteColor];
        _reasonTextFiled = [UITextField setTextShowLeftIndent:_reasonTextFiled];
    }
    return _reasonTextFiled;
}

- (GPTagSelecteView *)tagSelecteView {
    if (!_tagSelecteView) {
        _tagSelecteView = [[GPTagSelecteView alloc] init];
        _tagSelecteView.tagDelegate = self;
        [_tagSelecteView setupSubViewsWithTitles:self.titlesArray];
    }
    return _tagSelecteView;
}

- (NSMutableArray *)titlesArray {
    if (!_titlesArray) {
        NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
        NSArray * arr =(NSArray *)[user objectForKey:key_account_titles];
        if (arr != nil && arr.count > 0) {
            _titlesArray = [NSMutableArray arrayWithArray:arr];
        } else {
            _titlesArray = [NSMutableArray array];
            [_titlesArray addObject:@"早点"];
            [_titlesArray addObject:@"午饭"];
            [_titlesArray addObject:@"晚饭"];
            [_titlesArray addObject:@"饮料"];
            [_titlesArray addObject:@"衣服"];
            [_titlesArray addObject:@"游戏"];
            [_titlesArray addObject:@"话费"];
            [_titlesArray addObject:@"购物"];
            [_titlesArray addObject:@"电影"];
            [_titlesArray addObject:@"红包"];
            
        }
    }
    return _titlesArray;
}
@end
