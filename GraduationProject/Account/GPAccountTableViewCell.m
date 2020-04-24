//
//  GPAccountTableViewCell.m
//  GraduationProject
//
//  Created by CYM on 2020/4/23.
//  Copyright © 2020年 CYM. All rights reserved.
//

#import "GPAccountTableViewCell.h"

@interface GPAccountTableViewCell ()

@property (nonatomic, strong) UILabel* itemLabel;
@property (nonatomic, strong) UILabel *timeLabel;
@property (nonatomic, strong) UILabel *moneyLabel;

@end

@implementation GPAccountTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.contentView.backgroundColor = [UIColor whiteColor];
        [self initUI];
    }
    return self;
}

- (void)initUI {
    [self.contentView addSubview:self.itemLabel];
    [self.contentView addSubview:self.timeLabel];
    [self.contentView addSubview:self.moneyLabel];
    
    [self.itemLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(20);
        make.top.mas_equalTo(11);
        make.bottom.mas_equalTo(-38);
    }];
    
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.itemLabel.mas_bottom).offset(5);
        make.left.mas_equalTo(20);
        make.bottom.mas_equalTo(-11);
    }];
    
    [self.moneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-20);
        make.centerY.mas_equalTo(self.contentView);
    }];
}

#pragma mark - lazy

- (UILabel *)itemLabel {
    if(!_itemLabel) {
        _itemLabel = [[UILabel alloc] init];
        _itemLabel.textColor = [UIColor blackColor];
        _itemLabel.font = [UIFont systemFontOfSize: 15];
        _itemLabel.text = @"占位符1";
    }
    return _itemLabel;
}

- (UILabel *)timeLabel {
    if(!_timeLabel) {
        _timeLabel = [[UILabel alloc] init];
        _timeLabel.textColor = [UIColor colorWithHexString:@"C4C4C4"];
        _timeLabel.font = [UIFont systemFontOfSize: 15];
        _timeLabel.text = @"占位符2";
    }
    return _timeLabel;
}

- (UILabel *)moneyLabel {
    if(!_moneyLabel) {
        _moneyLabel = [[UILabel alloc] init];
        _moneyLabel.textColor = [UIColor blackColor];
        _moneyLabel.font = [UIFont systemFontOfSize: 17];
        _moneyLabel.textAlignment = NSTextAlignmentRight;
        _moneyLabel.text = @"占位符3";
    }
    return _moneyLabel;
}


@end
