//
//  GPTimeTableBaseViewController.m
//  GraduationProject
//
//  Created by CYM on 2020/4/26.
//  Copyright © 2020年 CYM. All rights reserved.
//

#import "GPTimeTableBaseViewController.h"
#import "GPCourseShowCell.h"

@interface GPTimeTableBaseViewController ()

@end

@implementation GPTimeTableBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.viewModel = [[GPCurriculumViewModel alloc] initWithData];
    [self initPublicUI];
}

- (void)initPublicUI {
    [self.view addSubview:self.listHeaderView];
    [self.listHeaderView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(0);
        make.top.mas_equalTo(65);
    }];
}

#pragma mark - lazy
- (GPTimeTableListHeaderView *)listHeaderView {
    if (!_listHeaderView) {
        _listHeaderView = [[GPTimeTableListHeaderView alloc] init];
    }
    return _listHeaderView;
}

- (UICollectionViewLayout *)collectionLayout {
    if (!_collectionLayout) {
        _collectionLayout = [[UICollectionViewFlowLayout alloc] init];
        CGFloat width = (SCREEN_WIDTH - 7)/8;
        _collectionLayout.itemSize = CGSizeMake(width, 100);
        CGFloat margin = 0.5;
        _collectionLayout.sectionInset = UIEdgeInsetsMake(1, margin, 0, margin);
        _collectionLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
        _collectionLayout.minimumLineSpacing = 1;
        _collectionLayout.minimumInteritemSpacing = 1;
    }
    return _collectionLayout;
}

@end
