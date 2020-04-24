//
//  GPMemorandumViewController.m
//  GraduationProject
//
//  Created by CYM on 2020/4/18.
//  Copyright © 2020年 CYM. All rights reserved.
//

#import "GPMemorandumViewController.h"
#import "GPAddPlanViewController.h"

@interface GPMemorandumViewController ()

@end

@implementation GPMemorandumViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setFirstClassNavWith:@"计划表" imageName:@"add"];
}

- (void)clickRightButton:(UIButton *)sender {
    GPAddPlanViewController *vc = [[GPAddPlanViewController alloc] init];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}
@end
