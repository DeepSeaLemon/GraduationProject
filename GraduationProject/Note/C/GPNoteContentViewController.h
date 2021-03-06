//
//  GPNoteContentViewController.h
//  GraduationProject
//
//  Created by CYM on 2020/4/26.
//  Copyright © 2020年 CYM. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class GPNoteModel;
@class GPNoteViewModel;

@interface GPNoteContentViewController : GPBaseViewController

@property (nonatomic, strong)GPNoteModel *noteModel;
@property (nonatomic, strong)GPNoteViewModel *viewModel;
@end

NS_ASSUME_NONNULL_END
