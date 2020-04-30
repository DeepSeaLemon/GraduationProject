//
//  GPTimeTableDoubleInputViewController.m
//  GraduationProject
//
//  Created by CYM on 2020/4/26.
//  Copyright © 2020年 CYM. All rights reserved.
//

#import "GPTimeTableDoubleInputViewController.h"
#import "GPCourseInputViewController.h"
#import "GPCourseShowCell.h"
#import "GPCurriculumModel.h"

static NSString *GPTimeTableDoubleInputViewControllerCellID = @"GPTimeTableDoubleInputViewController";

@interface GPTimeTableDoubleInputViewController ()<UICollectionViewDataSource,UICollectionViewDelegate>
@property (nonatomic, copy  ) NSMutableArray<GPCurriculumModel *>* modelArray;
@end

@implementation GPTimeTableDoubleInputViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setLeftBackButton];
    [self setRightText:@"完成"];
    [self setTitle:@"双周课程表录入"];
    [self initUI];
}

- (void)initUI {
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:self.collectionLayout];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.collectionView.backgroundColor = [UIColor whiteColor];
    self.collectionView.showsVerticalScrollIndicator = NO;
    [self.collectionView registerClass:[GPCourseShowCell class] forCellWithReuseIdentifier:GPTimeTableDoubleInputViewControllerCellID];
    [self.view addSubview:self.collectionView];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(0);
        make.top.mas_equalTo(65+50);
        make.left.mas_equalTo((SCREEN_WIDTH - 7)/8);
        make.height.mas_equalTo(404);
    }];
}

- (void)clickRightButton:(UIButton *)sender {
    
}

#pragma make - delegate & datesource

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 7;
}
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 4;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    GPCourseInputViewController *vc = [[GPCourseInputViewController alloc] init];
    vc.week = indexPath.row;
    vc.section = indexPath.section;
    vc.isDouble = YES;
    vc.isSingle = NO;
    [vc returnModel:^(GPCurriculumModel *model) {
        [self.modelArray replaceObjectAtIndex:(model.section * 7 + model.week) withObject:model];
        [collectionView reloadData];
    }];
    [self.navigationController pushViewController:vc animated:YES];
    NSLog(@"%ld - %ld",indexPath.section,indexPath.row);
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    GPCourseShowCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:GPTimeTableDoubleInputViewControllerCellID forIndexPath:indexPath];
    if (cell == nil) {
        cell = [[GPCourseShowCell alloc] init];
    }
    cell.cellType = GPCourseShowCellTypeInputNil;
    NSInteger index = (indexPath.section * 7 + indexPath.row);
    [cell setDataModel:self.modelArray[index]];
    return cell;
}

#pragma mark - lazy
- (NSMutableArray<GPCurriculumModel *>*) modelArray {
    if(!_modelArray) {
        _modelArray = [NSMutableArray arrayWithCapacity:28];
        for (NSInteger i = 0; i < 28; i++) {
            GPCurriculumModel *model = [[GPCurriculumModel alloc] init];
            [_modelArray addObject:model];
        }
    }
    return _modelArray;
}
@end