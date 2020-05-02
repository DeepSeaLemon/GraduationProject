//
//  UIAlertController+GP.h
//  GraduationProject
//
//  Created by CYM on 2020/5/1.
//  Copyright © 2020年 CYM. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIAlertController (GP)

+ (void)setTitle:(NSString *)titleStr msg:(NSString *)msgStr ctr:(UIViewController *)ctr sureHandler:(void(^)(UIAlertAction *action))sureHandler cancelHandler:(void(^)(UIAlertAction *action))cancelHandler;

+ (void)setTipsTitle:(NSString *)titleStr msg:(NSString *)msgStr ctr:(UIViewController *)ctr handler:(void(^)(UIAlertAction * _Nullable action))sureHandler;

+ (void)setSheetTitle:(NSString *)titleStr msg:(NSString *)msgStr ctr:(UIViewController *)ctr items:(NSArray <NSString *>*)itemsArr handler:(void(^)(UIAlertAction * _Nullable action))handler;

+ (void)setTextFieldTitle:(NSString *)titleStr msg:(NSString *)msgStr placeholder:(NSString *)placeholderStr ctr:(UIViewController *)ctr textReturn:(void(^)(NSString * text))textReturn;

@end

NS_ASSUME_NONNULL_END
