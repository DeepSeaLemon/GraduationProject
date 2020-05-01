//
//  GPCollectionViewCell.m
//  CollectionTest
//
//  Created by CYM on 2020/4/20.
//  Copyright © 2020年 CYM. All rights reserved.
//

#import "GPCollectionViewCell.h"

@interface GPCollectionViewCell()

@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UIView *backView;
@property (nonatomic, strong) UIImageView *photoView;

@end

@implementation GPCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.contentView.backgroundColor = [UIColor colorWithHexString:@"F5F5F5"];
        [self setUI];
    }
    return self;
}

- (void)setUI {
    
    
    [self.contentView addSubview:self.backView];
    [self.backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.left.mas_equalTo(5);
        make.right.mas_equalTo(-5);
        make.bottom.mas_equalTo(-30);
    }];
    
    [self.contentView addSubview:self.nameLabel];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(0);
        make.top.equalTo(self.backView.mas_bottom).offset(5);
    }];
    
    [self.contentView addSubview:self.photoView];
    [self.photoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(5);
        make.left.mas_equalTo(10);
        make.right.mas_equalTo(-10);
        make.bottom.mas_equalTo(-35);
    }];
}

- (UIImageView *)photoView {
    if (!_photoView) {
        _photoView = [[UIImageView alloc] init];
        _photoView.image = [UIImage imageNamed:@"cell_background"];
        _photoView.contentMode = UIViewContentModeScaleToFill;
        _photoView.backgroundColor = [UIColor redColor];
    }
    return _photoView;
}

- (UIView *)backView {
    if (!_backView) {
        _backView = [[UIView alloc] init];
        _backView.backgroundColor = [UIColor whiteColor];
        //设置阴影颜色
        _backView.layer.shadowColor = [UIColor blackColor].CGColor;
        //设置阴影的透明度
        _backView.layer.shadowOpacity = 0.5f;
        //设置阴影的偏移
        _backView.layer.shadowOffset = CGSizeMake(1, 1);
        //设置阴影半径
        _backView.layer.shadowRadius = 2.0f;
        //设置渲染内容被缓存
        _backView.layer.shouldRasterize = YES;
        //超出父视图部分是否显示
        _backView.layer.masksToBounds = NO;
    }
    return _backView;
}

- (UILabel *)nameLabel {
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc] init];
        _nameLabel.font = [UIFont systemFontOfSize:15];
        _nameLabel.textColor = [UIColor blackColor];
        _nameLabel.textAlignment = NSTextAlignmentCenter;
        _nameLabel.text = @"新画板";
        _nameLabel.backgroundColor = self.contentView.backgroundColor;
    }
    return _nameLabel;
}
@end
