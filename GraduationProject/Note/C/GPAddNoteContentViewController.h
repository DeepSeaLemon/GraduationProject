//
//  GPAddNoteContentViewController.h
//  GraduationProject
//
//  Created by CYM on 2020/5/7.
//  Copyright © 2020年 CYM. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class GPNoteContentModel;

typedef void(^ReturnModelBlock)(GPNoteContentModel *model);

@interface GPAddNoteContentViewController : GPBaseViewController

@property (nonatomic, copy)NSString *numberStr;

@property (nonatomic, copy)ReturnModelBlock returnBlock;

@property (nonatomic, strong)GPNoteContentModel *contentModel;

@end

NS_ASSUME_NONNULL_END
