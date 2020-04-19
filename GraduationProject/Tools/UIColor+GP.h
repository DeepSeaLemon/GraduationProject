//
//  UIColor+GP.h
//  GraduationProject
//
//  Created by CYM on 2020/4/19.
//  Copyright © 2020年 CYM. All rights reserved.
//

#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN

@interface UIColor (GP)

/**
 根据RGB颜色值生成UIColor
 */
+ (UIColor *)colorFromRGB:(NSInteger)rgbValue withAlpha:(CGFloat)alpha;
+ (UIColor *)colorFromRGB:(NSInteger)rgbValue;



/**
 根据十六进制颜色值生成UIColor
 */
+ (UIColor *)colorWithHexString:(NSString *)hexString;



/**
 根据十六进制颜色值生成UIColor
 */
+ (UIColor *)colorWithHexString:(NSString *)hexString alpha:(CGFloat)alpha;
+ (UIColor *)colorWithHexStringWithAlpha:(NSString *)hexString;

@end

NS_ASSUME_NONNULL_END
