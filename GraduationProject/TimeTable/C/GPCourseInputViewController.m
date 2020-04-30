
//
//  GPCourseInputViewController.m
//  GraduationProject
//
//  Created by CYM on 2020/4/26.
//  Copyright © 2020年 CYM. All rights reserved.
//

#import "GPCourseInputViewController.h"
#import "GPCourseInputCell.h"
#import "GPCurriculumModel.h"

static NSString *GPCourseInputViewControllerCellID = @"GPCourseInputViewController";

@interface GPCourseInputViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, copy) NSArray *titleArray;
@property (nonatomic, strong) NSMutableArray *placeholderArray;
@property (nonatomic, strong) NSMutableArray *contentArray;

@end

@implementation GPCourseInputViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setLeftBackButton];
    [self setRightText:@"完成"];
    [self setTitle:@"课程录入"];
    [self initUI];
}

- (void)clickRightButton:(UIButton *)sender {
    NSArray <GPCourseInputCell *>* cells = [self.tableView.visibleCells copy];
    GPCurriculumModel *model = [[GPCurriculumModel alloc] init];
    model.curriculum = [cells[1] getContentText];
    model.classroom  = [cells[2] getContentText];
    model.teacher    = [cells[3] getContentText];
    model.curriculum2 = [cells[4] getContentText];
    model.classroom2  = [cells[5] getContentText];
    model.teacher2    = [cells[6] getContentText];
    model.week = self.week;
    model.section = self.section;
    model.isDouble = self.isDouble;
    model.isSingle = self.isSingle;
    model.numberStr = [NSString stringWithFormat:@"%ld%ld%d%d",(long)self.section,(long)self.week,
                       [[NSNumber numberWithBool:self.isSingle] intValue],
                       [[NSNumber numberWithBool:self.isDouble] intValue]];
    if (self.returnBlock != nil) {
        self.returnBlock(model);
    }
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)setModel:(GPCurriculumModel *)model {
    _model = model;
    [self.contentArray replaceObjectAtIndex:0 withObject:model.curriculum];
    [self.contentArray replaceObjectAtIndex:1 withObject:model.classroom];
    [self.contentArray replaceObjectAtIndex:2 withObject:model.teacher];
    [self.contentArray replaceObjectAtIndex:3 withObject:model.curriculum2];
    [self.contentArray replaceObjectAtIndex:4 withObject:model.classroom2];
    [self.contentArray replaceObjectAtIndex:5 withObject:model.teacher2];
}

- (void)returnModel:(ReturnGPCurriculumModelBlock)block {
    self.returnBlock = block;
}

- (void)initUI {
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(0);
        make.top.mas_equalTo(65);
    }];
}

#pragma mark - tableView

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.titleArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    GPCourseInputCell *cell = [tableView dequeueReusableCellWithIdentifier:GPCourseInputViewControllerCellID];
    if (!cell) {
        cell = [[GPCourseInputCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:GPCourseInputViewControllerCellID];
    }
    if (indexPath.row == 0) {
        cell.isClass = YES;
    }
    [cell setTitle:self.titleArray[indexPath.row] placeholder:self.placeholderArray[indexPath.row]];
    if (indexPath.row > 0) {
        [cell setContentText:self.contentArray[indexPath.row - 1]];
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

#pragma mark - lazy

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] init];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = GPBackgroundColor;
        _tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectZero];
        _tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_tableView registerClass:[GPCourseInputCell class] forCellReuseIdentifier:GPCourseInputViewControllerCellID];
    }
    return _tableView;
}

- (NSMutableArray *)contentArray {
    if (!_contentArray) {
        _contentArray = [NSMutableArray arrayWithCapacity:6];
        for (NSInteger i = 0; i < 6; i++) {
            [_contentArray addObject:@""];
        }
    }
    return _contentArray;
}

- (NSArray *)titleArray {
    if (!_titleArray) {
        _titleArray = @[@"节次",@"课程",@"教室",@"教师",@"课程二",@"教室二",@"教师二"];
    }
    return _titleArray;
}

- (NSMutableArray *)placeholderArray {
    if (!_placeholderArray) {
        _placeholderArray = [NSMutableArray array];
        [_placeholderArray addObject:[self setClassStr]];
        [_placeholderArray addObject:@"输入课程名称 (必填)"];
        [_placeholderArray addObject:@"输入教室位置 (选填)"];
        [_placeholderArray addObject:@"授课老师姓名 (选填)"];
        [_placeholderArray addObject:@"输入课程名称 (选填)"];
        [_placeholderArray addObject:@"输入教室位置 (选填)"];
        [_placeholderArray addObject:@"授课老师姓名 (选填)"];
    }
    return _placeholderArray;
}

- (NSString *)setClassStr {
    NSMutableString *str = [NSMutableString string];
    if (self.isSingle) {
        [str appendString:@"单周 "];
    }
    if (self.isDouble) {
        [str appendString:@"双周 "];
    }
    switch (self.week) {
        case 0:
            [str appendString:@"周一 "];
            break;
        case 1:
            [str appendString:@"周二 "];
            break;
        case 2:
            [str appendString:@"周三 "];
            break;
        case 3:
            [str appendString:@"周四 "];
            break;
        case 4:
            [str appendString:@"周五 "];
            break;
        case 5:
            [str appendString:@"周六 "];
            break;
        case 6:
            [str appendString:@"周日 "];
            break;
        default:
            break;
    }
    
    switch (self.section) {
        case 0:
            [str appendString:@"上午 "];
            [str appendString:@"第一节"];
            break;
        case 1:
            [str appendString:@"上午 "];
            [str appendString:@"第二节"];
            break;
        case 2:
            [str appendString:@"下午 "];
            [str appendString:@"第三节"];
            break;
        case 3:
            [str appendString:@"下午 "];
            [str appendString:@"第四节"];
            break;
        default:
            break;
    }
    return str;
}
@end
