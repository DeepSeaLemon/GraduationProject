//
//  GPMemorandumViewController.m
//  GraduationProject
//
//  Created by CYM on 2020/4/18.
//  Copyright © 2020年 CYM. All rights reserved.
//

#import "GPMemorandumViewController.h"
#import "GPAddPlanViewController.h"
#import "GPMemorandumTableViewCell.h"
#import "GPMemorandumViewModel.h"

static NSString *GPMemorandumViewControllerCellID = @"GPMemorandumViewController";

@interface GPMemorandumViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) GPMemorandumViewModel *viewModel;

@end

@implementation GPMemorandumViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setFirstClassNavWith:@"计划表" imageName:@"add"];
    [self initUI];
}

- (void)initUI {
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(0);
    }];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 185.0f;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.viewModel.modelsArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    GPMemorandumTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:GPMemorandumViewControllerCellID];
    if (!cell) {
        cell = [[GPMemorandumTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:GPMemorandumViewControllerCellID];
    }
    if (self.viewModel.modelsArray.count > 0) {
        [cell setGPMemorandumModel:self.viewModel.modelsArray[indexPath.row]];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"%ld",(long)indexPath.row);
    // 弹出选择
}

- (void)clickRightButton:(UIButton *)sender {
    GPAddPlanViewController *vc = [[GPAddPlanViewController alloc] init];
    vc.hidesBottomBarWhenPushed = YES;
    vc.returnModelBlock = ^(GPMemorandumModel * _Nonnull model) {
        [[DBTool shareInstance] saveMemorandumWith:model complate:^(BOOL success) {
            if (success) {
                [self.viewModel getMemorandums];
                [self.tableView reloadData];
            }
        }];
    };
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - lazy

- (GPMemorandumViewModel *)viewModel {
    if (!_viewModel) {
        _viewModel = [[GPMemorandumViewModel alloc] initWithData];
    }
    return _viewModel;
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] init];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = GPBackgroundColor;
        [_tableView registerClass:[GPMemorandumTableViewCell class] forCellReuseIdentifier:GPMemorandumViewControllerCellID];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectZero];
        _tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    }
    return _tableView;
}


@end
