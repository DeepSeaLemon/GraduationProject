//
//  GPMemorandumViewModel.h
//  GraduationProject
//
//  Created by CYM on 2020/5/5.
//  Copyright © 2020年 CYM. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class GPMemorandumModel;

@interface GPMemorandumViewModel : NSObject

@property (nonatomic, strong) NSMutableArray <GPMemorandumModel *>*modelsArray;

- (void)getMemorandums:(void (^)(BOOL success))finish;

- (void)saveMemorandums:(void (^)(BOOL success))finish;

- (instancetype)initWithData;

@end

NS_ASSUME_NONNULL_END
