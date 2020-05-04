//
//  GPNoteContentCell.m
//  GraduationProject
//
//  Created by CYM on 2020/4/26.
//  Copyright © 2020年 CYM. All rights reserved.
//

#import "GPNoteContentCell.h"

@interface GPNoteContentCell()

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *contentLabel;
@property (nonatomic, strong) UILabel *timeLabel;
@property (nonatomic, strong) UIImageView *photo1;
@property (nonatomic, strong) UIImageView *photo2;
@property (nonatomic, strong) UIImageView *photo3;

@end

@implementation GPNoteContentCell

- (instancetype) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.contentView.backgroundColor = [UIColor whiteColor];
        [self initUI];
    }
    return self;
}

- (void)initUI {
    CGFloat width = (SCREEN_WIDTH - 40)/3;
    [self.contentView addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.top.mas_equalTo(15);
        make.right.mas_equalTo(-15);
        make.height.mas_equalTo(25);
    }];
    
    [self.contentView addSubview:self.contentLabel];
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.right.mas_equalTo(-15);
        make.top.equalTo(self.titleLabel.mas_bottom).offset(1);
        make.height.mas_equalTo(50);
    }];
    
    [self.contentView addSubview:self.photo1];
    [self.photo1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.top.equalTo(self.contentLabel.mas_bottom).offset(1);
        make.width.mas_equalTo(width);
    }];
    
    [self.contentView addSubview:self.photo2];
    [self.photo2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentLabel.mas_bottom).offset(1);
        make.width.mas_equalTo(self.photo1.mas_width);
        make.height.mas_equalTo(self.photo1.mas_height);
        make.centerX.equalTo(self.contentView);
    }];
    
    [self.contentView addSubview:self.photo3];
    [self.photo3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-15);
        make.top.equalTo(self.contentLabel.mas_bottom).offset(1);
        make.width.mas_equalTo(self.photo1.mas_width);
        make.height.mas_equalTo(self.photo1.mas_height);
    }];
    
    [self.contentView addSubview:self.timeLabel];
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.right.mas_equalTo(-15);
        make.top.equalTo(self.photo1.mas_bottom).offset(5);
        make.bottom.mas_equalTo(-15);
        make.height.mas_equalTo(20);
    }];
}

#pragma mark - lazy

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = [UIFont systemFontOfSize:15];
        _titleLabel.textColor = [UIColor blackColor];
        _titleLabel.text = @"标题占位符";
    }
    return _titleLabel;
}

- (UILabel *)contentLabel {
    if (!_contentLabel) {
        _contentLabel = [[UILabel alloc] init];
        _contentLabel.font = [UIFont systemFontOfSize:13];
        _contentLabel.textColor = [UIColor blackColor];
        _contentLabel.text = @"内容占位符内容占位符内容占位符内容占位符内容占位符内容占位符内容占位符内容占位符内容占位符内容占位符";
        _contentLabel.numberOfLines = 2;
    }
    return _contentLabel;
}

- (UILabel *)timeLabel {
    if (!_timeLabel) {
        _timeLabel = [[UILabel alloc] init];
        _timeLabel.font = [UIFont systemFontOfSize:13];
        _timeLabel.textColor = [UIColor blackColor];
        _timeLabel.text = @"2020-03-22";
    }
    return _timeLabel;
}

- (UIImageView *)photo1 {
    if (!_photo1) {
        _photo1 = [[UIImageView alloc] init];
        _photo1.backgroundColor = GPGrayColor;
        _photo1.layer.masksToBounds = YES;
        _photo1.layer.cornerRadius = 5;
    }
    return _photo1;
}

- (UIImageView *)photo2 {
    if (!_photo2) {
        _photo2 = [[UIImageView alloc] init];
        _photo2.backgroundColor = GPGrayColor;
        _photo2.layer.masksToBounds = YES;
        _photo2.layer.cornerRadius = 5;
    }
    return _photo2;
}

- (UIImageView *)photo3 {
    if (!_photo3) {
        _photo3 = [[UIImageView alloc] init];
        _photo3.backgroundColor = GPGrayColor;
        _photo3.layer.masksToBounds = YES;
        _photo3.layer.cornerRadius = 5;
    }
    return _photo3;
}
@end
