//
//  GPItemView.m
//  GraduationProject
//
//  Created by CYM on 2020/4/24.
//  Copyright © 2020年 CYM. All rights reserved.
//

#import "GPItemView.h"

@interface GPItemView ()

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UISwitch *itemSwitch;
@property (nonatomic, strong) UIImageView *imageView;

@end

@implementation GPItemView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:CGRectMake(frame.origin.x, frame.origin.y, SCREEN_WIDTH, 50)]) {
        self.backgroundColor = [UIColor whiteColor];
        [self initUI];
    }
    return self;
}

- (void)initUI {
    [self addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(20);
        make.centerY.equalTo(self);
    }];
    
    [self addSubview:self.itemSwitch];
    [self.itemSwitch mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-20);
        make.centerY.equalTo(self);
        make.width.mas_equalTo(45);
        make.height.mas_equalTo(25);
    }];
    
    [self addSubview:self.imageView];
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-20);
        make.width.height.mas_equalTo(20);
        make.centerY.equalTo(self);
    }];
}

- (void)setIsSwitch:(BOOL)isSwitch {
    _isSwitch = isSwitch;
    self.imageView.hidden = isSwitch;
    self.itemSwitch.hidden = !isSwitch;
    if (!isSwitch) {
        [self addTapGestureRecognizer];
    }
}

- (void)setItemSwitchStatus:(BOOL)isOn {
    if (self.isSwitch) {
        self.itemSwitch.on = isOn;
    }
}

- (void)addTapGestureRecognizer {
    UITapGestureRecognizer *pan = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickSelf:)];
    [self addGestureRecognizer:pan];
}

- (void)clickSelf:(UITapGestureRecognizer *)pan {
    if (self.delegate && [self.delegate respondsToSelector:@selector(itemViewClicked)]) {
        [self.delegate itemViewClicked];
    }
}

- (void)changeItemSwitch:(UISwitch *)item {
    if (self.delegate && [self.delegate respondsToSelector:@selector(itemSwitchChanged:itemView:)]) {
        [self.delegate itemSwitchChanged:item.isOn itemView:self];
    }
}

#pragma mark - lazy
- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = [UIFont systemFontOfSize:15];
        _titleLabel.textColor = [UIColor blackColor];
        _titleLabel.text = @"占位符";
    }
    return _titleLabel;
}

- (UISwitch *)itemSwitch {
    if (!_itemSwitch) {
        _itemSwitch = [[UISwitch alloc] init];
        _itemSwitch.on = NO;
        _itemSwitch.hidden = YES;
        [_itemSwitch setOnTintColor:GPBlueColor];
        [_itemSwitch addTarget:self action:@selector(changeItemSwitch:) forControlEvents:UIControlEventValueChanged];
    }
    return _itemSwitch;
}

- (UIImageView *)imageView {
    if (!_imageView) {
        _imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"arrow_right"]];
        _imageView.hidden = YES;
    }
    return _imageView;
}

@end
