//
//  GPTimeTableBaseViewController.h
//  GraduationProject
//
//  Created by CYM on 2020/4/26.
//  Copyright © 2020年 CYM. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GPTimeTableListHeaderView.h"
#import "GPCurriculumViewModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface GPTimeTableBaseViewController : GPBaseViewController

@property (nonatomic, strong) GPTimeTableListHeaderView *listHeaderView;
@property (nonatomic, strong) UICollectionViewFlowLayout *collectionLayout;
@property (nonatomic, strong) UICollectionView *collectionView;

@property (nonatomic, strong) GPCurriculumViewModel *viewModel;
@end

NS_ASSUME_NONNULL_END
