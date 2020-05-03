//
//  GPTagSelecteView.h
//  GraduationProject
//
//  Created by CYM on 2020/4/24.
//  Copyright © 2020年 CYM. All rights reserved.
//

#import <UIKit/UIKit.h>

@class GPTagSelecteView;

@protocol GPTagSelecteViewDelegate <NSObject>

- (void)tagSelecteView:(GPTagSelecteView *)tagSelecteView didSelectTagViewAtIndex:(NSInteger)index selectContent:(NSString *)content;
- (void)tagSelecteView:(GPTagSelecteView *)tagSelecteView longPressSelectTagViewAtIndex:(NSInteger)index selectContent:(NSString *)content;
- (void)addTagButtonClicked;
@end

@interface GPTagSelecteView : UIScrollView

@property (nonatomic, weak) id<GPTagSelecteViewDelegate> tagDelegate;

- (void)setupSubViewsWithTitles:(NSArray *)titles;

- (void)refreshWithTitles:(NSArray *)titles;

@end

