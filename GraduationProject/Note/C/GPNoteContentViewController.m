//
//  GPNoteContentViewController.m
//  GraduationProject
//
//  Created by CYM on 2020/4/26.
//  Copyright © 2020年 CYM. All rights reserved.
//

#import "GPNoteContentViewController.h"
#import "GPNoteContentCell.h"

static NSString *GPNoteContentViewControllerCellID = @"GPNoteContentViewController";

@interface GPNoteContentViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation GPNoteContentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setRightText:@"添加"];
    [self setLeftBackButton];
    [self setTitle:@"笔记本标题"];
    [self initUI];
}

- (void)initUI {
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(0);
        make.top.mas_equalTo(65);
    }];
}

#pragma mark - tableView
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    GPNoteContentCell *cell = [tableView dequeueReusableCellWithIdentifier:GPNoteContentViewControllerCellID];
    if (!cell) {
        cell = [[GPNoteContentCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:GPNoteContentViewControllerCellID];
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 200;
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
        [_tableView registerClass:[GPNoteContentCell class] forCellReuseIdentifier:GPNoteContentViewControllerCellID];
    }
    return _tableView;
}
@end
