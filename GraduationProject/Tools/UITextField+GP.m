//
//  UITextField+GP.m
//  GraduationProject
//
//  Created by CYM on 2020/5/3.
//  Copyright © 2020年 CYM. All rights reserved.
//

#import "UITextField+GP.h"

@implementation UITextField (GP)

+ (UITextField *)setTextShowLeftIndent:(UITextField *)textField {
    UIView *leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 20, 0)];
    leftView.backgroundColor = [UIColor clearColor];
    // 保证点击缩进的view，也可以调出光标
    leftView.userInteractionEnabled = NO;
    textField.leftView = leftView;
    textField.leftViewMode = UITextFieldViewModeAlways;
    return textField;
}

@end
