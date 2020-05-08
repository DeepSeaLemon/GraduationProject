//
//  GPNoteViewModel.m
//  GraduationProject
//
//  Created by CYM on 2020/5/7.
//  Copyright © 2020年 CYM. All rights reserved.
//

#import "GPNoteViewModel.h"

@implementation GPNoteViewModel

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
