//
//  GPDrawViewController.m
//  GraduationProject
//
//  Created by CYM on 2020/4/21.
//  Copyright © 2020年 CYM. All rights reserved.
//

#import "GPDrawViewController.h"
#import "GPDrawView.h"
@interface GPDrawViewController ()
@property (nonatomic, strong) GPDrawView *drawView;
@end

@implementation GPDrawViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setLeftBackButton];
    self.title = @"新画板";
    [self initUI];
}

- (void)initUI {
    [self.view addSubview:self.drawView];
    [self.drawView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(0);
        make.top.mas_equalTo(65);
    }];
}

- (GPDrawView *)drawView{
    if (!_drawView) {
        _drawView = [[GPDrawView alloc]init];
    }
    return _drawView;
}

@end
