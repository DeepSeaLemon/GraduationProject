//
//  GPTabBarViewController.m
//  GraduationProject
//
//  Created by CYM on 2020/4/18.
//  Copyright © 2020年 CYM. All rights reserved.
//  自定义TabbarController

#import "GPTabBarViewController.h"

@interface GPTabBarViewController ()<UITabBarControllerDelegate>

@end

@implementation GPTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self tabBarControllerAddChildViewController];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
}

#pragma mark - 添加子视图数据
- (void)tabBarControllerAddChildViewController {
    NSArray *classControllers = @[@"GPTimetableViewController", @"GPMemorandumViewController", @"GPNoteViewController", @"GPDrawingViewController", @"GPAccountViewController"];
    NSArray *titles = @[@"课程表", @"计划表", @"笔记本", @"画板", @"账本"];
    NSArray *normalImages = @[@"timetable_normal", @"memorandum_normal", @"note_nornal", @"account_normal", @"drawing_normal"];
    NSArray *selectedImages = @[@"timetable_selected", @"memorandum_selected", @"note_selected", @"account_selected", @"drawing_selected"];
    NSArray *rightImages = @[@"setting", @"add", @"file", @"", @"add2"];
    [self tabbarControllerAddSubViewControllers:classControllers titleArray:titles normalImagesArray:normalImages selectedImageArray:selectedImages rightImageArray:rightImages];
}

- (void)tabbarControllerAddSubViewControllers:(NSArray *)classControllersArray titleArray:(NSArray *)titleArray normalImagesArray:(NSArray *)normalImagesArray selectedImageArray:(NSArray *)selectedImageArray rightImageArray:(NSArray *)rightImages {
    NSMutableArray *conArr = [NSMutableArray array];
    for (int i = 0; i < classControllersArray.count; i++) {
        Class cts = NSClassFromString(classControllersArray[i]);
        GPBaseViewController *vc = [[cts alloc] init];
        [vc setFirstClassNavWith:titleArray[i] imageName:rightImages[i]];
        UINavigationController *naVC = [[UINavigationController alloc] initWithRootViewController:vc];
        [conArr addObject:naVC];
        UIImage *normalImage = [[UIImage imageNamed:normalImagesArray[i]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        UIImage *selectImage = [[UIImage imageNamed:selectedImageArray[i]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        vc.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"" image:normalImage selectedImage:selectImage];
        vc.tabBarItem.tag = i;
        vc.tabBarItem.imageInsets = UIEdgeInsetsMake(5, 0, -5, 0);
    }
    self.viewControllers = conArr;
    self.tabBar.tintColor = [UIColor colorWithRed:255.0/255 green:204.0/255 blue:13.0/255 alpha:1];
    self.tabBar.translucent = NO;
    self.delegate = self;
}

# pragma mark - UITabBarControllerDelegate
/**
 点击TabBar的时候调用
 */
- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item {
    [self animationWithIndex:item.tag];
}
/**
 动画效果
 */
- (void)animationWithIndex:(NSInteger) index {
    // 得到当前tabbar的下标
    NSMutableArray * tabbarbuttonArray = [NSMutableArray array];
    for (UIView *tabBarButton in self.tabBar.subviews) {
        if ([tabBarButton isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
            [tabbarbuttonArray addObject:tabBarButton];
        }
    }
     // 对当前下标的tabbar使用帧动画，可以根据UI的具体要求进行动画渲染
    CABasicAnimation*pulse = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    pulse.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    pulse.duration = 0.2;
    pulse.repeatCount = 1;
    pulse.autoreverses = YES;
    pulse.fromValue = [NSNumber numberWithFloat:0.7];
    pulse.toValue = [NSNumber numberWithFloat:1.3];
    [[tabbarbuttonArray[index] layer] addAnimation:pulse forKey:nil];
}
@end
