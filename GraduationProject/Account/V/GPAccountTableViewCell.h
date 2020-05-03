//
//  GPAccountTableViewCell.h
//  GraduationProject
//
//  Created by CYM on 2020/4/23.
//  Copyright © 2020年 CYM. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class GPAccountModel;

@interface GPAccountTableViewCell : UITableViewCell

- (void)setGPAccountModel:(GPAccountModel *)model;
@end

NS_ASSUME_NONNULL_END
