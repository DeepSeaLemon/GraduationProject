//
//  GPTagSelecteView.m
//  GraduationProject
//
//  Created by CYM on 2020/4/24.
//  Copyright © 2020年 CYM. All rights reserved.
//

#import "GPTagSelecteView.h"
#import "GPTagLabel.h"

@interface GPTagSelecteView ()

@property (nonatomic, strong)NSMutableArray *tags;
@property (nonatomic, strong)UILabel *titleLabel;
@property (nonatomic, strong)UIButton *addTagButton;

@end

@implementation GPTagSelecteView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.bounces = NO;
        self.pagingEnabled = YES;
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

//  设置tag和手势
- (void)setupSubViewsWithTitles:(NSArray *)titles {
    [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [self.tags removeAllObjects];
    for (NSInteger i = 0; i < titles.count; i++) {
        GPTagLabel *tagLabel = [[GPTagLabel alloc] initWithFrame:CGRectZero];
        [tagLabel setupWithText:titles[i]];
        [self addSubview:tagLabel];
        [self.tags addObject:tagLabel];
        // 添加手势
        tagLabel.tag = i;
        UITapGestureRecognizer *pan = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(selectTagClick:)];
        UILongPressGestureRecognizer *longPan = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(selectTagLongPress:)];
        [tagLabel addGestureRecognizer:pan];
        [tagLabel addGestureRecognizer:longPan];
        tagLabel.userInteractionEnabled = YES;
    }
    
    [self setupAllSubViews];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self setupAllSubViews];
}

// 计算tag的排布
- (void)setupAllSubViews {
    [self addSubview:self.titleLabel];
    [self addSubview:self.addTagButton];
    CGFloat marginX = 20;
    CGFloat marginY = 20;
    __block CGFloat x = 0;
    __block CGFloat y = 45;
    [self.tags enumerateObjectsUsingBlock:^(GPTagLabel *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        CGFloat height = CGRectGetHeight(obj.frame);
        if (idx == 0) {
            x = marginX;
        }else {
            x = CGRectGetMaxX([self.tags[idx - 1] frame]) + marginX;
            if ( x + CGRectGetWidth(obj.frame) + marginX > CGRectGetWidth(self.frame) ) {
                x = marginX;
                y += height;
                y += marginY;
            }
        }
        CGRect frame = obj.frame;
        frame.origin = CGPointMake(x, y);
        obj.frame = frame;
    }];
    // 如果只有一行，居中显示
    if (y == 10) {
        [self.tags enumerateObjectsUsingBlock:^(GPTagLabel *obj, NSUInteger idx, BOOL * _Nonnull stop) {
            CGFloat height = CGRectGetHeight(obj.frame);
            y = CGRectGetHeight(self.frame) / 2 - height / 2.0;
            if (idx == 0) {
                x = marginX;
            }else {
                x = CGRectGetMaxX([self.tags[idx - 1] frame]) + marginX;
            }
            CGRect frame = obj.frame;
            frame.origin = CGPointMake(x, y);
            obj.frame = frame;
        }];
    }
    CGFloat contentHeight = CGRectGetMaxY([self.tags.lastObject frame]) + 10;
    if (contentHeight < CGRectGetHeight(self.frame)) {
        contentHeight = 0;
    }
    self.contentSize = CGSizeMake(0, contentHeight);
}

#pragma mark - UIPanGestureRecognizer

// 单击
- (void)selectTagClick:(UIPanGestureRecognizer *)pan {
    GPTagLabel *tagLabel = (GPTagLabel *)pan.view;
    if ([self.tagDelegate respondsToSelector:@selector(tagSelecteView:didSelectTagViewAtIndex:selectContent:)]) {
        [self.tagDelegate tagSelecteView:self didSelectTagViewAtIndex:tagLabel.tag selectContent:tagLabel.text];
    }
}

// 长按
- (void)selectTagLongPress:(UIPanGestureRecognizer *)pan {
    GPTagLabel *tagLabel = (GPTagLabel *)pan.view;
    if ([self.tagDelegate respondsToSelector:@selector(tagSelecteView:longPressSelectTagViewAtIndex:selectContent:)]) {
        [self.tagDelegate tagSelecteView:self longPressSelectTagViewAtIndex:tagLabel.tag selectContent:tagLabel.text];
    }
}

- (void)addTagButtonClicked:(UIButton *)sender {
    if ([self.tagDelegate respondsToSelector:@selector(addTagButtonClicked)]) {
        [self.tagDelegate addTagButtonClicked];
    }
}

#pragma mark - lazy
- (NSMutableArray *)tags {
    if (_tags == nil) {
        _tags = [NSMutableArray array];
    }
    return _tags;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 10, 80, 25)];
        _titleLabel.text = @"快速选择";
        _titleLabel.font = [UIFont systemFontOfSize:17];
        _titleLabel.textColor = [UIColor blackColor];
    }
    return _titleLabel;
}

- (UIButton *)addTagButton {
    if (!_addTagButton) {
        _addTagButton = [[UIButton alloc] initWithFrame:CGRectMake(100, 10, 25, 25)];
        [_addTagButton setImage:[UIImage imageNamed:@"add2"] forState:UIControlStateNormal];
        [_addTagButton addTarget:self action:@selector(addTagButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _addTagButton;
}
@end
