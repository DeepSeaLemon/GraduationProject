//
//  UIBezierPath+GP.m
//  GraduationProject
//
//  Created by CYM on 2020/5/8.
//  Copyright © 2020年 CYM. All rights reserved.
//

#import "UIBezierPath+GP.h"
#import <objc/runtime.h>

@implementation UIBezierPath (GP)
static char *NSObject_key_pathColor = "PathColorKey";

@dynamic pathColor;

- (UIColor *)pathColor {
    UIColor *object = objc_getAssociatedObject(self,NSObject_key_pathColor);
    return object;
}
- (void)setPathColor:(UIColor *)pathColor {
    [self willChangeValueForKey:@"pathColor"];
    objc_setAssociatedObject(self, NSObject_key_pathColor, pathColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self didChangeValueForKey:@"pathColor"];
}

@end
