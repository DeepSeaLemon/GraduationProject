//
//  GPTagLabel.m
//  GraduationProject
//
//  Created by CYM on 2020/4/24.
//  Copyright © 2020年 CYM. All rights reserved.
//

#import "GPTagLabel.h"

@implementation GPTagLabel

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.textAlignment = NSTextAlignmentCenter;
    }
    return self;
}

- (void)setupWithText:(NSString*)text {
    self.text = text;
    self.font = [UIFont systemFontOfSize:17];
    UIFont* font = self.font;
    CGSize size = [text sizeWithAttributes:@{NSFontAttributeName: font}];
    CGRect frame = self.frame;
    frame.size = CGSizeMake(size.width + 20, size.height + 10);
    self.frame = frame;
    self.layer.borderColor = self.textColor.CGColor;
    self.layer.borderWidth = 1.0;
}

@end
