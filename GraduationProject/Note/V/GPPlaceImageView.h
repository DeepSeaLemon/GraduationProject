//
//  GPPlaceImageView.h
//  GraduationProject
//
//  Created by CYM on 2020/5/7.
//  Copyright © 2020年 CYM. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol GPPlaceImageViewDelegate <NSObject>

- (void)placeImageViewClickClose:(BOOL)isClick;

@end

@interface GPPlaceImageView : UIView
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, assign ,readonly) BOOL canTransform;
@property (nonatomic, assign ,readonly) CGFloat totalScale;
@property (nonatomic, strong)           UIImage *placeImage;
@property (nonatomic, weak) id <GPPlaceImageViewDelegate> delegate;
- (instancetype)initWithImage:(UIImage *)image;
@end

NS_ASSUME_NONNULL_END
