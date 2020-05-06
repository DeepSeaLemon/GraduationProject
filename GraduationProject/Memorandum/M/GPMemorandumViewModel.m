//
//  GPMemorandumViewModel.m
//  GraduationProject
//
//  Created by CYM on 2020/5/5.
//  Copyright © 2020年 CYM. All rights reserved.
//

#import "GPMemorandumViewModel.h"
#import "GPMemorandumModel.h"

@implementation GPMemorandumViewModel

- (instancetype)initWithData {
    if (self = [super init]) {
        [[DBTool shareInstance] getMemorandum:^(NSArray *memorandums) {
            self.modelsArray = [NSMutableArray arrayWithArray:memorandums];
        }];
    }
    return self;
}

- (void)getMemorandums {
    [self.modelsArray removeAllObjects];
    [[DBTool shareInstance] getMemorandum:^(NSArray *memorandums) {
        self.modelsArray = [NSMutableArray arrayWithArray:memorandums];
    }];
}

- (void)saveMemorandums:(void (^)(BOOL success))finish {
    [self.modelsArray enumerateObjectsUsingBlock:^(GPMemorandumModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [[DBTool shareInstance] saveMemorandumWith:obj complate:^(BOOL success) {
            !finish?:finish(success);
        }];
    }];
}

- (NSMutableArray <GPMemorandumModel *>*)modelsArray {
    if (!_modelsArray) {
        _modelsArray = [NSMutableArray array];
    }
    return _modelsArray;
}

@end
