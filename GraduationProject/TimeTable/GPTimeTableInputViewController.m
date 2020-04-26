//
//  GPTimeTableInputViewController.m
//  GraduationProject
//
//  Created by CYM on 2020/4/26.
//  Copyright © 2020年 CYM. All rights reserved.
//

#import "GPTimeTableInputViewController.h"
#import "GPTimeTableDoubleInputViewController.h"
#import "GPItemView.h"

@interface GPTimeTableInputViewController ()<GPItemViewDelegate>

@property (nonatomic, strong) GPItemView *modeSwitchItem;
@property (nonatomic, strong) GPItemView *inputItem;

@end

@implementation GPTimeTableInputViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setLeftBackButton];
    [self setRightText:@"完成"];
    [self setTitle:@"课程表录入"];
    [self initUI];
}

#pragma mark - GPItemViewDelegate

- (void)itemViewClicked {
    GPTimeTableDoubleInputViewController *vc = [[GPTimeTableDoubleInputViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)itemSwitchChanged:(BOOL)isOn itemView:(GPItemView *)itemView {
    self.inputItem.hidden = !isOn;
    if (!isOn) {
        [self setTitle:@"课程表录入"];
    } else {
        [self setTitle:@"单周课程表录入"];
    }
}

- (void)initUI {
    [self.view addSubview:self.modeSwitchItem];
    [self.modeSwitchItem mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(65+450+2);
        make.left.right.mas_equalTo(0);
        make.height.mas_equalTo(50);
    }];
    
    [self.view addSubview:self.inputItem];
    [self.inputItem mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.modeSwitchItem.mas_bottom).offset(1);
        make.left.right.mas_equalTo(0);
        make.height.mas_equalTo(50);
    }];
}

#pragma mark - lazy

- (GPItemView *)modeSwitchItem {
    if (!_modeSwitchItem) {
        _modeSwitchItem = [[GPItemView alloc] init];
        _modeSwitchItem.isSwitch = YES;
        _modeSwitchItem.delegate = self;
        _modeSwitchItem.hidden = NO;
    }
    return _modeSwitchItem;
}

- (GPItemView *)inputItem {
    if (!_inputItem) {
        _inputItem = [[GPItemView alloc] init];
        _inputItem.isSwitch = NO;
        _inputItem.delegate = self;
        _inputItem.hidden = YES;
    }
    return _inputItem;
}
@end
