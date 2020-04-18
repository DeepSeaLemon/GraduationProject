//
//  GPBaseViewController.m
//  GraduationProject
//
//  Created by CYM on 2020/4/18.
//  Copyright © 2020年 CYM. All rights reserved.
//

#import "GPBaseViewController.h"

@interface GPBaseViewController ()

@end

@implementation GPBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
}

- (void)setFirstClassNavWith:(NSString *)title imageName:(NSString *)imageName {
    // 标题置左，加大
    // 右边设置图标
    [self setLeftLageTitle:title];
    [self setRightImageWithName:imageName];
}

- (void)setLeftBackButton {
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 44, 30)];
    [button setTitle:@"返回" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(clickBackButton:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
}

- (void)setRightImageWithName:(NSString *)imageName {
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 25, 25)];
    [button setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    [button setTitle:@"" forState:UIControlStateNormal];
    button.imageView.contentMode = UIViewContentModeScaleAspectFit;
    [button addTarget:self action:@selector(clickRightButton:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithCustomView:button];
    rightItem.imageInsets = UIEdgeInsetsMake(0, -15,0, 0);//设置向左偏移
    self.navigationItem.rightBarButtonItem = rightItem;
}

- (void)setRightText:(NSString *)text {
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 44, 30)];
    [button setTitle:text forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
    [button addTarget:self action:@selector(clickBackButton:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
}

- (void)setLeftLageTitle:(NSString *)title {
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 44, 30)];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:18];
    [button addTarget:self action:@selector(clickBackButton:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
}

- (void)clickBackButton:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)clickRightButton:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
@end
