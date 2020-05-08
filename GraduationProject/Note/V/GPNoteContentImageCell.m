//
//  GPNoteContentImageCell.m
//  GraduationProject
//
//  Created by CYM on 2020/5/8.
//  Copyright © 2020年 CYM. All rights reserved.
//

#import "GPNoteContentImageCell.h"
#import "GPNoteContentModel.h"

@interface GPNoteContentImageCell ()

@property (nonatomic, strong)UIImageView *contentImageView;

@property (nonatomic, strong)UILabel *pageLabel;

@end

@implementation GPNoteContentImageCell

- (void)setPage:(NSInteger)index {
    self.pageLabel.text = [NSString stringWithFormat:@"第 %ld 页",(long)index];
}

- (void)setGPNoteContentModel:(GPNoteContentModel *)model {
    self.contentImageView.image = model.image;
}

- (instancetype) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.contentView.backgroundColor = [UIColor whiteColor];
        [self initUI];
    }
    return self;
}

- (void)initUI {
    [self.contentView addSubview:self.contentImageView];
    [self.contentImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.mas_equalTo(0);
    }];
    
    [self.contentView addSubview:self.pageLabel];
    [self.pageLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.bottom.mas_equalTo(-20);
        make.height.mas_equalTo(30);
    }];
}

- (UIImageView *)contentImageView {
    if (!_contentImageView) {
        _contentImageView = [[UIImageView alloc] init];
        _contentImageView.contentMode = UIViewContentModeScaleAspectFit;
        _contentImageView.backgroundColor = [UIColor whiteColor];
    }
    return _contentImageView;
}

- (UILabel *)pageLabel {
    if (!_pageLabel) {
        _pageLabel = [[UILabel alloc] init];
        _pageLabel.textColor = [UIColor blackColor];
        _pageLabel.textAlignment = NSTextAlignmentCenter;
        _pageLabel.font = [UIFont systemFontOfSize:15];
        _pageLabel.text = @"第？页";
    }
    return _pageLabel;
}
@end
