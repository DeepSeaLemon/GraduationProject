//
//  GPAddNoteViewController.h
//  GraduationProject
//
//  Created by CYM on 2020/4/25.
//  Copyright © 2020年 CYM. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class GPNoteModel;
typedef void(^ReturnModelBlock)(GPNoteModel *model);

@interface GPAddNoteViewController : GPBaseViewController

@property (nonatomic, strong)ReturnModelBlock returnBlock;

@end

NS_ASSUME_NONNULL_END
