//
//  GPCollectionViewCell.h
//  CollectionTest
//
//  Created by CYM on 2020/4/20.
//  Copyright © 2020年 CYM. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class GPDrawModel;
@class GPNoteModel;

@interface GPCollectionViewCell : UICollectionViewCell

- (void)setTitle:(NSString *)title;

- (void)setGPDrawModel:(GPDrawModel *)model;

- (void)setGPNoteModel:(GPNoteModel *)model;

@end

NS_ASSUME_NONNULL_END
