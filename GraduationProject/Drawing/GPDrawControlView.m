//
//  GPDrawControlView.m
//  GraduationProject
//
//  Created by CYM on 2020/5/1.
//  Copyright © 2020年 CYM. All rights reserved.
//

#import "GPDrawControlView.h"

@interface GPDrawControlView()<UITextFieldDelegate>

@property (nonatomic, strong) UIButton *colorButton;
@property (nonatomic, strong) UIView *backView;
@property (nonatomic, assign) CGRect retractRect;
@property (nonatomic, assign) CGRect reachtRect;
@property (nonatomic, strong) NSMutableArray<UIButton *>* items;
@property (nonatomic, copy  ) NSArray* imageNames;
@property (nonatomic, strong) UITextField *lineWideTextField;

@end

@implementation GPDrawControlView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:CGRectMake(SCREEN_WIDTH - 50, 64, 45, 395)]) {
        self.reachtRect = CGRectMake(SCREEN_WIDTH - 50, 64, 45, 395);
        self.retractRect = CGRectMake(SCREEN_WIDTH - 50, 64, 45, 0);
        self.backgroundColor = [UIColor whiteColor];
        self.isRetract = NO;
        [self initUI];
    }
    return self;
}

- (void)initUI {
    [self addSubview:self.colorButton];
    [self.colorButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(0);
        make.height.mas_equalTo(45);
    }];
    
    [self addSubview:self.backView];
    [self.backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.mas_equalTo(0);
        make.bottom.mas_equalTo(-22.5);
    }];
    
    for (NSInteger i = 0; i<7; i++) {
        UIButton *item = [[UIButton alloc] init];
        [item setBackgroundImage:[UIImage imageNamed:self.imageNames[i]] forState:UIControlStateNormal];
        [item setBackgroundImage:[UIImage imageWithColor:GPGrayColor] forState:UIControlStateHighlighted];
        [item setBackgroundColor:[UIColor clearColor]];
        [item setTag:i];
        [item addTarget:self action:@selector(itemClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.items addObject:item];
        [self.backView addSubview:item];
        [item mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(10);
            make.right.mas_equalTo(-10);
            make.top.mas_equalTo(i * 45 + 10);
            make.height.mas_equalTo(25);
            make.width.mas_equalTo(25);
        }];
    }
    
    [self addSubview:self.lineWideTextField];
    [self.lineWideTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.right.mas_equalTo(-10);
        make.height.mas_equalTo(25);
        make.width.mas_equalTo(25);
        make.top.equalTo(self.items.lastObject.mas_bottom).offset(20);
    }];
}

- (void)startUIViewAnimation {
    [UIView animateWithDuration:1.0
                          delay:0
                        options:UIViewAnimationOptionLayoutSubviews | UIViewKeyframeAnimationOptionCalculationModeLinear
                     animations:^{
                         if (self.isRetract) {
                             self.colorButton.hidden = NO;
                             self.frame = self.reachtRect;
                             [self.items enumerateObjectsUsingBlock:^(UIButton * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                                 obj.frame = CGRectMake(obj.frame.origin.x, obj.frame.origin.y, 25, 25);
                             }];
                             self.lineWideTextField.frame = CGRectMake(self.lineWideTextField.frame.origin.x, self.lineWideTextField.frame.origin.y, 25, 25);
                         } else {
                             self.frame = self.retractRect;
                             [self.items enumerateObjectsUsingBlock:^(UIButton * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                                 obj.frame = CGRectMake(obj.frame.origin.x, obj.frame.origin.y, 25, 0);
                                 self.lineWideTextField.frame = CGRectMake(self.lineWideTextField.frame.origin.x, self.lineWideTextField.frame.origin.y, 25, 0);
                             }];
                         }
    } completion:^(BOOL finished) {
        self.isRetract = !self.isRetract;
        if (self.isRetract) {
            self.colorButton.hidden = YES;
            self.lineWideTextField.hidden = YES;
        } else {
            self.lineWideTextField.hidden = NO;
        }
    }];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.lineWideTextField resignFirstResponder];
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    [textField resignFirstResponder];
    if (self.delegate && [self.delegate respondsToSelector:@selector(lineWideTextFieldDidEndEditing:)]) {
        [self.delegate lineWideTextFieldDidEndEditing:textField];
    }
}

- (void)selectColor:(UIButton *)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(colorButtonClicked:)]) {
        [self.delegate colorButtonClicked:sender];
    }
}

- (void)itemClick:(UIButton *)sender {
    switch (sender.tag) {
        case 0:
            
            break;
        case 1:
            
            break;
        case 2:
            
            break;
        case 3:
            
            break;
        case 4:
            
            break;
        case 5:
        {
            NSInteger num = [self.lineWideTextField.text integerValue];
            if (num <= 50) {
                num += 1;
                self.lineWideTextField.text = [NSString stringWithFormat:@"%ld",(long)num];
                [self textFieldDidEndEditing:self.lineWideTextField];
            }
        }
            break;
        case 6:
        {
            NSInteger num = [self.lineWideTextField.text integerValue];
            if (num > 1) {
                num -= 1;
                self.lineWideTextField.text = [NSString stringWithFormat:@"%ld",(long)num];
                [self textFieldDidEndEditing:self.lineWideTextField];
            }
        }
            break;
        default:
            break;
    }
    if (self.delegate && [self.delegate respondsToSelector:@selector(itemDidClicked:)]) {
        [self.delegate itemDidClicked:sender];
    }
}


#pragma mark - lazy

- (NSArray *)imageNames {
    if (!_imageNames) {
        _imageNames = @[@"draw_revoke",
                        @"draw_save",
                        @"draw_album",
                        @"draw_eraser",
                        @"draw_pen",
                        @"draw_plus",
                        @"draw_reduce"];
    }
    return _imageNames;
}

- (NSMutableArray<UIButton *> *)items {
    if (!_items) {
        _items = [NSMutableArray arrayWithCapacity:7];
    }
    return _items;
}

- (UIView *)backView {
    if (!_backView) {
        _backView = [[UIView alloc] init];
        _backView.backgroundColor = GPGrayColor;
    }
    return _backView;
}

- (UIButton *)colorButton {
    if (!_colorButton) {
        _colorButton = [[UIButton alloc] init];
        _colorButton.backgroundColor = [UIColor blackColor];
        [_colorButton setBackgroundImage:[UIImage imageWithColor:GPGrayColor] forState:UIControlStateHighlighted];
        _colorButton.layer.masksToBounds = YES;
        _colorButton.layer.cornerRadius = 22.5;
        _colorButton.hidden = NO;
        _colorButton.layer.borderWidth = 1;
        _colorButton.layer.borderColor = GPGrayColor.CGColor;
        [_colorButton addTarget:self action:@selector(selectColor:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _colorButton;
}

- (UITextField *)lineWideTextField {
    if (!_lineWideTextField) {
        _lineWideTextField = [[UITextField alloc] init];
        _lineWideTextField.textColor = [UIColor blackColor];
        _lineWideTextField.font = [UIFont systemFontOfSize:17];
        _lineWideTextField.textAlignment = NSTextAlignmentCenter;
        _lineWideTextField.delegate = self;
        _lineWideTextField.text = @"2";
        _lineWideTextField.hidden = NO;
        _lineWideTextField.keyboardType = UIKeyboardTypeNumberPad;
    }
    return _lineWideTextField;
}
@end
