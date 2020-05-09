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

// NSUserDefaults'keys

#define key_timeTable_theWeekIsDouble @"weekIsDouble"
#define key_timeTable_theFirstDay @"firstDay"
#define key_account_titles @"accountTitles"
#endif /* DefineFile_h */
