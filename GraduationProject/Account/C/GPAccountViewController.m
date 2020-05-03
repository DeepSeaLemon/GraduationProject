//
//  GPAccountViewController.m
//  GraduationProject
//
//  Created by CYM on 2020/4/18.
//  Copyright © 2020年 CYM. All rights reserved.
//

#import "GPAccountViewController.h"
#import "GPAccountTableViewCell.h"
#import "GPAccountTableHeaderView.h"
#import "GPAddAccountViewController.h"
#import "GPStatisticsViewController.h"
#import "GPAccountModel.h"
#import "GPAccountViewModel.h"

static NSString *GPAccountViewControllerCellID = @"GPAccountViewController";

@interface GPAccountViewController ()<UITableViewDelegate, UITableViewDataSource, GPAccountTableHeaderViewDelegate>

@property (nonatomic, strong) GPAccountTableHeaderView *headerView;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) GPAccountViewModel *viewModel;

@end

@implementation GPAccountViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
    if (self.viewModel.modelArray.count == 0) {
        [self.headerView setPayMoney:@(0) incomeMoney:@(0)];
    } else {
        [self.headerView setPayMoney:[NSNumber numberWithDouble:self.viewModel.payMoney] incomeMoney:[NSNumber numberWithDouble:self.viewModel.incomeMoney]];
    }
}

- (void)initUI {
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(0);
    }];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 70.0f;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.viewModel.modelArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    GPAccountTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:GPAccountViewControllerCellID];
    if (!cell) {
        cell = [[GPAccountTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:GPAccountViewControllerCellID];
    }
    NSInteger i = self.viewModel.modelArray.count;
    if (self.viewModel.modelArray.count > 0) {
        [cell setGPAccountModel:self.viewModel.modelArray[(i - 1 - indexPath.row)]];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"%ld",(long)indexPath.row);
}

- (void)clickStatisticsButton:(nonnull UIButton *)sender {
    GPStatisticsViewController *vc = [[GPStatisticsViewController alloc] init];
    vc.hidesBottomBarWhenPushed = YES;
    vc.viewModel = self.viewModel;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)clickRightButton:(UIButton *)sender {
    GPAddAccountViewController *vc = [[GPAddAccountViewController alloc] init];
    vc.hidesBottomBarWhenPushed = YES;
    vc.returnModelBlock = ^(GPAccountModel * _Nonnull model) {
        [[self.viewModel mutableArrayValueForKey:@"modelArray"] addObject:model];
        [self.tableView reloadData];
        [self.headerView setPayMoney:[NSNumber numberWithDouble:self.viewModel.payMoney] incomeMoney:[NSNumber numberWithDouble:self.viewModel.incomeMoney]];
    };
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - lazy
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] init];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = GPBackgroundColor;
        [_tableView registerClass:[GPAccountTableViewCell class] forCellReuseIdentifier:GPAccountViewControllerCellID];
        _tableView.tableHeaderView = self.headerView;
        _tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    }
    return _tableView;
}

- (GPAccountTableHeaderView *)headerView {
    if (!_headerView) {
        _headerView = [[GPAccountTableHeaderView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 100)];
        _headerView.delegate = self;
    }
    return _headerView;
}

- (GPAccountViewModel *)viewModel {
    if (!_viewModel) {
        _viewModel = [[GPAccountViewModel alloc] initWithData];
    }
    return _viewModel;
}
@end
