//
//  GPAddAccountViewController.h
//  GraduationProject
//
//  Created by CYM on 2020/4/23.
//  Copyright © 2020年 CYM. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class GPAccountModel;

typedef void(^ReturnModelBlock)(GPAccountModel *model);

@interface GPAddAccountViewController : GPBaseViewController

@property (nonatomic, copy) ReturnModelBlock returnModelBlock;

@end

NS_ASSUME_NONNULL_END
