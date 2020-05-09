//
//  GPNoteViewModel.m
//  GraduationProject
//
//  Created by CYM on 2020/5/7.
//  Copyright © 2020年 CYM. All rights reserved.
//

#import "GPNoteViewModel.h"

@implementation GPNoteViewModel

- (void)deleteNoteContentWith:(GPNoteContentModel *)model complate:(void(^)(BOOL success))complate {
    [[DBTool shareInstance] deleteNoteContentWith:model complate:^(BOOL success) {
        if (success && [self.currentNoteContents containsObject:model]) {
            [self.currentNoteContents removeObject:model];
            !complate?:complate(YES);
        } else {
            !complate?:complate(NO);
        }
    }];
}

- (void)deleteNoteWith:(GPNoteModel *)model complate:(void(^)(BOOL success))complate {
    [[DBTool shareInstance] deleteNoteWith:model complate:^(BOOL success) {
        if (success && [self.notes containsObject:model]) {
            [self.notes removeObject:model];
            !complate?:complate(YES);
        } else {
            !complate?:complate(NO);
        }
    }];
}

- (void)reloadNotes:(void (^)(BOOL))finish {
    [[DBTool shareInstance] getNote:^(NSArray *notes) {
        self.notes = [NSMutableArray arrayWithArray:notes];
        !finish?:finish(YES);
    }];
}

- (void)reloadCurrentNoteContentsWith:(GPNoteModel *)model finish:(void(^)(BOOL finish))finish {
    [[DBTool shareInstance] getNoteContentWith:model noteContents:^(NSArray *noteContents) {
        self.currentNoteContents = [NSMutableArray arrayWithArray:noteContents];
        !finish?:finish(YES);
    }];
}

- (instancetype)initWithData {
    if (self = [super init]) {
        self.currentNoteContents = [NSMutableArray array];
        [[DBTool shareInstance] getNote:^(NSArray *notes) {
            self.notes = [NSMutableArray arrayWithArray:notes];
        }];
    }
    return self;
}

@end
