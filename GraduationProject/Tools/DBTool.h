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
@class GPAccountModel;
@class GPMemorandumModel;
@class GPNoteModel;
@class GPNoteContentModel;

@interface DBTool : NSObject

+ (instancetype)shareInstance;

- (void)createAppAllDBs;

// 课程表
- (void)saveCurriculumWith:(GPCurriculumModel *)model complate:(void(^)(BOOL success))complate;
- (void)getCurriculums:(void(^)(NSArray *singleArray))singleDate double:(void(^)(NSArray *doubleArray))doubleDate;

// 画图
- (void)saveDrawingWith:(GPDrawModel *)model complate:(void(^)(BOOL success))complate;
- (void)getDrawing:(void(^)(NSArray *drawings))draw;

// 账本
- (void)saveAccountWith:(GPAccountModel *)model complate:(void(^)(BOOL success))complate;
- (void)getAccount:(void(^)(NSArray *accounts))account;

// 备忘录
- (void)saveMemorandumWith:(GPMemorandumModel *)model complate:(void(^)(BOOL success))complate;
- (void)getMemorandum:(void(^)(NSArray *memorandums))memorandum;
- (void)deleteMemorandumWith:(NSString *)numberStr complate:(void(^)(BOOL success))complate;

// 笔记本
- (void)saveNoteWith:(GPNoteModel *)model complate:(void(^)(BOOL success))complate;
- (void)getNote:(void(^)(NSArray *notes))note;

- (void)saveNoteContentWith:(GPNoteContentModel *)contentModel complate:(void(^)(BOOL success))complate;
- (void)getNoteContentWith:(GPNoteModel *)noteModel noteContents:(void(^)(NSArray *noteContents))noteContent;

@end


