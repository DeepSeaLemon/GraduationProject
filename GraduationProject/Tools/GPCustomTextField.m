//
//  GPCustomTextField.m
//  GraduationProject
//
//  Created by CYM on 2020/5/5.
//  Copyright © 2020年 CYM. All rights reserved.
//

#import "GPCustomTextField.h"

@interface GPCustomTextField ()<UITextViewDelegate>

@property (nonatomic, strong) UITextView *contentTextView;
@property (nonatomic, strong) UILabel *placeholderLabel;
@property (nonatomic, copy  ) NSString *placeholderStr;

@end

@implementation GPCustomTextField

- (instancetype)initWithPlaceholder:(NSString *)placeholder {
    if (self = [super init]) {
        self.text = @"";
        self.backgroundColor = [UIColor whiteColor];
        self.placeholderStr = placeholder;
        [self initUI];
    }
    return self;
}

- (void)textViewDidChange:(UITextView *)textView {
    if (textView.text.length > 0) {
        self.placeholderLabel.text = @"";
        self.text = textView.text;
    } else {
        self.placeholderLabel.text = self.placeholderStr;
    }
}

- (void)textViewDidEndEditing:(UITextView *)textView {
    self.text = textView.text;
}

- (void)initUI {
    [self addSubview:self.placeholderLabel];
    [self.placeholderLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.mas_equalTo(15);
        make.right.mas_equalTo(-15);
        make.height.mas_equalTo(25);
    }];
    
    [self addSubview:self.contentTextView];
    [self.contentTextView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(5);
        make.top.mas_equalTo(10);
        make.right.bottom.mas_equalTo(-5);
    }];
}


- (UITextView *)contentTextView {
    if (!_contentTextView) {
        _contentTextView = [[UITextView alloc] init];
        _contentTextView.delegate = self;
        _contentTextView.font = [UIFont systemFontOfSize:17];
        _contentTextView.textColor = [UIColor blackColor];
        _contentTextView.backgroundColor = [UIColor clearColor];
    }
    return _contentTextView;
}

- (UILabel *)placeholderLabel {
    if (!_placeholderLabel) {
        _placeholderLabel = [[UILabel alloc] init];
        _placeholderLabel.text = _placeholderStr;
        _placeholderLabel.textColor = GPDeepGrayColor;
        _placeholderLabel.font = [UIFont systemFontOfSize:17];
        _placeholderLabel.backgroundColor = [UIColor whiteColor];
    }
    return _placeholderLabel;
}
@end
