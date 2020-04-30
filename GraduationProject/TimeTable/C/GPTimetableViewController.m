//
//  GPTimetableViewController.m
//  GraduationProject
//
//  Created by CYM on 2020/4/18.
//  Copyright © 2020年 CYM. All rights reserved.
//

#import "GPTimetableViewController.h"
#import "GPTimeTableInputViewController.h"
#import "GPCourseShowCell.h"

static NSString *GPTimetableViewControllerCellID = @"GPTimetableViewController";

@interface GPTimetableViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>

@end

@implementation GPTimetableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setFirstClassNavWith:@"课程表" imageName:@"setting.png"];
    [self initUI];
}

- (void)initUI {
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:self.collectionLayout];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.collectionView.backgroundColor = [UIColor whiteColor];
    self.collectionView.showsVerticalScrollIndicator = NO;
    [self.collectionView registerClass:[GPCourseShowCell class] forCellWithReuseIdentifier:GPTimetableViewControllerCellID];
    [self.view addSubview:self.collectionView];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(0);
        make.top.mas_equalTo(65+50);
        make.left.mas_equalTo((SCREEN_WIDTH - 7)/8);
        make.height.mas_equalTo(404);
    }];
}

- (void)clickRightButton:(UIButton *)sender {
    GPTimeTableInputViewController *vc = [[GPTimeTableInputViewController alloc] init];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma make - delegate & datesource

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 7;
}
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 4;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    GPCourseShowCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:GPTimetableViewControllerCellID forIndexPath:indexPath];
    if (cell == nil) {
        cell = [[GPCourseShowCell alloc] init];
    }
    cell.cellType = GPCourseShowCellTypeShowNil;
    [cell setDataModel:self.viewModel.singleCurriculumModels[(indexPath.section * 7 + indexPath.row)]];
    if (indexPath.row == ([NSDate getCurrentWeekDayCN] - 1)) {
        [cell setCurrentDayBackGroundViewColor:YES];
    } else {
        [cell setCurrentDayBackGroundViewColor:NO];
    }
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"click %ld-%ld",(long)indexPath.section,(long)indexPath.row);
}
@end
