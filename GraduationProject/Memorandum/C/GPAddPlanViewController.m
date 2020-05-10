//
//  GPAddPlanViewController.m
//  GraduationProject
//
//  Created by CYM on 2020/4/24.
//  Copyright © 2020年 CYM. All rights reserved.
//

#import "GPAddPlanViewController.h"
#import "GPTimeSelecteView.h"
#import "GPItemView.h"
#import "GPCustomTextField.h"
#import "CXDatePickerView.h"
#import "GPMemorandumModel.h"
#import "ZBLocalNotification.h"

@interface GPAddPlanViewController ()<GPItemViewDelegate,GPTimeSelecteViewDelegate>

@property (nonatomic, strong) GPCustomTextField *contentTextField;
@property (nonatomic, strong) GPTimeSelecteView *timeSelecteView;
@property (nonatomic, strong) GPItemView *itemViewCountDown;
@property (nonatomic, strong) GPItemView *itemViewTurnOn;
@property (nonatomic, strong) GPItemView *itemViewEveryday;
@property (nonatomic, strong) GPItemView *itemViewTimeSelecte;

@property (nonatomic, copy  ) NSString *startTimeStr;
@property (nonatomic, copy  ) NSString *endTimeStr;

@property (nonatomic, assign) BOOL isCountDown;
@property (nonatomic, assign) BOOL isTurnOn;
@property (nonatomic, assign) BOOL isEveryday;

@property (nonatomic, assign) NSInteger timeAhead;

@end

@implementation GPAddPlanViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"添加计划";
    [self setLeftBackButton];
    [self setRightText:@"完成"];
    self.startTimeStr = @"";
    self.endTimeStr = @"";
    self.isCountDown = NO;
    self.isTurnOn = NO;
    self.isEveryday = NO;
    self.timeAhead = 0;
    [self initUI];
    [self setTimeStr];
}

- (void)setTimeStr {
    NSDateFormatter *dateFormater = [[NSDateFormatter alloc] init];
    [dateFormater setDateFormat:@"MM-dd HH:mm"];
    NSDate *datenow = [NSDate date];
    NSString *currentDateString = [dateFormater stringFromDate:datenow];
    [self.timeSelecteView setStartTime:currentDateString];
    [self.timeSelecteView setEndTime:currentDateString];
    self.startTimeStr = currentDateString;
    self.endTimeStr = currentDateString;
}

#pragma mark -GPTimeSelecteViewDelegate

- (void)clickTimeSelectedIsStart:(BOOL)isStart {
    if (isStart) {
        CXDatePickerView *datepicker = [[CXDatePickerView alloc] initWithDateStyle:CXDateMonthDayHourMinute CompleteBlock:^(NSDate *selectDate) {
            NSString *dateString = [selectDate cx_stringWithFormat:@"MM-dd HH:mm"];
            [self.timeSelecteView setStartTime:dateString];
            [self.timeSelecteView setEndTime:dateString];
            self.startTimeStr = dateString;
            self.endTimeStr = dateString;
        }];
        datepicker.dateLabelColor = GPBlueColor;//年-月-日-时-分 颜色
        datepicker.datePickerColor = [UIColor blackColor];//滚轮日期颜色
        datepicker.doneButtonColor = [UIColor blackColor];//确定按钮的颜色
        datepicker.hideBackgroundYearLabel = YES;//隐藏背景年份文字
        datepicker.cancelButtonColor = datepicker.doneButtonColor;
        [datepicker show];
    } else {
        NSDateFormatter *dateFormater = [[NSDateFormatter alloc] init];
        [dateFormater setDateFormat:@"MM-dd HH:mm"];
        NSDate *endTimeDate = [dateFormater dateFromString:self.endTimeStr];
        CXDatePickerView *datepicker = [[CXDatePickerView alloc] initWithDateStyle:CXDateMonthDayHourMinute scrollToDate:endTimeDate CompleteBlock:^(NSDate *selectDate) {
            NSString *dateString = [selectDate cx_stringWithFormat:@"MM-dd HH:mm"];
            [self.timeSelecteView setEndTime:dateString];
            self.endTimeStr = dateString;
        }];
        datepicker.dateLabelColor = GPBlueColor;
        datepicker.datePickerColor = [UIColor blackColor];
        datepicker.doneButtonColor = [UIColor blackColor];
        datepicker.hideBackgroundYearLabel = YES;
        datepicker.cancelButtonColor = datepicker.doneButtonColor;
        [datepicker show];
    }
}

#pragma mark - GPItemViewDelegate

- (void)itemViewClicked {
    __block NSArray <NSString *>*items = @[@"设置提醒时间",@"提前5分钟提醒",@"提前10分钟提醒",@"提前15分钟提醒",@"提前20分钟提醒",@"提前25分钟提醒",@"提前30分钟提醒"];
    [UIAlertController setSheetTitle:@"设置提醒时间" msg:@"" ctr:self items:items handler:^(UIAlertAction * _Nullable action) {
        if ([items containsObject:action.title]) {
            NSInteger index = [items indexOfObject:action.title];
            NSString *str = [NSDate setAadditionSubtractionWithTimeInterval:(0 - index*5*60) sinceTime:self.startTimeStr];
            if ([NSDate compareDateWithNow:str]) {
                self.timeAhead = index * 5;
            } else {
                [UIAlertController setTipsTitle:@"提醒"
                                            msg:@"闹钟时间不能早于当前时间,请重新选择！"
                                            ctr:self
                                        handler:^(UIAlertAction * _Nullable action) {
                                            self.timeAhead = 0;
                                        }];
            }
        }
    }];
}

- (void)itemSwitchChanged:(BOOL)isOn itemView:(GPItemView *)itemView {
    switch (itemView.tag) {
        case 1:
            self.isCountDown = isOn;
            break;
        case 2:
            self.itemViewTimeSelecte.hidden = !isOn;
            self.itemViewEveryday.hidden = !isOn;
            self.isTurnOn = isOn;
            break;
        case 3:
            self.isEveryday = isOn;
            break;
        default:
            break;
    }
}

// 完成
- (void)clickRightButton:(UIButton *)sender {
    GPMemorandumModel *model = [[GPMemorandumModel alloc] initWith:self.contentTextField.text
                                                         startTime:self.startTimeStr
                                                           endTime:self.endTimeStr
                                                       isCountDown:self.isCountDown
                                                          isRemind:self.isTurnOn
                                                        isEveryday:self.isEveryday
                                                         timeAhead:self.timeAhead
                                ];
    if (self.contentTextField.text.length < 1) {
        [UIAlertController setTipsTitle:@"提示"
                                    msg:@"计划详情不能为空！"
                                    ctr:self
                                handler:^(UIAlertAction * _Nullable action) {
                                    // 不操作
                                }];
    } else {
        if ([NSDate compareDateWithNow:self.startTimeStr]) {
            [self addLocalNotificationWithModel:model];
            !self.returnModelBlock?:self.returnModelBlock(model);
            [self.navigationController popViewControllerAnimated:YES];
        } else {
            [UIAlertController setTipsTitle:@"提示"
                                        msg:@"设置起始时间不能早于当前时间,请重新选择！"
                                        ctr:self
                                    handler:^(UIAlertAction * _Nullable action) {
                                        // 不操作
                                    }];
        }
    }
}

- (void)addLocalNotificationWithModel:(GPMemorandumModel *)model {
    if (![model.isRemind boolValue]) {
        return;
    }
    NSDate *datenow = [NSDate date];
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    NSInteger unitFlags = NSCalendarUnitYear;
    comps = [calendar components:unitFlags fromDate:datenow];
    NSDateFormatter * formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    NSDate * date = [formatter dateFromString:[NSString stringWithFormat:@"%ld-%@",(long)[comps year],model.remindTime]];
    if ([model.isEveryday boolValue]) {
        [ZBLocalNotification createLocalNotificationWithAttribute:@{ZBNotificationUserInfoName:model.numberStr,
                                                                    ZBNotificationSoundName:ZBNotificationSoundAlarm,
                                                                    ZBNotificationAlertBody:model.content,
                                                                    ZBNotificationAlertTitle:@"学习助手提醒闹钟",
                                                                    ZBNotificationFireDate:date,
                                                                    ZBNotificationPriority:@(0),
                                                                    ZBNotificationRepeat:@(ZBLocalNotificationRepeatEveryDay)}];
    } else {
        [ZBLocalNotification createLocalNotificationWithAttribute:@{ZBNotificationUserInfoName:model.numberStr,
                                                                    ZBNotificationSoundName:ZBNotificationSoundAlarm,
                                                                    ZBNotificationAlertBody:model.content,
                                                                    ZBNotificationAlertTitle:@"学习助手提醒闹钟",
                                                                    ZBNotificationFireDate:date,
                                                                    ZBNotificationPriority:@(0),
                                                                    ZBNotificationRepeat:@(ZBLocalNotificationRepeatNone)}];
    }
    
}

#pragma mark - UI

- (void)initUI {
    [self.view addSubview:self.contentTextField];
    [self.contentTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.height.mas_equalTo(100);
        make.top.mas_equalTo(65);
    }];
    
    [self.view addSubview:self.timeSelecteView];
    [self.timeSelecteView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.equalTo(self.contentTextField.mas_bottom).offset(1);
        make.height.mas_equalTo(65);
    }];
    
    [self.view addSubview:self.itemViewCountDown];
    [self.itemViewCountDown mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.equalTo(self.timeSelecteView.mas_bottom).offset(1);
        make.height.mas_equalTo(50);
    }];
    
    [self.view addSubview:self.itemViewTurnOn];
    [self.itemViewTurnOn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.equalTo(self.itemViewCountDown.mas_bottom).offset(1);
        make.height.mas_equalTo(50);
    }];
    
    [self.view addSubview:self.itemViewTimeSelecte];
    [self.itemViewTimeSelecte mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.equalTo(self.itemViewTurnOn.mas_bottom).offset(1);
        make.height.mas_equalTo(50);
    }];
    
    [self.view addSubview:self.itemViewEveryday];
    [self.itemViewEveryday mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.equalTo(self.itemViewTimeSelecte.mas_bottom).offset(1);
        make.height.mas_equalTo(50);
    }];
}


#pragma mark - lazy

- (GPCustomTextField *)contentTextField {
    if (!_contentTextField) {
        _contentTextField = [[GPCustomTextField alloc] initWithPlaceholder:@"输入计划详情"];
        _contentTextField.backgroundColor = [UIColor whiteColor];
    }
    return _contentTextField;
}

- (GPTimeSelecteView *)timeSelecteView {
    if (!_timeSelecteView) {
        _timeSelecteView = [[GPTimeSelecteView alloc] init];
        _timeSelecteView.delegate = self;
    }
    return _timeSelecteView;
}

- (GPItemView *)itemViewCountDown {
    if (!_itemViewCountDown) {
        _itemViewCountDown = [[GPItemView alloc] init];
        _itemViewCountDown.tag = 1;
        _itemViewCountDown.isSwitch = YES;
        _itemViewCountDown.delegate = self;
        [_itemViewCountDown setItemSwitchStatus:NO];
        [_itemViewCountDown setItemViewTitle:@"开启倒计时"];
    }
    return _itemViewCountDown;
}

- (GPItemView *)itemViewTurnOn {
    if (!_itemViewTurnOn) {
        _itemViewTurnOn = [[GPItemView alloc] init];
        _itemViewTurnOn.tag = 2;
        _itemViewTurnOn.isSwitch = YES;
        _itemViewTurnOn.delegate = self;
        [_itemViewTurnOn setItemSwitchStatus:NO];
        [_itemViewTurnOn setItemViewTitle:@"开启提醒"];
    }
    return _itemViewTurnOn;
}

- (GPItemView *)itemViewEveryday {
    if (!_itemViewEveryday) {
        _itemViewEveryday = [[GPItemView alloc] init];
        _itemViewEveryday.tag = 3;
        _itemViewEveryday.isSwitch = YES;
        _itemViewEveryday.delegate = self;
        _itemViewEveryday.hidden = YES;
        [_itemViewEveryday setItemSwitchStatus:NO];
        [_itemViewEveryday setItemViewTitle:@"开启每日提醒(每日哦!)"];
    }
    return _itemViewEveryday;
}

- (GPItemView *)itemViewTimeSelecte {
    if (!_itemViewTimeSelecte) {
        _itemViewTimeSelecte = [[GPItemView alloc] init];
        _itemViewTimeSelecte.isSwitch = NO;
        _itemViewTimeSelecte.delegate = self;
        _itemViewTimeSelecte.hidden = YES;
        [_itemViewTimeSelecte setItemViewTitle:@"起始时间提醒"];
    }
    return _itemViewTimeSelecte;
}
@end
