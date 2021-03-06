//
//  GPTimeTableInputViewController.h
//  GraduationProject
//
//  Created by CYM on 2020/4/26.
//  Copyright © 2020年 CYM. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GPTimeTableBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

typedef void (^RefreshReturnBlock)(void);

@interface GPTimeTableInputViewController :GPTimeTableBaseViewController
@property (nonatomic, copy) RefreshReturnBlock refreshBlock;
- (void)triggerRefreshBlock:(RefreshReturnBlock)block;
@end

NS_ASSUME_NONNULL_END
