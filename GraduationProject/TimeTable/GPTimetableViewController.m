//
//  GPTimetableViewController.m
//  GraduationProject
//
//  Created by CYM on 2020/4/18.
//  Copyright © 2020年 CYM. All rights reserved.
//

#import "GPTimetableViewController.h"

@interface GPTimetableViewController ()

@end

@implementation GPTimetableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setFirstClassNavWith:@"课程表" imageName:@"setting.png"];
    NSLog(@"%@",self.navigationController.class);
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
