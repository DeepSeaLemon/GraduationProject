//
//  GPCourseInputCell.h
//  GraduationProject
//
//  Created by CYM on 2020/4/26.
//  Copyright © 2020年 CYM. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface GPCourseInputCell : UITableViewCell

- (void)setTitle:(NSString *)title placeholder:(NSString *)placeholder;

- (NSString *)getContentText;

@property (nonatomic, assign) BOOL isClass;

@end

NS_ASSUME_NONNULL_END