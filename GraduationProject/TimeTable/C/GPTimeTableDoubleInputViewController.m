//
//  GPTimeTableDoubleInputViewController.m
//  GraduationProject
//
//  Created by CYM on 2020/4/26.
//  Copyright © 2020年 CYM. All rights reserved.
//

#import "GPTimeTableDoubleInputViewController.h"
#import "GPCourseInputViewController.h"
#import "GPCourseShowCell.h"

static NSString *GPTimeTableDoubleInputViewControllerCellID = @"GPTimeTableDoubleInputViewController";

@interface GPTimeTableDoubleInputViewController ()

@end

@implementation GPTimeTableDoubleInputViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setLeftBackButton];
    [self setRightText:@"完成"];
    [self setTitle:@"双周课程表录入"];
    [self.collectionView registerClass:[GPCourseShowCell class] forCellWithReuseIdentifier:GPTimeTableDoubleInputViewControllerCellID];
}

- (void)clickRightButton:(UIButton *)sender {
    
}

#pragma make - delegate & datesource

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 7;
}
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 4;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    GPCourseInputViewController *vc = [[GPCourseInputViewController alloc] init];
    vc.week = indexPath.row;
    vc.section = indexPath.section;
    vc.isDouble = YES;
    vc.isSingle = NO;
    [self.navigationController pushViewController:vc animated:YES];
    NSLog(@"%ld - %ld",indexPath.section,indexPath.row);
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    GPCourseShowCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:GPTimeTableDoubleInputViewControllerCellID forIndexPath:indexPath];
    if (cell == nil) {
        cell = [[GPCourseShowCell alloc] init];
    }
    return cell;
}
@end
