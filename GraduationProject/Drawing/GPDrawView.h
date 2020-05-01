//
//  GPDrawView.h
//  GraduationProject
//
//  Created by CYM on 2020/4/19.
//  Copyright © 2020年 CYM. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface GPDrawView : UIView

// 画线的宽度
@property(nonatomic,assign)CGFloat lineWidth;

// 线条颜色
@property(nonatomic,retain)UIColor* pathColor;

// 加载背景图片
@property(nonatomic,strong)UIImage* image;

// 清屏
- (void)clear;

// 撤销
- (void)undo;

// 橡皮擦
- (void)eraser;

// 保存
- (void)save;

// 画笔
- (void)resetPen;

@end

NS_ASSUME_NONNULL_END
