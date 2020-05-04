//
//  GPAddPlanViewController.m
//  GraduationProject
//
//  Created by CYM on 2020/4/24.
//  Copyright © 2020年 CYM. All rights reserved.
//

#import "GPAddPlanViewController.h"
#import "GPTimeSelecteView.h"
#import "GPItemView.h"

@interface GPAddPlanViewController ()<GPItemViewDelegate,GPTimeSelecteViewDelegate>

@property (nonatomic, strong) UITextField *contentTextField;
@property (nonatomic, strong) GPTimeSelecteView *timeSelecteView;
@property (nonatomic, strong) GPItemView *itemViewCountDown;
@property (nonatomic, strong) GPItemView *itemViewTurnOn;
@property (nonatomic, strong) GPItemView *itemViewTimeSelecte;

@end

@implementation GPAddPlanViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"添加计划";
    [self setLeftBackButton];
    [self setRightText:@"完成"];
    [self initUI];
}

#pragma mark -GPTimeSelecteViewDelegate

- (void)clickTimeSelectedIsStart:(BOOL)isStart {
    // 弹出时间选择器
}

#pragma mark - GPItemViewDelegate

- (void)itemViewClicked {
    //  弹出时间选择Alert
}

- (void)itemSwitchChanged:(BOOL)isOn itemView:(GPItemView *)itemView {
    if (itemView.tag == 1) {
        
    } else {
        self.itemViewTimeSelecte.hidden = !isOn;
    }
}

// 完成
- (void)clickRightButton:(UIButton *)sender {
    
}

#pragma mark - UI
- (void)initUI {
    [self.view addSubview:self.contentTextField];
    [self.contentTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.height.mas_equalTo(100);
        make.top.mas_equalTo(65);
    }];
    
    [self.view addSubview:self.timeSelecteView];
    [self.timeSelecteView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.equalTo(self.contentTextField.mas_bottom).offset(1);
        make.height.mas_equalTo(65);
    }];
    
    [self.view addSubview:self.itemViewCountDown];
    [self.itemViewCountDown mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.equalTo(self.timeSelecteView.mas_bottom).offset(1);
        make.height.mas_equalTo(50);
    }];
    
    [self.view addSubview:self.itemViewTurnOn];
    [self.itemViewTurnOn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.equalTo(self.itemViewCountDown.mas_bottom).offset(1);
        make.height.mas_equalTo(50);
    }];
    
    [self.view addSubview:self.itemViewTimeSelecte];
    [self.itemViewTimeSelecte mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.equalTo(self.itemViewTurnOn.mas_bottom).offset(1);
        make.height.mas_equalTo(50);
    }];
}


#pragma mark - lazy

- (UITextField *)contentTextField {
    if (!_contentTextField) {
        _contentTextField = [[UITextField alloc] init];
        _contentTextField.placeholder = @"    输入计划详情";
        _contentTextField.font = [UIFont systemFontOfSize:17];
        _contentTextField.textColor = [UIColor blackColor];
        _contentTextField.backgroundColor = [UIColor whiteColor];
    }
    return _contentTextField;
}

- (GPTimeSelecteView *)timeSelecteView {
    if (!_timeSelecteView) {
        _timeSelecteView = [[GPTimeSelecteView alloc] init];
    }
    return _timeSelecteView;
}

- (GPItemView *)itemViewCountDown {
    if (!_itemViewCountDown) {
        _itemViewCountDown = [[GPItemView alloc] init];
        _itemViewCountDown.tag = 1;
        _itemViewCountDown.isSwitch = YES;
        _itemViewCountDown.delegate = self;
        [_itemViewCountDown setItemSwitchStatus:NO];
    }
    return _itemViewCountDown;
}

- (GPItemView *)itemViewTurnOn {
    if (!_itemViewTurnOn) {
        _itemViewTurnOn = [[GPItemView alloc] init];
        _itemViewTurnOn.tag = 2;
        _itemViewTurnOn.isSwitch = YES;
        _itemViewTurnOn.delegate = self;
        [_itemViewTurnOn setItemSwitchStatus:NO];
    }
    return _itemViewTurnOn;
}

- (GPItemView *)itemViewTimeSelecte {
    if (!_itemViewTimeSelecte) {
        _itemViewTimeSelecte = [[GPItemView alloc] init];
        _itemViewTimeSelecte.isSwitch = NO;
        _itemViewTimeSelecte.delegate = self;
        _itemViewTimeSelecte.hidden = YES;
    }
    return _itemViewTimeSelecte;
}
@end
