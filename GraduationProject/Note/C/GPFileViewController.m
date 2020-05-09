//
//  GPFileViewController.m
//  GraduationProject
//
//  Created by CYM on 2020/5/9.
//  Copyright © 2020年 CYM. All rights reserved.
//

#import "GPFileViewController.h"

static NSString *GPFileViewControllerCellID = @"GPFileViewController";

@interface GPFileViewController ()<UITableViewDelegate,UITableViewDataSource,UIDocumentInteractionControllerDelegate>

@property (nonatomic, strong)UITableView *tableView;
@property (nonatomic, strong)NSMutableArray *files;

@property (nonatomic, strong)UIDocumentInteractionController *documentCtr;

@end

@implementation GPFileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setLeftBackButton];
    [self setTitle:@"文件夹"];
    [self initUI];
}

- (void)initUI {
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.mas_equalTo(0);
        make.top.mas_equalTo(64+1);
    }];
}

#pragma mark - UIDocumentInteractionControllerDelegate & funcs

- (UIViewController *)documentInteractionControllerViewControllerForPreview:(UIDocumentInteractionController *)controller {
    return self;
}

- (UIView *)documentInteractionControllerViewForPreview:(UIDocumentInteractionController *)controller {
    return self.view;
}
- (CGRect)documentInteractionControllerRectForPreview:(UIDocumentInteractionController *)controller {
    return self.view.frame;
}

#pragma mark - delegate & datasource

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:GPFileViewControllerCellID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:GPFileViewControllerCellID];
    }
    if (self.files.count > 0) {
        cell.textLabel.text = self.files[indexPath.row];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    __block NSArray *items = @[@"预览",@"删除"];
    [UIAlertController setSheetTitle:@"操作选择" msg:@"" ctr:self items:items handler:^(UIAlertAction * _Nullable action) {
        if ([items containsObject:action.title]) {
            NSInteger index = [items indexOfObject:action.title];
            NSString *fileName = self.files[indexPath.row];
            if (index == 0) { // 查看
                self.documentCtr.URL = [[GPFileManager shareInstance] copyFileToCaches:fileName];
                [self.documentCtr presentPreviewAnimated:YES];
            } else { // 删除
                if ([[GPFileManager shareInstance] deleteFileWith:fileName]) {
                    [self.files removeObjectAtIndex:indexPath.row];
                    [self.tableView reloadData];
                } else {
                    [UIAlertController setTipsTitle:@"失败提示" msg:@"删除文件时发生了错误，请重试！" ctr:self handler:^(UIAlertAction * _Nullable action) {
                        // 无操作
                    }];
                }
            }
        }
    }];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.files.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

#pragma mark - lazy

- (UIDocumentInteractionController *)documentCtr {
    if (!_documentCtr) {
        _documentCtr = [[UIDocumentInteractionController alloc] init];
        _documentCtr.delegate = self;
    }
    return _documentCtr;
}

- (NSMutableArray *)files {
    if (!_files) {
        _files = [NSMutableArray arrayWithArray:[[GPFileManager shareInstance] getFileNames]];
    }
    return _files;
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] init];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectZero];
        _tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
        _tableView.backgroundColor = GPBackgroundColor;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _tableView;
}
@end
