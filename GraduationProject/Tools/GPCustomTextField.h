//
//  GPCustomTextField.h
//  GraduationProject
//
//  Created by CYM on 2020/5/5.
//  Copyright © 2020年 CYM. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface GPCustomTextField : UIView

@property (nonatomic, copy) NSString *text;

- (instancetype)initWithPlaceholder:(NSString *)placeholder;

@end

NS_ASSUME_NONNULL_END
