//
//  GPCurriculumViewModel.m
//  GraduationProject
//
//  Created by CYM on 2020/4/30.
//  Copyright © 2020年 CYM. All rights reserved.
//

#import "GPCurriculumViewModel.h"
#import "GPCurriculumModel.h"

@implementation GPCurriculumViewModel

- (instancetype)initWithData {
    if (self = [super init]) {
        _singleCurriculumModels = [NSMutableArray arrayWithCapacity:28];
        _doubleCurriculumModels = [NSMutableArray arrayWithCapacity:28];
        for (NSInteger i = 0; i < 28; i++) {
            GPCurriculumModel *model = [[GPCurriculumModel alloc] init];
            [_singleCurriculumModels addObject:model];
            [_doubleCurriculumModels addObject:model];
        }
        [self getCurriculums];
    }
    return self;
}

#pragma mark - db

- (void)getCurriculums {
    __weak typeof(self) weakself = self;
    [[DBTool shareInstance] getCurriculums:^(NSArray *singleArray) {
        if (singleArray.count > 0) {
            [singleArray enumerateObjectsUsingBlock:^(GPCurriculumModel *obj, NSUInteger idx, BOOL * _Nonnull stop) {
                [weakself.singleCurriculumModels replaceObjectAtIndex:(obj.section * 7 + obj.week) withObject:obj];
            }];
        }
    } double:^(NSArray *doubleArray) {
        if (doubleArray.count > 0) {
            [doubleArray enumerateObjectsUsingBlock:^(GPCurriculumModel *obj, NSUInteger idx, BOOL * _Nonnull stop) {
                [weakself.doubleCurriculumModels replaceObjectAtIndex:(obj.section * 7 + obj.week) withObject:obj];
            }];
            weakself.isDoubleMode = YES;
        } else {
            weakself.isDoubleMode = NO;
        }
    }];
}

- (void)saveSingleCurriculums {
    [self.singleCurriculumModels enumerateObjectsUsingBlock:^(GPCurriculumModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (!(obj.numberStr == nil || obj.numberStr.length < 1)) {
            [[DBTool shareInstance] saveCurriculumWith:obj];
        }
    }];
}
- (void)saveDoubleCurriculums {
    [self.doubleCurriculumModels enumerateObjectsUsingBlock:^(GPCurriculumModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (!(obj.numberStr == nil || obj.numberStr.length < 1)) {
            [[DBTool shareInstance] saveCurriculumWith:obj];
        }
    }];
}

@end
