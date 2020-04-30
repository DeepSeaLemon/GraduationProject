//
//  GPCourseShowCell.m
//  GraduationProject
//
//  Created by CYM on 2020/4/26.
//  Copyright © 2020年 CYM. All rights reserved.
//

#import "GPCourseShowCell.h"
#import "GPCurriculumModel.h"

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

- (void)setCurrentDayBackGroundViewColor:(BOOL)setIt {
    if (setIt) {
        switch (self.cellType) {
            case GPCourseShowCellTypeOne:
                self.backView.backgroundColor = GPGreenColor;
                self.className.textColor = [UIColor whiteColor];
                self.classroom.textColor = [UIColor whiteColor];
                break;
            case GPCourseShowCellTypeTwo:
                self.textLabel1.backgroundColor = GPGreenColor;
                self.textLabel1.textColor = [UIColor whiteColor];
                self.textLabel2.backgroundColor = GPGreenColor;
                self.textLabel2.textColor = [UIColor whiteColor];
                break;
            default:
                break;
        }
    } else {
        switch (self.cellType) {
            case GPCourseShowCellTypeOne:
                self.backView.backgroundColor = GPDeepGrayColor;
                self.className.textColor = [UIColor blackColor];
                self.classroom.textColor = [UIColor blackColor];
                break;
            case GPCourseShowCellTypeTwo:
                self.textLabel1.backgroundColor = GPDeepGrayColor;
                self.textLabel1.textColor = [UIColor blackColor];
                self.textLabel2.backgroundColor = GPDeepGrayColor;
                self.textLabel2.textColor = [UIColor blackColor];
                break;
            default:
                break;
        }
    }
    
}

- (void)initCellTypeShowNil {
    [[self.contentView subviews]makeObjectsPerformSelector:@selector(removeFromSuperview)];
}

- (void)initCellTypeInputNil {
    [[self.contentView subviews]makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [self.contentView addSubview:self.backImageView];
    [self.backImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView);
    }];
}

- (void)initCellTypeOne {
    [[self.contentView subviews]makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [self.contentView addSubview:self.backView];
    [self.backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView);
    }];
    [self.contentView addSubview:self.className];
    [self.className mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.mas_equalTo(0);
        make.height.mas_equalTo(self.contentView.frame.size.height/2);
    }];
    [self.contentView addSubview:self.classroom];
    [self.classroom mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(0);
        make.height.mas_equalTo(self.contentView.frame.size.height/2);
    }];
}

- (void)initCellTypeTwo {
    [[self.contentView subviews]makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [self.contentView addSubview:self.textLabel1];
    [self.textLabel1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.mas_equalTo(0);
        make.height.mas_equalTo(self.contentView.frame.size.height/2);
    }];
    [self.contentView addSubview:self.textLabel2];
    [self.textLabel2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(0);
        make.height.mas_equalTo(self.contentView.frame.size.height/2);
    }];
}

- (void)setCellType:(GPCourseShowCellType)cellType {
    _cellType = cellType;
    switch (cellType) {
        case GPCourseShowCellTypeShowNil:
            [self initCellTypeShowNil];
            break;
        case GPCourseShowCellTypeInputNil:
            [self initCellTypeInputNil];
            break;
        case GPCourseShowCellTypeOne:
            [self initCellTypeOne];
            break;
        case GPCourseShowCellTypeTwo:
            [self initCellTypeTwo];
            break;
        default:
            break;
    }
}

- (void)setDataModel:(GPCurriculumModel *)model {
    if (model.numberStr != nil && model.numberStr.length > 0) {
        if (model.curriculum.length > 0) {
            if (model.curriculum2 == nil || model.curriculum2.length < 1) {
                self.className.text = model.curriculum;
                self.classroom.text = model.classroom;
                self.cellType = GPCourseShowCellTypeOne;
            } else {
                self.textLabel1.text = model.curriculum;
                self.textLabel2.text = model.curriculum2;
                self.cellType = GPCourseShowCellTypeTwo;
            }
        }
    }
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
        _textLabel1.textColor = [UIColor whiteColor];
        _textLabel1.font = [UIFont systemFontOfSize:15];
        _textLabel1.backgroundColor = GPDeepGrayColor;
        _textLabel1.layer.masksToBounds = YES;
        _textLabel1.layer.cornerRadius = 5;
        _textLabel1.textAlignment = NSTextAlignmentCenter;
        _textLabel1.numberOfLines = 2;
    }
    return _textLabel1;
}

- (UILabel *)textLabel2  {
    if (!_textLabel2) {
        _textLabel2 = [[UILabel alloc] init];
        _textLabel2.text = @"数学";
        _textLabel2.textColor = [UIColor whiteColor];
        _textLabel2.font = [UIFont systemFontOfSize:15];
        _textLabel2.backgroundColor = GPDeepGrayColor;
        _textLabel2.layer.masksToBounds = YES;
        _textLabel2.layer.cornerRadius = 5;
        _textLabel2.textAlignment = NSTextAlignmentCenter;
        _textLabel2.numberOfLines = 2;
    }
    return _textLabel2;
}

- (UIView *)backView {
    if (!_backView) {
        _backView = [[UIView alloc] init];
        _backView.backgroundColor = GPDeepGrayColor;
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
        _className.backgroundColor = [UIColor clearColor];
        _className.textAlignment = NSTextAlignmentCenter;
        _className.numberOfLines = 2;
    }
    return _className;
}

- (UILabel *)classroom  {
    if (!_classroom) {
        _classroom = [[UILabel alloc] init];
        _classroom.text = @"第一阶梯";
        _classroom.textColor = [UIColor whiteColor];
        _classroom.font = [UIFont systemFontOfSize:13];
        _classroom.backgroundColor = [UIColor clearColor];
        _classroom.textAlignment = NSTextAlignmentCenter;
        _classroom.numberOfLines = 2;
    }
    return _classroom;
}
@end
