//
//  GPBaseViewController.h
//  GraduationProject
//
//  Created by CYM on 2020/4/18.
//  Copyright © 2020年 CYM. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface GPBaseViewController : UIViewController
- (void)setFirstClassNavWith:(NSString *)title imageName:(NSString *)imageName;
- (void)setLeftBackButton;
- (void)setRightImageWithName:(NSString *)imageName;
- (void)setRightText:(NSString *)text;
- (void)setLeftLageTitle:(NSString *)title;
@end

NS_ASSUME_NONNULL_END
