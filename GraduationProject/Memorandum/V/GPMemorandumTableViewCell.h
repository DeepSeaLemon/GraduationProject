//
//  GPMemorandumTableViewCell.h
//  GraduationProject
//
//  Created by CYM on 2020/4/25.
//  Copyright © 2020年 CYM. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class GPMemorandumModel;

@interface GPMemorandumTableViewCell : UITableViewCell

- (void)setGPMemorandumModel:(GPMemorandumModel *)model;
@end

NS_ASSUME_NONNULL_END
