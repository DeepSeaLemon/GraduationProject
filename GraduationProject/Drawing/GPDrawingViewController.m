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

static NSString *ID = @"CELL";

@interface GPDrawingViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) UICollectionViewFlowLayout *collectionLayout;
@end

@implementation GPDrawingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUI];
}

- (void)setUI {
    [self.view addSubview:self.collectionView];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.mas_equalTo(0);
        make.right.bottom.mas_equalTo(0);
    }];
}

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:self.collectionLayout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.backgroundColor = GPBackgroundColor;
        _collectionView.showsVerticalScrollIndicator = NO;
        [_collectionView registerClass:[GPCollectionViewCell class] forCellWithReuseIdentifier:ID];
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
    return 1;
}
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    GPCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ID forIndexPath:indexPath];
    if (cell == nil) {
        cell = [[GPCollectionViewCell alloc] init];
    }
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"click %ld-%ld",(long)indexPath.section,(long)indexPath.row);
    GPDrawViewController *vc = [[GPDrawViewController alloc] init];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}
@end
