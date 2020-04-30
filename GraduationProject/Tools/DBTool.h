//
//  DBTool.h
//  GraduationProject
//
//  Created by CYM on 2020/4/28.
//  Copyright © 2020年 CYM. All rights reserved.
//

#import <Foundation/Foundation.h>

@class GPCurriculumModel;

@interface DBTool : NSObject

+ (instancetype)shareInstance;

- (void)createAppAllDBs;

- (void)saveCurriculumWith:(GPCurriculumModel *)model;

- (void)getCurriculums:(void(^)(NSArray *singleArray))singleDate double:(void(^)(NSArray *doubleArray))doubleDate;
@end


