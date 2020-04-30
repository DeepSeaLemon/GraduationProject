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

@property (nonatomic, assign) BOOL isDoubleMode;

- (void)getCurriculums;
- (void)saveSingleCurriculums;
- (void)saveDoubleCurriculums;
- (instancetype)initWithData;
@end
