//
//  GPDrawView.m
//  GraduationProject
//
//  Created by CYM on 2020/4/19.
//  Copyright © 2020年 CYM. All rights reserved.
//

#import "GPDrawView.h"

@interface GPDrawView()

@property(nonatomic,strong) UIBezierPath* path;
// 线的数组
@property(nonatomic,strong) NSMutableArray* paths;
@property(nonatomic,strong) NSMutableArray* pathColors;
@property(nonatomic,retain) UIColor *lastPathColor;

@end

@implementation GPDrawView

- (void)setPathsForView:(NSMutableArray *)paths colors:(nonnull NSMutableArray *)colors {
    self.paths = paths;
    self.pathColors = colors;
    [self setNeedsDisplay];
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self setUp];
    }
    return self;
}

// 重绘UI
- (void)drawRect:(CGRect)rect {
    [self.paths enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isKindOfClass:[UIImage class]]) {
            UIImage* image = obj;
            [image drawInRect:CGRectMake(0, 0, image.size.width, image.size.height)];
        } else {
            // 设置画笔颜色
            UIBezierPath *path = obj;
            if (self.pathColors.count >= idx && self.pathColors[idx] != nil) {
                path.pathColor = self.pathColors[idx];
            }
            [path.pathColor set];
            [path stroke];
        }
    }];
}

// 懒加载属性
- (NSMutableArray*)paths {
    if (_paths == nil) {
        _paths = [NSMutableArray array];
    }
    return _paths;
}

- (NSMutableArray *)pathColors {
    if (!_pathColors) {
        _pathColors = [NSMutableArray array];
    }
    return _pathColors;
}

// 重写image属性
- (void)setImage:(UIImage *)image {
    CGFloat iw = image.size.width;
    CGFloat ih = image.size.height;
    CGFloat vw = self.frame.size.width;
    CGFloat vh = self.frame.size.height;
    CGFloat scaleSize = (iw > ih) ? (vw / iw) : (vh / ih);
    _image = [UIImage scaleImage:image toScale:scaleSize];
    [self.paths addObject:_image];
    [self.pathColors addObject:[UIColor whiteColor]];
    [self setNeedsDisplay];
}

#pragma mark - Init

// 初始化
- (void)setUp {
    // 添加平移手势
    UIPanGestureRecognizer* panGes = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(panGes:)];
    [self addGestureRecognizer:panGes];
    // 默认值
    self.lineWidth = 2;
    self.pathColor = [UIColor blackColor];
    self.lastPathColor = [UIColor blackColor];
}

#pragma mark - Event

// 平移事件
- (void)panGes:(UIPanGestureRecognizer*)ges {
    // 获取当前点
    CGPoint curPoint = [ges locationInView:self];
    if (ges.state == UIGestureRecognizerStateBegan) { // 开始移动
        // 创建贝塞尔曲线
        _path = [[UIBezierPath alloc]init];
        // 设置线条宽度
        _path.lineWidth = _lineWidth;
        // 线条默认颜色
        _path.pathColor = _pathColor;
        // 设置起始点
        [_path moveToPoint:curPoint];
        [self.paths addObject:_path];
        [self.pathColors addObject:_pathColor];
    }
    // 连线
    [_path addLineToPoint:curPoint];
    // 重绘
    [self setNeedsDisplay];
}

#pragma mark - Method

// 清屏
- (void)clear {
    [self.paths removeAllObjects];
    [self setNeedsDisplay];
}

// 撤销
- (void)undo {
    [self.paths removeLastObject];
    [self.pathColors removeLastObject];
    [self setNeedsDisplay];
}

// 橡皮擦
- (void)eraser {
    if (self.pathColor != [UIColor whiteColor]) {
        self.lastPathColor = self.pathColor;
    }
    self.pathColor = [UIColor whiteColor];
    [self setNeedsDisplay];
}

// 画笔
- (void)resetPen {
    self.pathColor = self.lastPathColor;
    [self setNeedsDisplay];
}

// 保存
- (void)save {
    // ---- 截图操作
    // 开启上下文
    UIGraphicsBeginImageContextWithOptions(self.frame.size, NO, 0);
    // 获取当前上下文
    CGContextRef context = UIGraphicsGetCurrentContext();
    // 渲染图层到上下文
    [self.layer renderInContext:context];
    // 从上下文中获取图片
    UIImage* image = UIGraphicsGetImageFromCurrentImageContext();
    // 关闭上下文
    UIGraphicsEndImageContext();
    // ---- 保存图片
    UIImageWriteToSavedPhotosAlbum(image, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
}

// 图片保存方法，必需写这个方法体，不能会保存不了图片
- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo{
    !self.imageSaveBlock?:self.imageSaveBlock(image,error,self.paths,self.pathColors);
}

@end
