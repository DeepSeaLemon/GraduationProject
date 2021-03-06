//
//  GPMemorandumTableViewCell.m
//  GraduationProject
//
//  Created by CYM on 2020/4/25.
//  Copyright © 2020年 CYM. All rights reserved.
//

#import "GPMemorandumTableViewCell.h"
#import "GPMemorandumModel.h"

@interface GPMemorandumTableViewCell ()

@property (nonatomic, strong) UILabel *dateLabel;
@property (nonatomic, strong) UILabel *contentLabel;
@property (nonatomic, strong) UILabel *timeLabel;
@property (nonatomic, strong) UILabel *countDownTimeLabel;
@property (nonatomic, strong) UIImageView *clockImageView;
@property (nonatomic, strong) UIView *backView;
@property (nonatomic, strong) dispatch_source_t timer;    //GCD定时器

@end


@implementation GPMemorandumTableViewCell

- (void)setGPMemorandumModel:(GPMemorandumModel *)model {
    self.contentLabel.text = model.content;
    NSArray *remindArr = [model.remindTime componentsSeparatedByString:@" "];
    NSArray *startArr  = [model.startTime componentsSeparatedByString:@" "];
    NSArray *endArr    = [model.endTime componentsSeparatedByString:@" "];
    if ([startArr.firstObject isEqualToString:endArr.firstObject]) {
        self.dateLabel.text = [NSString stringWithFormat:@"%@ ~ %@",model.startTime,endArr.lastObject];
    } else {
        self.dateLabel.text = [NSString stringWithFormat:@"%@ ~ %@",model.startTime,model.endTime];
    }
    if ([model.isRemind boolValue]) {
        self.clockImageView.hidden = NO;
        self.timeLabel.text = remindArr.lastObject;
    } else {
        self.clockImageView.hidden = YES;
        self.timeLabel.text = startArr.lastObject;
    }
    if ([model.isCountDown boolValue]) {
        self.countDownTimeLabel.hidden = NO;
        [self createGCDTimerWith:model.startTime];
    } else {
        self.countDownTimeLabel.hidden = YES;
    }
    if ([NSDate computingTimeWith:model.startTime] <= 300) {
        self.countDownTimeLabel.backgroundColor = GPRedColor;
        self.timeLabel.backgroundColor = GPRedColor;
        self.clockImageView.backgroundColor = GPRedColor;
    } else {
        self.countDownTimeLabel.backgroundColor = GPGreenColor;
        self.timeLabel.backgroundColor = GPGreenColor;
        self.clockImageView.backgroundColor = GPGreenColor;
    }
}

- (void)createGCDTimerWith:(NSString *)startTimeStr {
    //得到倒计时时间
    __block int timeout = [NSDate computingTimeWith:startTimeStr];
    //定时器的创建
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    self.timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
    dispatch_source_set_timer(self.timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
    dispatch_source_set_event_handler(self.timer, ^{
        if(timeout <= 0){ //倒计时结束，关闭
            dispatch_source_cancel(self.timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                self.countDownTimeLabel.hidden = YES;
            });
        }else{
            int hour = timeout / 3600;
            int minute = timeout / 60 % 60;
            int second = timeout % 60;
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置界面的按钮显示 根据自己需求设置
                self.countDownTimeLabel.text = [NSString stringWithFormat:@"%02d:%02d:%02d",hour,minute,second];
            });
            timeout -= 1;
        }
    });
    dispatch_resume(self.timer);
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.contentView.backgroundColor = GPBackgroundColor;
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self initUI];
    }
    return self;
}

- (void)dealloc {
    dispatch_source_cancel(_timer);   //关闭定时器
    NSLog(@"Cell成功释放了！");
}

- (void)initUI {
    [self.contentView addSubview:self.backView];
    [self.backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(45);
        make.bottom.mas_equalTo(-10);
        make.left.mas_equalTo(20);
        make.right.mas_equalTo(-20);
    }];
    
    [self.contentView addSubview:self.timeLabel];
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(45);
        make.top.mas_equalTo(25);
        make.height.mas_equalTo(40);
        make.width.mas_equalTo(80);
    }];
    
    [self.contentView addSubview:self.clockImageView];
    [self.clockImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(125);
        make.top.mas_equalTo(25);
        make.width.height.mas_equalTo(40);
    }];
    
    [self.contentView addSubview:self.countDownTimeLabel];
    [self.countDownTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(25);
        make.right.mas_equalTo(-45);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(40);
    }];
    
    [self.backView addSubview:self.dateLabel];
    [self.dateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(28);
        make.top.mas_equalTo(35);
        make.right.mas_equalTo(-28);
        make.height.mas_equalTo(25);
    }];
    
    [self.backView addSubview:self.contentLabel];
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(28);
        make.right.mas_equalTo(-28);
        make.top.equalTo(self.dateLabel.mas_bottom).offset(5);
        make.bottom.mas_equalTo(-10);
    }];
}

#pragma mark - lazy

- (UIView *)backView {
    if (!_backView) {
        _backView = [[UIView alloc] init];
        _backView.backgroundColor = [UIColor whiteColor];
        _backView.layer.shadowColor = [UIColor blackColor].CGColor;
        _backView.layer.shadowOpacity = 0.5f;
        _backView.layer.shadowOffset = CGSizeMake(1, 1);
        _backView.layer.shadowRadius = 2.0f;
        _backView.layer.shouldRasterize = YES;
        _backView.layer.masksToBounds = NO;
    }
    return _backView;
}

- (UILabel *)timeLabel {
    if (!_timeLabel) {
        _timeLabel = [[UILabel alloc] init];
        _timeLabel.font = [UIFont systemFontOfSize:20];
        _timeLabel.textColor = [UIColor whiteColor];
        _timeLabel.backgroundColor = GPRedColor;
        _timeLabel.text = @"16:55";
        _timeLabel.textAlignment = NSTextAlignmentCenter;
        _timeLabel.layer.shadowOpacity = 0.5f;
        _timeLabel.layer.shadowOffset = CGSizeMake(1, 1);
        _timeLabel.layer.shadowRadius = 2.0f;
        _timeLabel.layer.shouldRasterize = YES;
        _timeLabel.layer.masksToBounds = NO;
    }
    return _timeLabel;
}

- (UIImageView *)clockImageView {
    if (!_clockImageView) {
        _clockImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"clock"]];
        _clockImageView.backgroundColor = GPRedColor;
        _clockImageView.layer.shadowOpacity = 0.5f;
        _clockImageView.layer.shadowOffset = CGSizeMake(1, 1);
        _clockImageView.layer.shadowRadius = 2.0f;
        _clockImageView.layer.shouldRasterize = YES;
        _clockImageView.layer.masksToBounds = NO;
    }
    return _clockImageView;
}

- (UILabel *)countDownTimeLabel {
    if (!_countDownTimeLabel) {
        _countDownTimeLabel = [[UILabel alloc] init];
        _countDownTimeLabel.font = [UIFont systemFontOfSize:20];
        _countDownTimeLabel.textColor = [UIColor whiteColor];
        _countDownTimeLabel.backgroundColor = GPRedColor;
        _countDownTimeLabel.textAlignment = NSTextAlignmentCenter;
        _countDownTimeLabel.text = @"03:20";
        _countDownTimeLabel.layer.shadowOpacity = 0.5f;
        _countDownTimeLabel.layer.shadowOffset = CGSizeMake(1, 1);
        _countDownTimeLabel.layer.shadowRadius = 2.0f;
        _countDownTimeLabel.layer.shouldRasterize = YES;
        _countDownTimeLabel.layer.masksToBounds = NO;
    }
    return _countDownTimeLabel;
}

- (UILabel *)dateLabel {
    if (!_dateLabel) {
        _dateLabel = [[UILabel alloc] init];
        _dateLabel.font = [UIFont systemFontOfSize:15];
        _dateLabel.textColor = [UIColor blackColor];
        _dateLabel.text = @"3月12日 17:00-3月12日 17:30";
    }
    return _dateLabel;
}

- (UILabel *)contentLabel {
    if (!_contentLabel) {
        _contentLabel = [[UILabel alloc] init];
        _contentLabel.font = [UIFont systemFontOfSize:15];
        _contentLabel.textColor = [UIColor blackColor];
        _contentLabel.numberOfLines = 2;
        _contentLabel.text = @"测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试";
    }
    return _contentLabel;
}
@end
