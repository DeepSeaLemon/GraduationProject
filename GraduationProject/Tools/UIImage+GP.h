//
//  UIImage+GP.h
//  GraduationProject
//
//  Created by CYM on 2020/5/1.
//  Copyright © 2020年 CYM. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (GP)

+ (UIImage *)imageWithColor:(UIColor *)color;

+ (UIImage *)scaleImage:(UIImage *)image toScale:(float)scaleSize;

+ (UIImage *)convertViewToImage:(UIView *)view;

@end

NS_ASSUME_NONNULL_END
