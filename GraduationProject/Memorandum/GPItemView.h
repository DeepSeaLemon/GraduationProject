//
//  GPItemView.h
//  GraduationProject
//
//  Created by CYM on 2020/4/24.
//  Copyright © 2020年 CYM. All rights reserved.
//

#import <UIKit/UIKit.h>

@class GPItemView;

@protocol GPItemViewDelegate <NSObject>

@optional

- (void)itemSwitchChanged:(BOOL)isOn itemView:(GPItemView *)itemView;
- (void)itemViewClicked;

@end

@interface GPItemView : UIView

@property (nonatomic, assign) BOOL isSwitch;

@property (nonatomic, weak) id<GPItemViewDelegate> delegate;

- (void)setItemSwitchStatus:(BOOL)isOn;

- (void)setItemViewTitle:(NSString *)str;
@end
