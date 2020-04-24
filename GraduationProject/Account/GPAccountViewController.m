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

static NSString *GPAccountViewControllerCellID = @"GPAccountViewController";

@interface GPAccountViewController ()<UITableViewDelegate, UITableViewDataSource, GPAccountTableHeaderViewDelegate>

@property (nonatomic, strong) GPAccountTableHeaderView *headerView;
@property (nonatomic, strong) UITableView *tableView;

@end

@implementation GPAccountViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initUI];
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
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    GPAccountTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:GPAccountViewControllerCellID];
    if (!cell) {
        cell = [[GPAccountTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:GPAccountViewControllerCellID];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"%ld",(long)indexPath.row);
}

- (void)clickStatisticsButton:(nonnull UIButton *)sender {
    GPStatisticsViewController *vc = [[GPStatisticsViewController alloc] init];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)clickRightButton:(UIButton *)sender {
    GPAddAccountViewController *vc = [[GPAddAccountViewController alloc] init];
    vc.hidesBottomBarWhenPushed = YES;
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



@end
