//
//  GPTimetableViewController.m
//  GraduationProject
//
//  Created by CYM on 2020/4/18.
//  Copyright © 2020年 CYM. All rights reserved.
//

#import "GPTimetableViewController.h"
#import "GPTimeTableInputViewController.h"

@interface GPTimetableViewController ()

@end

@implementation GPTimetableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setFirstClassNavWith:@"课程表" imageName:@"setting.png"];
}

- (void)clickRightButton:(UIButton *)sender {
    GPTimeTableInputViewController *vc = [[GPTimeTableInputViewController alloc] init];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}
@end
