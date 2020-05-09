//
//  GPNoteViewController.m
//  GraduationProject
//
//  Created by CYM on 2020/4/18.
//  Copyright © 2020年 CYM. All rights reserved.
//

#import "GPNoteViewController.h"
#import "GPCollectionViewCell.h"
#import "GPAddNoteViewController.h"
#import "GPNoteViewModel.h"
#import "GPNoteContentViewController.h"

static NSString *GPNoteViewControllerCellID = @"GPNoteViewController";

@interface GPNoteViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic, strong) UICollectionView           *collectionView;
@property (nonatomic, strong) UICollectionViewFlowLayout *collectionLayout;
@property (nonatomic, strong) GPNoteViewModel *viewModel;

@end

@implementation GPNoteViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUI];
}

- (void)setUI {
    [self.view addSubview:self.collectionView];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(0);
        make.top.mas_equalTo(74);
    }];
}

#pragma make - delegate & datesource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.viewModel.notes.count + 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    GPCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:GPNoteViewControllerCellID forIndexPath:indexPath];
    if (cell == nil) {
        cell = [[GPCollectionViewCell alloc] init];
    }
    if (indexPath.row == 0) {
        [cell setTitle:@"新笔记"];
    }
    if (indexPath.row != 0 && self.viewModel.notes.count > 0) {
        [cell setGPNoteModel:self.viewModel.notes[indexPath.row - 1]];
    }
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        GPAddNoteViewController *vc = [[GPAddNoteViewController alloc] init];
        vc.hidesBottomBarWhenPushed = YES;
        vc.returnBlock = ^(GPNoteModel * _Nonnull model) {
          [[DBTool shareInstance] saveNoteWith:model complate:^(BOOL success) {
                if (success) {
                    [self.viewModel reloadNotes:^(BOOL finish) {
                        [self.collectionView reloadData];
                    }];
                } else {
                    [UIAlertController setTipsTitle:@"错误" msg:@"笔记本保存失败了,请重试!" ctr:self handler:^(UIAlertAction * _Nullable action) {
                        // 无操作
                    }];
                }
            }];
        };
        [self.navigationController pushViewController:vc animated:YES];
    } else {
        __block NSArray *items = @[@"编辑",@"删除"];
        [UIAlertController setSheetTitle:@"操作选择" msg:@"" ctr:self items:items handler:^(UIAlertAction * _Nullable action) {
            if ([items containsObject:action.title]) {
                NSInteger index = [items indexOfObject:action.title];
                if (index == 0) { // 编辑
                    GPNoteContentViewController *vc = [[GPNoteContentViewController alloc] init];
                    vc.hidesBottomBarWhenPushed = YES;
                    vc.viewModel = self.viewModel;
                    vc.noteModel = self.viewModel.notes[indexPath.row - 1];
                    [self.navigationController pushViewController:vc animated:YES];
                } else { // 删除
                    [UIAlertController setTitle:@"操作提示" msg:@"确定要删除这个笔记本吗？" ctr:self sureHandler:^(UIAlertAction * _Nonnull action) {
                        [self.viewModel deleteNoteWith:self.viewModel.notes[indexPath.row - 1] complate:^(BOOL success) {
                            if (success) {
                                [self.collectionView reloadData];
                            } else {
                                [UIAlertController setTipsTitle:@"失败提示" msg:@"删除这个笔记本时发生了错误，请重试！" ctr:self handler:^(UIAlertAction * _Nullable action) {
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
}

#pragma mark - lazy

- (GPNoteViewModel *)viewModel {
    if (!_viewModel) {
        _viewModel = [[GPNoteViewModel alloc] initWithData];
    }
    return _viewModel;
}

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:self.collectionLayout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.backgroundColor = GPBackgroundColor;
        _collectionView.showsVerticalScrollIndicator = NO;
        [_collectionView registerClass:[GPCollectionViewCell class] forCellWithReuseIdentifier:GPNoteViewControllerCellID];
    }
    return _collectionView;
}

- (UICollectionViewLayout *)collectionLayout {
    if (!_collectionLayout) {
        _collectionLayout = [[UICollectionViewFlowLayout alloc] init];
        _collectionLayout.itemSize = CGSizeMake(105, 165);
        CGFloat margin = 18;
        _collectionLayout.sectionInset = UIEdgeInsetsMake(0, margin, 0, margin);
        _collectionLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
        _collectionLayout.minimumLineSpacing = 11;
        _collectionLayout.minimumInteritemSpacing = 10;
    }
    return _collectionLayout;
}

@end
