//
//  GPCurriculumModel.h
//  GraduationProject
//
//  Created by CYM on 2020/4/28.
//  Copyright © 2020年 CYM. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface GPCurriculumModel : NSObject

@property (nonatomic, assign) NSInteger week;
@property (nonatomic, assign) NSInteger section;

@property (nonatomic, copy) NSString *curriculum;
@property (nonatomic, copy) NSString *classroom;
@property (nonatomic, copy) NSString *teacher;

@property (nonatomic, copy) NSString *curriculum2;
@property (nonatomic, copy) NSString *classroom2;
@property (nonatomic, copy) NSString *teacher2;

@property (nonatomic, assign) BOOL isSingle;
@property (nonatomic, assign) BOOL isDouble;

@property (nonatomic, copy) NSString *numberStr;

@end

NS_ASSUME_NONNULL_END
