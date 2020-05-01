//
//  GPColorPickerViewController.h
//  GraduationProject
//
//  Created by CYM on 2020/5/1.
//  Copyright © 2020年 CYM. All rights reserved.
//

#import "GPBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

typedef void (^ColorReturnBlock)(UIColor *pickerColor);

@interface GPColorPickerViewController : GPBaseViewController

@property (nonatomic, copy) ColorReturnBlock colorBlock;

@end

NS_ASSUME_NONNULL_END

