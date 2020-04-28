//
//  GPCourseInputCell.m
//  GraduationProject
//
//  Created by CYM on 2020/4/26.
//  Copyright © 2020年 CYM. All rights reserved.
//

#import "GPCourseInputCell.h"

@interface GPCourseInputCell ()

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UITextField *inputTextField;
@property (nonatomic, strong) UIView *backView;

@end

@implementation GPCourseInputCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self initUI];
        self.contentView.backgroundColor = GPBackgroundColor;
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

- (NSString *)getContentText {
    return self.inputTextField.text;
}

- (void)setIsClass:(BOOL)isClass {
    _isClass = isClass;
    self.inputTextField.enabled = !isClass;
    if (isClass) {
        self.inputTextField.enabled = NO;
        self.inputTextField.textColor = GPDeepGrayColor;
    }
}

- (void)setTitle:(NSString *)title placeholder:(NSString *)placeholder {
    self.titleLabel.text = title;
    self.inputTextField.placeholder = placeholder;
}

- (void)initUI {
    [self.contentView addSubview:self.backView];
    [self.backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.mas_equalTo(0);
        make.top.mas_equalTo(10);
        make.height.mas_equalTo(60);
    }];
    
    [self.backView addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(20);
        make.top.bottom.mas_equalTo(0);
    }];
    
    [self.backView addSubview:self.inputTextField];
    [self.inputTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-20);
        make.top.bottom.mas_equalTo(0);
        make.left.equalTo(self.titleLabel.mas_right).offset(5);
    }];
}

#pragma mark - lazy

- (UIView *)backView {
    if (!_backView) {
        _backView = [[UIView alloc] init];
        _backView.backgroundColor = [UIColor whiteColor];
    }
    return _backView;
}
- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.text = @"占位符";
        _titleLabel.textColor = [UIColor blackColor];
        _titleLabel.font = [UIFont systemFontOfSize:17];
    }
    return _titleLabel;
}

- (UITextField *)inputTextField {
    if (!_inputTextField) {
        _inputTextField = [[UITextField alloc] init];
        _inputTextField.placeholder = @"占位符 占位符 占位符 占位符";
        _inputTextField.textColor = [UIColor blackColor];
        _inputTextField.font = [UIFont systemFontOfSize:15];
        _inputTextField.textAlignment = NSTextAlignmentRight;
    }
    return _inputTextField;
}
@end
