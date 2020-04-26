//
//  GPTimeTableBaseViewController.m
//  GraduationProject
//
//  Created by CYM on 2020/4/26.
//  Copyright © 2020年 CYM. All rights reserved.
//

#import "GPTimeTableBaseViewController.h"
#import "GPCourseShowCell.h"

static NSString *GPTimeTableBaseViewControllerCellID = @"GPTimeTableBaseViewController";

@interface GPTimeTableBaseViewController ()<UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong) UICollectionView           *collectionView;
@property (nonatomic, strong) UICollectionViewFlowLayout *collectionLayout;

@end

@implementation GPTimeTableBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initPublicUI];
}

- (void)initPublicUI {
    [self.view addSubview:self.listHeaderView];
    [self.listHeaderView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(0);
        make.top.mas_equalTo(65);
    }];
    
    [self.view addSubview:self.collectionView];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(0);
        make.top.mas_equalTo(65+50);
        make.left.mas_equalTo((SCREEN_WIDTH - 7)/8);
        make.height.mas_equalTo(404);
    }];
}

#pragma mark - lazy
- (GPTimeTableListHeaderView *)listHeaderView {
    if (!_listHeaderView) {
        _listHeaderView = [[GPTimeTableListHeaderView alloc] init];
    }
    return _listHeaderView;
}



- (UICollectionView *)collectionView {
    if (!_collectionView) {
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:self.collectionLayout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.showsVerticalScrollIndicator = NO;
        [_collectionView registerClass:[GPCourseShowCell class] forCellWithReuseIdentifier:GPTimeTableBaseViewControllerCellID];
    }
    return _collectionView;
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


#pragma make - delegate & datesource

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 7;
}
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 4;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    GPCourseShowCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:GPTimeTableBaseViewControllerCellID forIndexPath:indexPath];
    if (cell == nil) {
        cell = [[GPCourseShowCell alloc] init];
    }
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"click %ld-%ld",(long)indexPath.section,(long)indexPath.row);
}
@end
