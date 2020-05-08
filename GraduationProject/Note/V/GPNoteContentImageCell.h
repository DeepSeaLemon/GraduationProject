//
//  GPNoteContentImageCell.h
//  GraduationProject
//
//  Created by CYM on 2020/5/8.
//  Copyright © 2020年 CYM. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class GPNoteContentModel;

@interface GPNoteContentImageCell : UITableViewCell

- (void)setGPNoteContentModel:(GPNoteContentModel *)model;
- (void)setPage:(NSInteger)index;

@end

NS_ASSUME_NONNULL_END
