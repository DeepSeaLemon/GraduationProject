//
//  GPCourseShowCell.m
//  GraduationProject
//
//  Created by CYM on 2020/4/26.
//  Copyright © 2020年 CYM. All rights reserved.
//

#import "GPCourseShowCell.h"

@interface GPCourseShowCell()

// 模式1
@property (nonatomic, strong) UILabel *textLabel1;
@property (nonatomic, strong) UILabel *textLabel2;

// 模式2
@property (nonatomic, strong) UIImageView *backImageView;

// 模式3
@property (nonatomic, strong) UIView *backView;
@property (nonatomic, strong) UILabel *className;
@property (nonatomic, strong) UILabel *classroom;

@end

@implementation GPCourseShowCell

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self initUI];
    }
    return self;
}

- (void)initUI {
    [self.contentView addSubview:self.backImageView];
    [self.backImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView);
    }];
}

#pragma mark - lazy

- (UIImageView *)backImageView {
    if (!_backImageView) {
        _backImageView = [[UIImageView alloc] init];
        _backImageView.image = [UIImage imageNamed:@"addImage"];
        _backImageView.layer.masksToBounds = YES;
        _backImageView.layer.cornerRadius = 5;
    }
    return _backImageView;
}

- (UILabel *)textLabel1  {
    if (!_textLabel1) {
        _textLabel1 = [[UILabel alloc] init];
        _textLabel1.text = @"语文";
        _textLabel1.font = [UIFont systemFontOfSize:15];
        _textLabel1.backgroundColor = GPDeepGrayColor;
        _textLabel1.layer.masksToBounds = YES;
        _textLabel1.layer.cornerRadius = 5;
        _textLabel1.textAlignment = NSTextAlignmentCenter;
    }
    return _textLabel1;
}

- (UILabel *)textLabel2  {
    if (!_textLabel2) {
        _textLabel2 = [[UILabel alloc] init];
        _textLabel2.text = @"数学";
        _textLabel2.font = [UIFont systemFontOfSize:15];
        _textLabel2.backgroundColor = GPDeepGrayColor;
        _textLabel2.layer.masksToBounds = YES;
        _textLabel2.layer.cornerRadius = 5;
        _textLabel2.textAlignment = NSTextAlignmentCenter;
    }
    return _textLabel2;
}

- (UIView *)backView {
    if (!_backView) {
        _backView = [[UIView alloc] init];
        _backView.backgroundColor = GPGreenColor;
        _backView.layer.masksToBounds = YES;
        _backView.layer.cornerRadius = 5;
    }
    return _backView;
}

- (UILabel *)className  {
    if (!_className) {
        _className = [[UILabel alloc] init];
        _className.text = @"高等数学";
        _className.textColor = [UIColor whiteColor];
        _className.font = [UIFont systemFontOfSize:15];
        _className.backgroundColor = GPDeepGrayColor;
        _className.textAlignment = NSTextAlignmentCenter;
    }
    return _className;
}

- (UILabel *)classroom  {
    if (!_classroom) {
        _classroom = [[UILabel alloc] init];
        _classroom.text = @"第一阶梯";
        _classroom.textColor = [UIColor whiteColor];
        _classroom.font = [UIFont systemFontOfSize:13];
        _classroom.backgroundColor = GPDeepGrayColor;
        _classroom.textAlignment = NSTextAlignmentCenter;
    }
    return _classroom;
}
@end
