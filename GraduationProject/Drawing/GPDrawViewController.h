//
//  GPDrawViewController.h
//  GraduationProject
//
//  Created by CYM on 2020/4/21.
//  Copyright © 2020年 CYM. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class GPDrawModel;

typedef void(^RefreshBlock)(void);

@interface GPDrawViewController : GPBaseViewController

@property (nonatomic, copy) RefreshBlock refreshBlock;

@property (nonatomic, strong) GPDrawModel *drawModel;

@end

NS_ASSUME_NONNULL_END
