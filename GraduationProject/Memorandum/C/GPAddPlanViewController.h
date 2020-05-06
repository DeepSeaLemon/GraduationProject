//
//  GPAddPlanViewController.h
//  GraduationProject
//
//  Created by CYM on 2020/4/24.
//  Copyright © 2020年 CYM. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class GPMemorandumModel;

typedef void(^ReturnModelBlock)(GPMemorandumModel *model);

@interface GPAddPlanViewController : GPBaseViewController

@property (nonatomic, copy) ReturnModelBlock returnModelBlock;

@end

NS_ASSUME_NONNULL_END
