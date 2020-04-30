//
//  GPTimeTableInputViewController.m
//  GraduationProject
//
//  Created by CYM on 2020/4/26.
//  Copyright © 2020年 CYM. All rights reserved.
//

#import "GPTimeTableInputViewController.h"
#import "GPTimeTableDoubleInputViewController.h"
#import "GPCourseInputViewController.h"
#import "GPItemView.h"
#import "GPCourseShowCell.h"
#import "GPCurriculumModel.h"

static NSString *GPTimeTableInputViewControllerCellID = @"GPTimeTableInputViewController";

@interface GPTimeTableInputViewController ()<GPItemViewDelegate,UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic, strong) GPItemView *modeSwitchItem;
@property (nonatomic, strong) GPItemView *inputItem;
@property (nonatomic, assign) BOOL doubleSwitchOn;
@property (nonatomic, strong) NSMutableArray<GPCurriculumModel *>* modelArray;

@end

@implementation GPTimeTableInputViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setLeftBackButton];
    [self setRightText:@"完成"];
    [self setTitle:@"课程表录入"];
    self.modelArray = [self.viewModel.singleCurriculumModels mutableCopy];
    [self initUI];
}

- (void)initUI {
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:self.collectionLayout];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.collectionView.backgroundColor = [UIColor whiteColor];
    self.collectionView.showsVerticalScrollIndicator = NO;
    [self.collectionView registerClass:[GPCourseShowCell class] forCellWithReuseIdentifier:GPTimeTableInputViewControllerCellID];
    [self.view addSubview:self.collectionView];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(0);
        make.top.mas_equalTo(65+50);
        make.left.mas_equalTo((SCREEN_WIDTH - 7)/8);
        make.height.mas_equalTo(404);
    }];
    
    [self.view addSubview:self.modeSwitchItem];
    [self.modeSwitchItem mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(65+450+5);
        make.left.right.mas_equalTo(0);
        make.height.mas_equalTo(50);
    }];
    
    [self.view addSubview:self.inputItem];
    [self.inputItem mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.modeSwitchItem.mas_bottom).offset(1);
        make.left.right.mas_equalTo(0);
        make.height.mas_equalTo(50);
    }];
}

- (void)clickRightButton:(UIButton *)sender {
    self.viewModel.singleCurriculumModels = self.modelArray;
    [self.viewModel saveSingleCurriculums];
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
    vc.isDouble = NO;
    vc.isSingle = self.doubleSwitchOn;
    GPCurriculumModel *currentModel = self.modelArray[(indexPath.section * 7 + indexPath.row)];
    if (currentModel.numberStr.length > 0) {
        vc.model = currentModel;
    }
    [vc returnModel:^(GPCurriculumModel *model) {
        [self->_modelArray replaceObjectAtIndex:(model.section * 7 + model.week) withObject:model];
        [collectionView reloadData];
    }];
    [self.navigationController pushViewController:vc animated:YES];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    GPCourseShowCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:GPTimeTableInputViewControllerCellID forIndexPath:indexPath];
    if (cell == nil) {
        cell = [[GPCourseShowCell alloc] init];
    }
    cell.cellType = GPCourseShowCellTypeInputNil;
    NSInteger index = (indexPath.section * 7 + indexPath.row);
    [cell setDataModel:self.modelArray[index]];
    [cell setCurrentDayBackGroundViewColor:NO];
    return cell;
}

#pragma mark - GPItemViewDelegate

- (void)itemViewClicked {
    GPTimeTableDoubleInputViewController *vc = [[GPTimeTableDoubleInputViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)itemSwitchChanged:(BOOL)isOn itemView:(GPItemView *)itemView {
    self.inputItem.hidden = !isOn;
    self.doubleSwitchOn = isOn;
    if (!isOn) {
        [self setTitle:@"课程表录入"];
    } else {
        [self setTitle:@"单周课程表录入"];
    }
}

#pragma mark - lazy

- (GPItemView *)modeSwitchItem {
    if (!_modeSwitchItem) {
        _modeSwitchItem = [[GPItemView alloc] init];
        _modeSwitchItem.isSwitch = YES;
        _modeSwitchItem.delegate = self;
        _modeSwitchItem.hidden = NO;
        [_modeSwitchItem setItemViewTitle:@"单双周模式"];
    }
    return _modeSwitchItem;
}

- (GPItemView *)inputItem {
    if (!_inputItem) {
        _inputItem = [[GPItemView alloc] init];
        _inputItem.isSwitch = NO;
        _inputItem.delegate = self;
        _inputItem.hidden = YES;
        [_inputItem setItemViewTitle:@"录入双周课程"];
    }
    return _inputItem;
}
@end
