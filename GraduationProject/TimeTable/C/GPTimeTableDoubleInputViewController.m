//
//  GPTimeTableDoubleInputViewController.m
//  GraduationProject
//
//  Created by CYM on 2020/4/26.
//  Copyright © 2020年 CYM. All rights reserved.
//

#import "GPTimeTableDoubleInputViewController.h"
#import "GPCourseInputViewController.h"

@interface GPTimeTableDoubleInputViewController ()

@end

@implementation GPTimeTableDoubleInputViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setLeftBackButton];
    [self setRightText:@"完成"];
    [self setTitle:@"双周课程表录入"];
}

- (void)clickRightButton:(UIButton *)sender {
    GPCourseInputViewController *vc = [[GPCourseInputViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

@end
