//
//  GPCourseInputViewController.h
//  GraduationProject
//
//  Created by CYM on 2020/4/26.
//  Copyright © 2020年 CYM. All rights reserved.
//

#import <UIKit/UIKit.h>

@class GPCurriculumModel;

typedef void (^ReturnGPCurriculumModelBlock)(GPCurriculumModel *model);

@interface GPCourseInputViewController : GPBaseViewController

@property (nonatomic, assign) NSInteger week;
@property (nonatomic, assign) NSInteger section;
@property (nonatomic, assign) BOOL isSingle;
@property (nonatomic, assign) BOOL isDouble;
@property (nonatomic, strong) GPCurriculumModel *model;
@property (nonatomic, copy  ) ReturnGPCurriculumModelBlock returnBlock;
- (void)returnModel:(ReturnGPCurriculumModelBlock)block;

@end

