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

- (void)deleteMemorandum:(GPMemorandumModel *)model complate:(void(^)(BOOL success))complate {
    [[DBTool shareInstance] deleteMemorandumWith:model.numberStr complate:^(BOOL success) {
        if (success && [self.modelsArray containsObject:model]) {
            [self.modelsArray removeObject:model];
        }
        !complate?:complate(success);
    }];
}

- (instancetype)initWithData {
    if (self = [super init]) {
        [self getMemorandums:^(BOOL success) {
            // 
        }];
    }
    return self;
}

- (void)getMemorandums:(void (^)(BOOL success))finish{
    [self.modelsArray removeAllObjects];
    [[DBTool shareInstance] getMemorandum:^(NSArray *memorandums) {
        NSArray *sortArray = [memorandums sortedArrayWithOptions:NSSortStable usingComparator:
                              ^NSComparisonResult(GPMemorandumModel *obj1,GPMemorandumModel *obj2) {
                                  int value1 = [obj1.sortTime intValue];
                                  int value2 = [obj2.sortTime intValue];
                                  if (value1 > value2) {
                                      return NSOrderedDescending;
                                  }else if (value1 == value2){
                                      return NSOrderedSame;
                                  }else{
                                      return NSOrderedAscending;
                                  }
                              }];
        self.modelsArray = [NSMutableArray arrayWithArray:sortArray];
        !finish?:finish(YES);
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
