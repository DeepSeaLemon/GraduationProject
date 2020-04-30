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
#import "Tools/UIColor+GP.h"
#import "DBTool.h"
#import "Tools/NSDate+GP.h"

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
#endif /* DefineFile_h */
