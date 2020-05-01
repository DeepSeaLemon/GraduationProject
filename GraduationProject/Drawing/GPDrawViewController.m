//
//  GPDrawViewController.m
//  GraduationProject
//
//  Created by CYM on 2020/4/21.
//  Copyright © 2020年 CYM. All rights reserved.
//

#import "GPDrawViewController.h"
#import "GPDrawView.h"
#import "GPDrawControlView.h"
#import "GPColorPickerViewController.h"

@interface GPDrawViewController ()<GPDrawControlViewDelegate>

@property (nonatomic, strong) GPDrawView *drawView;
@property (nonatomic, strong) GPDrawControlView *controlView;

@end

@implementation GPDrawViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setLeftBackButton];
    [self setRightImageWithName:@"arrow_up"];
    self.title = @"新画板";
    [self initUI];
}

- (void)initUI {
    [self.view addSubview:self.drawView];
    [self.drawView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(0);
        make.top.mas_equalTo(65);
    }];
    
    [self.view addSubview:self.controlView];
}

- (void)clickRightButton:(UIButton *)sender {
    if (self.controlView.isRetract) {
        [self setRightImageWithName:@"arrow_up"];
    } else {
        [self setRightImageWithName:@"arrow_down"];
    }
    [self.controlView startUIViewAnimation];
}

#pragma mark - GPDrawControlViewDelegate

- (void)lineWideTextFieldDidEndEditing:(UITextField *)textField {
    NSInteger num = [textField.text integerValue];
    if (num > 50) {
        // 提示
    } else {
        self.drawView.lineWidth = num;
    }
}

- (void)itemDidClicked:(UIButton *)sender {
    switch (sender.tag) {
        case 0:
            // 撤回
            [self.drawView undo];
            break;
        case 1:
            // 保存
            [self.drawView save];
            break;
        case 2:
            // 相册
            break;
        case 3:
            // 橡皮擦
            [self.drawView eraser];
            break;
        case 4:
            // 画笔
            [self.drawView resetPen];
            break;
        default:
            break;
    }
}

- (void)colorButtonClicked:(UIButton *)sender {
    GPColorPickerViewController *vc = [[GPColorPickerViewController alloc] init];
    vc.colorBlock = ^(UIColor * _Nonnull pickerColor) {
        self.drawView.pathColor = pickerColor;
        sender.backgroundColor = pickerColor;
    };
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.controlView.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isKindOfClass:[UITextField class]]) {
            [obj resignFirstResponder];
        }
    }];
}

#pragma mark - lazy

- (GPDrawView *)drawView{
    if (!_drawView) {
        _drawView = [[GPDrawView alloc]init];
    }
    return _drawView;
}

- (GPDrawControlView *)controlView {
    if (!_controlView) {
        _controlView = [[GPDrawControlView alloc] initWithFrame:CGRectZero];
        _controlView.delegate = self;
    }
    return _controlView;
}
@end
