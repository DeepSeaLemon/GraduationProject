//
//  DefineFile.h
//  GraduationProject
//
//  Created by CYM on 2020/4/18.
//  Copyright © 2020年 CYM. All rights reserved.
//

#ifndef DefineFile_h
#define DefineFile_h

// Tools
#import "Tools/DBTool.h"
#import "Tools/GPFileManager.h"
#import "Tools/UIColor+GP.h"
#import "Tools/NSDate+GP.h"
#import "Tools/UIImage+GP.h"
#import "Tools/UITextField+GP.h"
#import "Tools/UIAlertController+GP.h"
#import "Tools/CXDatePickerView/NSDate+CXCategory.h"
#import "Tools/UIBezierPath+GP.h"

// Bridging-Header
#import "GraduationProject-Bridging-Header.h"

// Base
#import "Base/GPBaseViewController.h"

// Pods
#import <Masonry/Masonry.h>

// Colors
#define GPBackgroundColor [UIColor colorWithHexString:@"F5F5F5"]
#define GPGreenColor [UIColor colorWithHexString:@"54DE28"]
#define GPRedColor [UIColor colorWithHexString:@"FF4F4F"]
#define GPBlueColor [UIColor colorWithHexString:@"1AACFF"]
#define GPGrayColor [UIColor colorWithHexString:@"FAFAFA"]
#define GPDeepGrayColor [UIColor colorWithHexString:@"CDCDCD"]


// Device
#define SCREEN_WIDTH ([[UIScreen mainScreen] bounds].size.width)
#define SCREEN_HEIGHT ([[UIScreen mainScreen] bounds].size.height)
// 判断是否是ipad
#define isPad ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad)
// 判断iPhone4系列
#define kiPhone4 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 960), [[UIScreen mainScreen] currentMode].size) && !isPad : NO)
// 判断iPhone5系列
#define kiPhone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) && !isPad : NO)
// 判断iPhone6系列
#define kiPhone6 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(750, 1334), [[UIScreen mainScreen] currentMode].size) && !isPad : NO)
//判断iphone6+系列
#define kiPhone6Plus ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2208), [[UIScreen mainScreen] currentMode].size) && !isPad : NO)
// 判断iPhoneX
#define IS_IPHONE_X ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) && !isPad : NO)
// 判断iPHoneXr
#define IS_IPHONE_Xr ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(828, 1792), [[UIScreen mainScreen] currentMode].size) && !isPad : NO)
// 判断iPhoneXs
#define IS_IPHONE_Xs ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) && !isPad : NO)
// 判断iPhoneXs Max
#define IS_IPHONE_Xs_Max ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2688), [[UIScreen mainScreen] currentMode].size) && !isPad : NO)

#define Height_StatusBar ((IS_IPHONE_X == YES || IS_IPHONE_Xr == YES || IS_IPHONE_Xs == YES || IS_IPHONE_Xs_Max == YES) ? 44.0 : 20.0)
#define Height_NavBar    ((IS_IPHONE_X == YES || IS_IPHONE_Xr == YES || IS_IPHONE_Xs == YES || IS_IPHONE_Xs_Max == YES) ? 88.0 : 64.0)
#define Height_TabBar    ((IS_IPHONE_X == YES || IS_IPHONE_Xr == YES || IS_IPHONE_Xs == YES || IS_IPHONE_Xs_Max == YES) ? 83.0 : 49.0)

// NSUserDefaults'keys

#define key_timeTable_theWeekIsDouble @"weekIsDouble"
#define key_timeTable_theFirstDay @"firstDay"
#define key_account_titles @"accountTitles"
#endif /* DefineFile_h */
