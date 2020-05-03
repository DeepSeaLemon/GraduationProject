//
//  GPStatisticsViewController.m
//  GraduationProject
//
//  Created by CYM on 2020/4/24.
//  Copyright © 2020年 CYM. All rights reserved.
//

#import "GPStatisticsViewController.h"
#import "GPStatisticsTableHeaderView.h"
#import "GPStatisticsTableViewCell.h"
#import "GPAccountViewModel.h"

static NSString *GPStatisticsViewControllerCellID = @"GPStatisticsViewController";

@interface GPStatisticsViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) GPStatisticsTableHeaderView *headerView;

@end

@implementation GPStatisticsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setLeftBackButton];
    self.title = @"账目统计";
    [self initUI];
}

- (void)initUI {
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}

- (void)setViewModel:(GPAccountViewModel *)viewModel {
    _viewModel = viewModel;
    [_viewModel calculateDataOfThisYear];
    [self.headerView setPayMoney:viewModel.statisticsPayMoney incomeMoney:viewModel.statisticsIncomeMoney year:[NSDate getThisYear]];
}

#pragma mark - tableView
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.viewModel.statisticsArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    GPStatisticsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:GPStatisticsViewControllerCellID];
    if (!cell) {
        cell = [[GPStatisticsTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:GPStatisticsViewControllerCellID];
    }
    if (self.viewModel.statisticsArray.count > 0) {
        [cell setGPAccountMonthModel:self.viewModel.statisticsArray[indexPath.row]];
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 85;
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
        _tableView.tableHeaderView = self.headerView;
        _tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_tableView registerClass:[GPStatisticsTableViewCell class] forCellReuseIdentifier:GPStatisticsViewControllerCellID];
    }
    return _tableView;
}

- (GPStatisticsTableHeaderView *)headerView {
    if (!_headerView) {
        _headerView = [[GPStatisticsTableHeaderView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 300)];
    }
    return _headerView;
}
@end
