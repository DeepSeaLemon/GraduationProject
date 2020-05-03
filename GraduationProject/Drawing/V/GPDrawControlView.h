//
//  GPDrawControlView.h
//  GraduationProject
//
//  Created by CYM on 2020/5/1.
//  Copyright © 2020年 CYM. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol GPDrawControlViewDelegate <NSObject>

@optional
- (void)lineWideTextFieldDidEndEditing:(UITextField *)textField;
- (void)itemDidClicked:(UIButton *)sender;
- (void)colorButtonClicked:(UIButton *)sender;

@end


@interface GPDrawControlView : UIView

- (void)startUIViewAnimation;

@property (nonatomic, weak  ) id<GPDrawControlViewDelegate> delegate;
@property (nonatomic, assign) BOOL isRetract;

@end

NS_ASSUME_NONNULL_END
