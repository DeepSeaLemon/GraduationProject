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

// Device
#define SCREEN_WIDTH ([[UIScreen mainScreen] bounds].size.width)
#define SCREEN_HEIGHT ([[UIScreen mainScreen] bounds].size.height)

#endif /* DefineFile_h */