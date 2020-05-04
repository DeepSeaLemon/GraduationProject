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
@property (nonatomic, strong) UIView  *startPanView;

@property (nonatomic, strong) UILabel *endTitleLabel;
@property (nonatomic, strong) UILabel *endTimeLabel;
@property (nonatomic, strong) UIView  *endPanView;

@property (nonatomic, strong) UILabel *lineLabel;

@end

@implementation GPTimeSelecteView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:CGRectMake(frame.origin.x, frame.origin.y, SCREEN_WIDTH, 65)]) {
        self.backgroundColor = [UIColor whiteColor];
        [self initUI];
        [self addTapGestureRecognizer];
    }
    return self;
}

- (void)initUI {
    
    [self addSubview:self.endPanView];
    [self.endPanView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.top.bottom.mas_equalTo(0);
        make.width.mas_equalTo(SCREEN_WIDTH);
    }];
    
    [self addSubview:self.startPanView];
    [self.startPanView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.mas_equalTo(0);
        make.width.mas_equalTo(SCREEN_WIDTH);
    }];
    
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
    
    
    
    [self addSubview:self.lineLabel];
    [self.lineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.mas_equalTo(0);
        make.centerX.equalTo(self);
        make.width.mas_equalTo(2);
    }];
}

- (void)startTapPan:(UITapGestureRecognizer *)pan {
    if (self.delegate && [self.delegate respondsToSelector:@selector(clickTimeSelectedIsStart:)]) {
        [self.delegate clickTimeSelectedIsStart:YES];
    }
}

- (void)endTapPan:(UITapGestureRecognizer *)pan {
    if (self.delegate && [self.delegate respondsToSelector:@selector(clickTimeSelectedIsStart:)]) {
        [self.delegate clickTimeSelectedIsStart:NO];
    }
}

- (void)addTapGestureRecognizer {
    UITapGestureRecognizer *startTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(startTapPan:)];
    UITapGestureRecognizer *endTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(endTapPan:)];
    [self.startPanView addGestureRecognizer:startTap];
    [self.startTimeLabel addGestureRecognizer:startTap];
    [self.startTitleLabel addGestureRecognizer:startTap];
    [self.endPanView addGestureRecognizer:endTap];
    [self.endTimeLabel addGestureRecognizer:endTap];
    [self.endTitleLabel addGestureRecognizer:endTap];
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

- (UIView *)startPanView {
    if (!_startPanView) {
        _startPanView = [[UIView alloc] init];
        _startPanView.backgroundColor = [UIColor whiteColor];
    }
    return _startPanView;
}

- (UIView *)endPanView {
    if (!_endPanView) {
        _endPanView = [[UIView alloc] init];
        _endPanView.backgroundColor = [UIColor whiteColor];
    }
    return _endPanView;
}
@end
