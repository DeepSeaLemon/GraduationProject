//
//  GPTimeSelecteView.m
//  GraduationProject
//
//  Created by CYM on 2020/4/24.
//  Copyright © 2020年 CYM. All rights reserved.
//

#import "GPTimeSelecteView.h"

@interface GPTimeSelecteView ()

@property (nonatomic, strong) UILabel *startTitleLabel;
@property (nonatomic, strong) UILabel *startTimeLabel;
@property (nonatomic, strong) UIButton  *startButton;

@property (nonatomic, strong) UILabel *endTitleLabel;
@property (nonatomic, strong) UILabel *endTimeLabel;
@property (nonatomic, strong) UIButton  *endButton;

@property (nonatomic, strong) UILabel *lineLabel;

@end

@implementation GPTimeSelecteView

- (void)setStartTime:(NSString *)timeStr {
    self.startTimeLabel.text = timeStr;
}

- (void)setEndTime:(NSString *)timeStr {
    self.endTimeLabel.text = timeStr;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:CGRectMake(frame.origin.x, frame.origin.y, SCREEN_WIDTH, 65)]) {
        self.backgroundColor = [UIColor whiteColor];
        [self initUI];
    }
    return self;
}

- (void)initUI {
    
    [self addSubview:self.startTitleLabel];
    [self.startTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.top.mas_equalTo(10);
        make.width.mas_equalTo(SCREEN_WIDTH/2);
    }];
    
    [self addSubview:self.startTimeLabel];
    [self.startTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.width.mas_equalTo(SCREEN_WIDTH/2);
        make.top.equalTo(self.startTitleLabel.mas_bottom).offset(5);
    }];
    
    [self addSubview:self.endTitleLabel];
    [self.endTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(0);
        make.top.mas_equalTo(10);
        make.width.mas_equalTo(SCREEN_WIDTH/2);
    }];
    
    [self addSubview:self.endTimeLabel];
    [self.endTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(0);
        make.width.mas_equalTo(SCREEN_WIDTH/2);
        make.top.equalTo(self.startTitleLabel.mas_bottom).offset(5);
    }];
    
    [self addSubview:self.startButton];
    [self.startButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.mas_equalTo(0);
        make.width.mas_equalTo(SCREEN_WIDTH/2 - 1);
    }];
    
    [self addSubview:self.endButton];
    [self.endButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.top.bottom.mas_equalTo(0);
        make.width.mas_equalTo(SCREEN_WIDTH/2 - 1);
    }];
    
    [self addSubview:self.lineLabel];
    [self.lineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.mas_equalTo(0);
        make.centerX.equalTo(self);
        make.width.mas_equalTo(2);
    }];
}

- (void)startButtonClicked:(UIButton *)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(clickTimeSelectedIsStart:)]) {
        [self.delegate clickTimeSelectedIsStart:YES];
    }
}

- (void)endButtonClicked:(UIButton *)sender  {
    if (self.delegate && [self.delegate respondsToSelector:@selector(clickTimeSelectedIsStart:)]) {
        [self.delegate clickTimeSelectedIsStart:NO];
    }
}

#pragma mark - lazy
- (UILabel *)startTitleLabel {
    if (!_startTitleLabel) {
        _startTitleLabel = [[UILabel alloc] init];
        _startTitleLabel.font = [UIFont systemFontOfSize:15];
        _startTitleLabel.textColor = [UIColor blackColor];
        _startTitleLabel.text = @"开始时间";
        _startTitleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _startTitleLabel;
}

- (UILabel *)endTitleLabel {
    if (!_endTitleLabel) {
        _endTitleLabel = [[UILabel alloc] init];
        _endTitleLabel.font = [UIFont systemFontOfSize:15];
        _endTitleLabel.textColor = [UIColor blackColor];
        _endTitleLabel.text = @"结束时间";
        _endTitleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _endTitleLabel;
}

- (UILabel *)startTimeLabel {
    if (!_startTimeLabel) {
        _startTimeLabel = [[UILabel alloc] init];
        _startTimeLabel.font = [UIFont systemFontOfSize:15];
        _startTimeLabel.textColor = [UIColor blackColor];
        _startTimeLabel.text = @"3月9日 17:15";
        _startTimeLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _startTimeLabel;
}

- (UILabel *)endTimeLabel {
    if (!_endTimeLabel) {
        _endTimeLabel = [[UILabel alloc] init];
        _endTimeLabel.font = [UIFont systemFontOfSize:15];
        _endTimeLabel.textColor = [UIColor blackColor];
        _endTimeLabel.text = @"3月9日 17:30";
        _endTimeLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _endTimeLabel;
}

- (UILabel *)lineLabel {
    if (!_lineLabel) {
        _lineLabel = [[UILabel alloc] init];
        _lineLabel.backgroundColor = GPGrayColor;
    }
    return _lineLabel;
}

- (UIButton *)startButton {
    if (!_startButton) {
        _startButton = [[UIButton alloc] init];
        _startButton.backgroundColor = [UIColor clearColor];
        [_startButton addTarget:self action:@selector(startButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _startButton;
}

- (UIButton *)endButton {
    if (!_endButton) {
        _endButton = [[UIButton alloc] init];
        _endButton.backgroundColor = [UIColor clearColor];
        [_endButton addTarget:self action:@selector(endButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _endButton;
}
@end
