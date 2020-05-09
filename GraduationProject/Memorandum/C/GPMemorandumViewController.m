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
#import "GPMemorandumModel.h"
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
    __block GPMemorandumModel *model = self.viewModel.modelsArray[indexPath.row];
    __block NSArray *items = @[@"查看",@"删除"];
    [UIAlertController setSheetTitle:@"操作选择" msg:@"" ctr:self items:items handler:^(UIAlertAction * _Nullable action) {
        if ([items containsObject:action.title]) {
            NSInteger index = [items indexOfObject:action.title];
            if (index == 0) { // 查看
                NSArray *startArr  = [model.startTime componentsSeparatedByString:@" "];
                NSArray *endArr    = [model.endTime componentsSeparatedByString:@" "];
                NSString *dateStr = @"";
                if ([startArr.firstObject isEqualToString:endArr.firstObject]) {
                    dateStr = [NSString stringWithFormat:@"%@ ~ %@",model.startTime,endArr.lastObject];
                } else {
                    dateStr = [NSString stringWithFormat:@"%@ ~ %@",model.startTime,model.endTime];
                }
                NSString *msg = [NSString stringWithFormat:@"时间:%@ \n内容:%@",dateStr,model.content];
                [UIAlertController setTipsTitle:@"计划详情" msg:msg ctr:self handler:^(UIAlertAction * _Nullable action) {
                    // 无操作
                }];
            } else { // 删除
                [UIAlertController setTitle:@"操作提示" msg:@"确定要删除这个计划吗？" ctr:self sureHandler:^(UIAlertAction * _Nonnull action) {
                    [self.viewModel deleteMemorandum:model complate:^(BOOL success) {
                        if (success) {
                            [self.tableView reloadData];
                        } else {
                            [UIAlertController setTipsTitle:@"失败提示" msg:@"删除这个计划时发生了错误，请重试！" ctr:self handler:^(UIAlertAction * _Nullable action) {
                                // 无操作
                            }];
                        }
                    }];
                } cancelHandler:^(UIAlertAction * _Nonnull action) {
                    // 无操作
                }];
            }
        }
    }];
}

- (void)clickRightButton:(UIButton *)sender {
    GPAddPlanViewController *vc = [[GPAddPlanViewController alloc] init];
    vc.hidesBottomBarWhenPushed = YES;
    vc.returnModelBlock = ^(GPMemorandumModel * _Nonnull model) {
        [[DBTool shareInstance] saveMemorandumWith:model complate:^(BOOL success) {
            if (success) {
                [self.viewModel getMemorandums:^(BOOL success) {
                    [self.tableView reloadData];
                }];
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
