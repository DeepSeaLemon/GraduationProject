//
//  GPNoteViewModel.h
//  GraduationProject
//
//  Created by CYM on 2020/5/7.
//  Copyright © 2020年 CYM. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class GPNoteModel;
@class GPNoteContentModel;

@interface GPNoteViewModel : NSObject

@property (nonatomic, strong)NSMutableArray <GPNoteModel *>*notes;
@property (nonatomic, strong)NSMutableArray <GPNoteContentModel *> *currentNoteContents;

- (void)reloadCurrentNoteContentsWith:(GPNoteModel *)model finish:(void(^)(BOOL finish))finish;
- (void)reloadNotes:(void(^)(BOOL finish))finish;
- (instancetype)initWithData;

@end

NS_ASSUME_NONNULL_END
