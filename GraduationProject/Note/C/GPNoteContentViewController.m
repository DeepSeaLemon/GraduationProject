//
//  GPNoteContentViewController.m
//  GraduationProject
//
//  Created by CYM on 2020/4/26.
//  Copyright © 2020年 CYM. All rights reserved.
//

#import "GPNoteContentViewController.h"
#import "GPNoteContentCell.h"
#import "GPNoteModel.h"
#import "GPNoteViewModel.h"
#import "GPAddNoteContentViewController.h"
#import "GPNoteContentImageCell.h"

static NSString *GPNoteContentViewControllerCellID = @"GPNoteContentViewController";

@interface GPNoteContentViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation GPNoteContentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setRightText:@"添加"];
    [self setLeftBackButton];
    self.title = (self.noteModel)?self.noteModel.name:@"笔记本标题";
    [self initUI];
}

- (void)setNoteModel:(GPNoteModel *)noteModel {
    _noteModel = noteModel;
    // 查询这个model的numberStr的内容model后reload
    [self.viewModel reloadCurrentNoteContentsWith:noteModel finish:^(BOOL finish) {
        
    }];
}

- (void)clickRightButton:(UIButton *)sender {
    GPAddNoteContentViewController *vc = [[GPAddNoteContentViewController alloc] init];
    vc.numberStr = self.noteModel.numberStr;
    vc.returnBlock = ^(GPNoteContentModel * _Nonnull model) {
        [[DBTool shareInstance] saveNoteContentWith:model complate:^(BOOL success) {
            if (success) {
                [self.viewModel reloadCurrentNoteContentsWith:self.noteModel finish:^(BOOL finish) {
                     [self.tableView reloadData];
                }];
            }
        }];
    };
    [self.navigationController pushViewController:vc animated:YES];
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
    return self.viewModel.currentNoteContents.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    GPNoteContentImageCell *cell = [tableView dequeueReusableCellWithIdentifier:GPNoteContentViewControllerCellID];
    if (!cell) {
        cell = [[GPNoteContentImageCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:GPNoteContentViewControllerCellID];
    }
    [cell setPage:indexPath.row+1];
    if (self.viewModel.currentNoteContents.count > 0) {
        [cell setGPNoteContentModel:self.viewModel.currentNoteContents[indexPath.row]];
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return SCREEN_HEIGHT - 64 - 1;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    GPAddNoteContentViewController *vc = [[GPAddNoteContentViewController alloc] init];
    vc.numberStr = self.noteModel.numberStr;
    vc.contentModel = self.viewModel.currentNoteContents[indexPath.row];
    vc.returnBlock = ^(GPNoteContentModel * _Nonnull model) {
        // 保存返回来的model
        [[DBTool shareInstance] saveNoteContentWith:model complate:^(BOOL success) {
            if (success) {
                // viewModel 刷新数据
                [self.viewModel reloadCurrentNoteContentsWith:self.noteModel finish:^(BOOL finish) {
                    [self.tableView reloadData];
                }];
            }
        }];
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
        _tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectZero];
        _tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
        [_tableView registerClass:[GPNoteContentImageCell class] forCellReuseIdentifier:GPNoteContentViewControllerCellID];
    }
    return _tableView;
}
@end
