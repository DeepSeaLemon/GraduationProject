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
    // Do any additional setup after loading the view.
    [self initUI];
}

- (void)initUI {
    [self.view addSubview:self.drawView];
    [self.drawView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}

- (GPDrawView *)drawView{
    if (!_drawView) {
        _drawView = [[GPDrawView alloc]init];
    }
    return _drawView;
}

@end
