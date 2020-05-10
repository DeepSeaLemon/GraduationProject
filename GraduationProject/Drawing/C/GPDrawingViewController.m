//
//  GPDrawingViewController.m
//  GraduationProject
//
//  Created by CYM on 2020/4/18.
//  Copyright © 2020年 CYM. All rights reserved.
//

#import "GPDrawingViewController.h"
#import "GPDrawViewController.h"
#import "GPCollectionViewCell.h"
#import "GPDrawModel.h"

static NSString *GPDrawingViewControllerCellID = @"GPDrawingViewController";

@interface GPDrawingViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic, strong) UICollectionView           *collectionView;
@property (nonatomic, strong) UICollectionViewFlowLayout *collectionLayout;
@property (nonatomic, strong) NSMutableArray <GPDrawModel *>*modelArray;

@end

@implementation GPDrawingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUI];
}

- (void)setUI {
    [self.view addSubview:self.collectionView];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(0);
        make.top.mas_equalTo(Height_NavBar + 10);
    }];
}

- (NSMutableArray <GPDrawModel *>*)modelArray {
    if (!_modelArray) {
        _modelArray = [NSMutableArray array];
        [[DBTool shareInstance] getDrawing:^(NSArray *drawings) {
            self->_modelArray = [drawings mutableCopy];
        }];
    }
    return _modelArray;
}

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:self.collectionLayout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.backgroundColor = GPBackgroundColor;
        _collectionView.showsVerticalScrollIndicator = NO;
        [_collectionView registerClass:[GPCollectionViewCell class] forCellWithReuseIdentifier:GPDrawingViewControllerCellID];
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


#pragma make - delegate & datesource

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.modelArray.count + 1;
}
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    GPCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:GPDrawingViewControllerCellID forIndexPath:indexPath];
    if (cell == nil) {
        cell = [[GPCollectionViewCell alloc] init];
    }
    if (indexPath.row == 0) {
        [cell setGPDrawModel:[[GPDrawModel alloc] init]];
    } else {
        if (self.modelArray.count > 0) {
            [cell setGPDrawModel:self.modelArray[indexPath.row - 1]];
        }
    }
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row > 0) {
        __block GPDrawModel *model = self.modelArray[indexPath.row - 1];
        __block NSArray *items = @[@"编辑",@"删除"];
        [UIAlertController setSheetTitle:@"操作选择" msg:@"" ctr:self items:items handler:^(UIAlertAction * _Nullable action) {
            if ([items containsObject:action.title]) {
                NSInteger index = [items indexOfObject:action.title];
                if (index == 0) { // 编辑
                    GPDrawViewController *vc = [[GPDrawViewController alloc] init];
                    vc.hidesBottomBarWhenPushed = YES;
                    vc.drawModel = model;
                    vc.refreshBlock = ^{
                        [[DBTool shareInstance] getDrawing:^(NSArray *drawings) {
                            [self.modelArray removeAllObjects];
                            self.modelArray = [drawings mutableCopy];
                            [self.collectionView reloadData];
                        }];
                    };
                    [self.navigationController pushViewController:vc animated:YES];
                } else { // 删除
                    [UIAlertController setTitle:@"操作提示" msg:@"确定要删除这个画板吗？" ctr:self sureHandler:^(UIAlertAction * _Nonnull action) {
                        [[DBTool shareInstance] deleteDrawingWith:model complate:^(BOOL success) {
                            if (success && [self.modelArray containsObject:model]) {
                                [self.modelArray removeObject:model];
                                [self.collectionView reloadData];
                            } else {
                                [UIAlertController setTipsTitle:@"失败提示" msg:@"删除这个画板时发生了错误，请重试！" ctr:self handler:^(UIAlertAction * _Nullable action) {
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
    } else {
        GPDrawViewController *vc = [[GPDrawViewController alloc] init];
        vc.hidesBottomBarWhenPushed = YES;
        vc.refreshBlock = ^{
            [[DBTool shareInstance] getDrawing:^(NSArray *drawings) {
                [self.modelArray removeAllObjects];
                self.modelArray = [drawings mutableCopy];
                [self.collectionView reloadData];
            }];
        };
        [self.navigationController pushViewController:vc animated:YES];
    }
}
@end
