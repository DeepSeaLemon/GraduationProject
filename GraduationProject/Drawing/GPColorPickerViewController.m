//
//  GPColorPickerViewController.m
//  GraduationProject
//
//  Created by CYM on 2020/5/1.
//  Copyright © 2020年 CYM. All rights reserved.
//

#import "GPColorPickerViewController.h"
#import <LSLHSBColorPickerView.h>

@interface GPColorPickerViewController ()

@property (nonatomic, strong)LSLHSBColorPickerView *colorPickerView;

@property (nonatomic, retain)UIColor *currentSelectedColor;

@property (nonatomic, strong)UIButton *saveColor;
@property (nonatomic, strong)UIButton *clearColors;

@end

@implementation GPColorPickerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTitle:@"颜色选择"];
    [self setLeftBackButton];
    [self setRightText:@"完成"];
    self.view.backgroundColor = [UIColor whiteColor];
    [self initUI];
}

- (void)clickRightButton:(UIButton *)sender {
    !self.colorBlock?:self.colorBlock(self.currentSelectedColor);
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)initUI {
    [self.view addSubview:self.colorPickerView];
    [self.colorPickerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(64+10);
        make.left.right.bottom.mas_equalTo(0);
    }];
    
    __weak typeof(self) weakSelf = self;
    [self.colorPickerView colorSelectedBlock:^(UIColor *color, BOOL isConfirm) {
        weakSelf.currentSelectedColor = color;
    }];
    
    [self.view addSubview:self.saveColor];
    [self.saveColor mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.width.mas_equalTo((SCREEN_WIDTH - 2)/2);
        make.height.mas_equalTo(50);
        make.bottom.mas_equalTo(0);
    }];
    
    [self.view addSubview:self.clearColors];
    [self.clearColors mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(0);
        make.width.mas_equalTo((SCREEN_WIDTH - 2)/2);
        make.height.mas_equalTo(50);
        make.bottom.mas_equalTo(0);
    }];
}

- (void)clickSaveColor:(UIButton *)sender {
    if (self.currentSelectedColor) {
        [self.colorPickerView saveSelectedColorToArchiver];
    }
}

- (void)clickClearColors:(UIButton *)sender {
    [LSLHSBColorPickerView cleanSelectedColorInArchiver];
}

- (LSLHSBColorPickerView *)colorPickerView {
    if (!_colorPickerView) {
        _colorPickerView = [[LSLHSBColorPickerView alloc] initWithFrame:CGRectMake(0, 74, SCREEN_WIDTH, SCREEN_HEIGHT-74)];
        _currentSelectedColor = _colorPickerView.preColor;
    }
    return _colorPickerView;
}

- (UIButton *)saveColor {
    if (!_saveColor) {
        _saveColor = [[UIButton alloc] init];
        _saveColor.backgroundColor = GPBlueColor;
        [_saveColor setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_saveColor setTitle:@"保存颜色" forState:UIControlStateNormal];
        [_saveColor addTarget:self action:@selector(clickSaveColor:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _saveColor;
}

- (UIButton *)clearColors {
    if (!_clearColors) {
        _clearColors = [[UIButton alloc] init];
        _clearColors.backgroundColor = GPBlueColor;
        [_clearColors setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_clearColors setTitle:@"清除颜色" forState:UIControlStateNormal];
        [_clearColors addTarget:self action:@selector(clickClearColors:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _clearColors;
}
@end
