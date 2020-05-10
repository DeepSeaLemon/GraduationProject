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
#import "GPItemView.h"

static NSString *GPTimeTableDoubleInputViewControllerCellID = @"GPTimeTableDoubleInputViewController";

@interface GPTimeTableDoubleInputViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,GPItemViewDelegate>

@property (nonatomic, strong) NSMutableArray<GPCurriculumModel *>* modelArray;
@property (nonatomic, strong) GPItemView *isDoubleSwitchItem;
@property (nonatomic, assign) BOOL weekIsDouble;

@end

@implementation GPTimeTableDoubleInputViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setLeftBackButton];
    [self setRightText:@"完成"];
    [self setTitle:@"双周课程表录入"];
    self.modelArray = [self.viewModel.doubleCurriculumModels mutableCopy];
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
        make.top.mas_equalTo(Height_NavBar+1+50);
        make.left.mas_equalTo((SCREEN_WIDTH - 7)/8);
        make.height.mas_equalTo(404);
    }];
    
    [self.view addSubview:self.isDoubleSwitchItem];
    [self.isDoubleSwitchItem mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(Height_NavBar+1+450+5);
        make.left.right.mas_equalTo(0);
        make.height.mas_equalTo(50);
    }];
}

- (void)clickRightButton:(UIButton *)sender {
    self.viewModel.doubleCurriculumModels = self.modelArray;
    [self.viewModel saveDoubleCurriculums];
    // 保存到userdefine
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    [user setObject:[NSNumber numberWithBool:self.weekIsDouble] forKey:key_timeTable_theWeekIsDouble];
    [user setObject:[NSDate getFirstDayOfWeek] forKey:key_timeTable_theFirstDay];
    [self.navigationController popViewControllerAnimated:YES];
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
    GPCurriculumModel *currentModel = self.modelArray[(indexPath.section * 7 + indexPath.row)];
    if (currentModel.numberStr.length > 0) {
        vc.model = currentModel;
    }
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
    [cell setCurrentDayBackGroundViewColor:NO];
    return cell;
}

- (void)itemSwitchChanged:(BOOL)isOn itemView:(GPItemView *)itemView {
    self.weekIsDouble = isOn;
}

#pragma mark - lazy

- (GPItemView *)isDoubleSwitchItem {
    if (!_isDoubleSwitchItem) {
        _isDoubleSwitchItem = [[GPItemView alloc] init];
        _isDoubleSwitchItem.isSwitch = YES;
        _weekIsDouble = YES;
        _isDoubleSwitchItem.delegate = self;
        [_isDoubleSwitchItem setItemSwitchStatus:YES];
        [_isDoubleSwitchItem setItemViewTitle:@"本周为双周"];
    }
    return _isDoubleSwitchItem;
}

@end
