//
//  DBTool.h
//  GraduationProject
//
//  Created by CYM on 2020/4/28.
//  Copyright © 2020年 CYM. All rights reserved.
//

#import <Foundation/Foundation.h>

@class GPCurriculumModel;
@class GPDrawModel;
@interface DBTool : NSObject

+ (instancetype)shareInstance;

- (void)createAppAllDBs;

- (void)saveCurriculumWith:(GPCurriculumModel *)model complate:(void(^)(BOOL success))complate;

- (void)getCurriculums:(void(^)(NSArray *singleArray))singleDate double:(void(^)(NSArray *doubleArray))doubleDate;

- (void)saveDrawingWith:(GPDrawModel *)model complate:(void(^)(BOOL success))complate;

- (void)getDrawing:(void(^)(NSArray *drawings))draw;
@end


