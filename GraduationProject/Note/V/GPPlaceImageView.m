//
//  GPPlaceImageView.m
//  GraduationProject
//
//  Created by CYM on 2020/5/7.
//  Copyright © 2020年 CYM. All rights reserved.
//

#import "GPPlaceImageView.h"

#define MaxSCale 2.0  //最大缩放比例
#define MinScale 0.1  //最小缩放比例
//  设备宽高
#define kScreenWidth        [UIScreen mainScreen].bounds.size.width
#define kScreenHeight       [UIScreen mainScreen].bounds.size.height

@interface GPPlaceImageView ()

@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UIButton *closeButton;
@property (nonatomic, strong) UIButton *confirmButton;
@property (nonatomic, assign ,readwrite) BOOL canTransform;
@property (nonatomic, assign ,readwrite) CGFloat totalScale;
@property (nonatomic, strong) UIPinchGestureRecognizer *pinchGestureRecognizer;

@end

@implementation GPPlaceImageView

- (instancetype)initWithImage:(UIImage *)image {
    if (self = [super init]) {
        self.totalScale = 1.0;
        self.canTransform = YES;
        self.backgroundColor = [UIColor clearColor];
        CGFloat iw = image.size.width;
        CGFloat ih = image.size.height;
        CGFloat vw = kScreenWidth;
        CGFloat vh = kScreenHeight;
        CGFloat scaleSize = (iw > ih) ? (vw / iw) : (vh / ih);
        self.placeImage = [UIImage scaleImage:image toScale:scaleSize];
        self.frame = CGRectMake(0, 0, self.placeImage.size.width-50, self.placeImage.size.height-50);
        self.center = CGPointMake(kScreenWidth/2, kScreenHeight/2);
        self.placeImage = image;
        [self initUI];
        [self addGestureRecognizer:self.pinchGestureRecognizer];
    }
    return self;
}

#pragma mark - funcs

- (void)close:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(placeImageViewClickClose:)]) {
        [self.delegate placeImageViewClickClose:YES];
    }
    self.canTransform = NO;
    [self removeFromSuperview];
}

- (void)confirm:(UIButton *)sender {
    self.confirmButton.hidden = YES;
    self.closeButton.hidden = YES;
    self.canTransform = NO;
    self.imageView.layer.borderWidth = 0;
    if ([self.delegate respondsToSelector:@selector(placeImageViewClickClose:)]) {
        [self.delegate placeImageViewClickClose:NO];
    }
}

#pragma mark - gestureRecognizer & touch
// 处理缩放手势
- (void)pinchView:(UIPinchGestureRecognizer *)pinchGestureRecognizer {
    if (self.canTransform) {
        UIView *view = pinchGestureRecognizer.view;
        CGFloat scale = pinchGestureRecognizer.scale;
        //放大情况
        if(scale > 1.0){
            if(self.totalScale > MaxSCale) return;
        }
        //缩小情况
        if (scale < 1.0) {
            if (self.totalScale < MinScale) return;
        }
        if (pinchGestureRecognizer.state == UIGestureRecognizerStateBegan || pinchGestureRecognizer.state == UIGestureRecognizerStateChanged) {
            view.transform = CGAffineTransformScale(view.transform, pinchGestureRecognizer.scale, pinchGestureRecognizer.scale);
            pinchGestureRecognizer.scale = 1;
            self.totalScale *=scale;
        }
    }
}
// 处理移动
- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    if (self.canTransform) {
        UITouch *touch = [touches anyObject];
        //当前的point
        CGPoint currentP = [touch locationInView:self.superview];
        //以前的point
        CGPoint preP = [touch previousLocationInView:self.superview];
        //x轴偏移的量
        CGFloat offsetX = currentP.x - preP.x;
        //Y轴偏移的量
        CGFloat offsetY = currentP.y - preP.y;
        self.transform = CGAffineTransformTranslate(self.transform, offsetX, offsetY);
    }
}

- (void)initUI {
    [self addSubview:self.closeButton];
    [self.closeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.mas_equalTo(0);
        make.width.height.mas_equalTo(25);
    }];
    [self addSubview:self.confirmButton];
    [self.confirmButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.top.mas_equalTo(0);
        make.width.height.mas_equalTo(25);
    }];
    
    [self addSubview:self.imageView];
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.mas_equalTo(25);
        make.right.bottom.mas_equalTo(-25);
    }];
}

#pragma mark - lazy

- (UIImageView *)imageView {
    if (!_imageView) {
        _imageView = [[UIImageView alloc] init];
        _imageView.contentMode = UIViewContentModeScaleAspectFit;
        _imageView.backgroundColor = [UIColor clearColor];
        _imageView.layer.borderWidth = 1.0;
        _imageView.layer.borderColor = [UIColor grayColor].CGColor;
    }
    return _imageView;
}

- (UIButton *)closeButton {
    if (!_closeButton) {
        _closeButton = [[UIButton alloc] init];
        _closeButton.backgroundColor = [UIColor redColor];
        [_closeButton addTarget:self action:@selector(close:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _closeButton;
}

- (UIButton *)confirmButton {
    if (!_confirmButton) {
        _confirmButton = [[UIButton alloc] init];
        _confirmButton.backgroundColor = [UIColor greenColor];
        [_confirmButton addTarget:self action:@selector(confirm:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _confirmButton;
}

- (UIPinchGestureRecognizer *)pinchGestureRecognizer {
    if (!_pinchGestureRecognizer) {
        _pinchGestureRecognizer = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(pinchView:)];
    }
    return _pinchGestureRecognizer;
}

- (void)dealloc {
    NSLog(@"GPPlaceImageView dealloc");
}

@end
