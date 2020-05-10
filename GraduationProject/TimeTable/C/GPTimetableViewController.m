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
#import "GPCurriculumModel.h"
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
        make.top.mas_equalTo(Height_NavBar + 1 +50);
        make.left.mas_equalTo((SCREEN_WIDTH - 7)/8);
        make.height.mas_equalTo(404);
    }];
}

- (void)clickRightButton:(UIButton *)sender {
    GPTimeTableInputViewController *vc = [[GPTimeTableInputViewController alloc] init];
    vc.hidesBottomBarWhenPushed = YES;
    [vc triggerRefreshBlock:^{
        [self.viewModel getCurriculums:^{
            [self.viewModel setTheDataToBeDisplayedThisWeek];
            [self.collectionView reloadData];
        }];
    }];
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
    [cell setDataModel:self.viewModel.thisWeekCurriculumModels[(indexPath.section * 7 + indexPath.row)]];
    if (indexPath.row == ([NSDate getCurrentWeekDayCN] - 1)) {
        [cell setCurrentDayBackGroundViewColor:YES];
    } else {
        [cell setCurrentDayBackGroundViewColor:NO];
    }
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    GPCurriculumModel *model = self.viewModel.thisWeekCurriculumModels[(indexPath.section * 7 + indexPath.row)];
    if (model.curriculum.length > 0) {
        __block NSArray <NSString *>*items = @[@"查看",@"删除"];
        [UIAlertController setSheetTitle:@"操作选择" msg:@"" ctr:self items:items handler:^(UIAlertAction * _Nullable action) {
            if ([items containsObject:action.title]) {
                NSInteger index = [items indexOfObject:action.title];
                if (index == 0) { // 查看
                    [UIAlertController setTipsTitle:[self setClassStrWith:model] msg:[self setMessageStrWith:model] ctr:self handler:^(UIAlertAction * _Nullable action) {
                        // 无操作
                    }];
                } else { // 删除
                    [UIAlertController setTitle:@"操作提示" msg:@"确定要删除这个课程吗？" ctr:self sureHandler:^(UIAlertAction * _Nonnull action) {
                        [self.viewModel deleteCurriculumWith:model complate:^(BOOL success) {
                            if (success) {
                                [self.collectionView reloadData];
                            } else {
                                [UIAlertController setTipsTitle:@"失败提示" msg:@"删除这个课程时发生了错误，请重试！" ctr:self handler:^(UIAlertAction * _Nullable action) {
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

- (NSString *)setMessageStrWith:(GPCurriculumModel *)model {
    NSString *curriculumStr = [NSString stringWithFormat:@"课程:%@\n",model.curriculum];
    NSString *classroomStr = [NSString stringWithFormat:@"教室:%@\n",model.classroom];
    NSString *teacherStr = [NSString stringWithFormat:@"老师:%@\n",model.teacher];
    NSString *curriculumStr2 = [NSString stringWithFormat:@"课程2:%@\n",model.curriculum2];
    NSString *classroomStr2 = [NSString stringWithFormat:@"教室2:%@\n",model.classroom2];
    NSString *teacherStr2 = [NSString stringWithFormat:@"老师2:%@\n",model.teacher2];
    NSString *msg = [NSString stringWithFormat:@"%@%@%@",curriculumStr,classroomStr,teacherStr];
    if (model.curriculum2 != nil && model.curriculum2.length > 0) {
        msg = [NSString stringWithFormat:@"%@%@%@%@%@%@",curriculumStr,classroomStr,teacherStr,curriculumStr2,classroomStr2,teacherStr2];
    }
    return msg;
}

- (NSString *)setClassStrWith:(GPCurriculumModel *)model {
    NSMutableString *str = [NSMutableString string];
    if (model.isSingle) {
        [str appendString:@"单周 "];
    }
    if (model.isDouble) {
        [str appendString:@"双周 "];
    }
    switch (model.week) {
        case 0:
            [str appendString:@"周一 "];
            break;
        case 1:
            [str appendString:@"周二 "];
            break;
        case 2:
            [str appendString:@"周三 "];
            break;
        case 3:
            [str appendString:@"周四 "];
            break;
        case 4:
            [str appendString:@"周五 "];
            break;
        case 5:
            [str appendString:@"周六 "];
            break;
        case 6:
            [str appendString:@"周日 "];
            break;
        default:
            break;
    }
    
    switch (model.section) {
        case 0:
            [str appendString:@"上午 "];
            [str appendString:@"第一节"];
            break;
        case 1:
            [str appendString:@"上午 "];
            [str appendString:@"第二节"];
            break;
        case 2:
            [str appendString:@"下午 "];
            [str appendString:@"第三节"];
            break;
        case 3:
            [str appendString:@"下午 "];
            [str appendString:@"第四节"];
            break;
        default:
            break;
    }
    return str;
}
@end
