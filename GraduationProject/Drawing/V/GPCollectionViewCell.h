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

@interface GPCollectionViewCell : UICollectionViewCell

- (void)setGPDrawModel:(GPDrawModel *)model;

@end

NS_ASSUME_NONNULL_END
