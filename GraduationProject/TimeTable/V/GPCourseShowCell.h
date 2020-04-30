//
//  GPCourseShowCell.h
//  GraduationProject
//
//  Created by CYM on 2020/4/26.
//  Copyright © 2020年 CYM. All rights reserved.
//

#import <UIKit/UIKit.h>

@class GPCurriculumModel;

typedef enum GPCourseShowCellType {
    GPCourseShowCellTypeShowNil = 0,
    GPCourseShowCellTypeInputNil,
    GPCourseShowCellTypeOne,
    GPCourseShowCellTypeTwo,
} GPCourseShowCellType;

@interface GPCourseShowCell : UICollectionViewCell

- (void)setDataModel:(GPCurriculumModel *)model;

@property (nonatomic,assign) GPCourseShowCellType cellType;

- (void)setCurrentDayBackGroundViewColor:(BOOL)setIt;
@end
