//
//  GPCurriculumViewModel.h
//  GraduationProject
//
//  Created by CYM on 2020/4/30.
//  Copyright © 2020年 CYM. All rights reserved.
//

#import <Foundation/Foundation.h>

@class GPCurriculumModel;

@interface GPCurriculumViewModel : NSObject

@property (nonatomic, strong) NSMutableArray<GPCurriculumModel *>* singleCurriculumModels;
@property (nonatomic, strong) NSMutableArray<GPCurriculumModel *>* doubleCurriculumModels;
@property (nonatomic, strong) NSMutableArray<GPCurriculumModel *>* thisWeekCurriculumModels;
@property (nonatomic, assign) BOOL isDoubleMode;

- (void)getCurriculums:(void(^)(void))finish;
- (void)setTheDataToBeDisplayedThisWeek;
- (void)saveSingleCurriculums;
- (void)saveDoubleCurriculums;
- (void)deleteCurriculumWith:(GPCurriculumModel *)model complate:(void(^)(BOOL success))complate;
- (instancetype)initWithData;
@end
