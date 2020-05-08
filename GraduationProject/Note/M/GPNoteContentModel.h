//
//  GPNoteContentModel.h
//  GraduationProject
//
//  Created by CYM on 2020/5/7.
//  Copyright © 2020年 CYM. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface GPNoteContentModel : NSObject

@property (nonatomic, copy) NSString *timeStr;
@property (nonatomic, copy) NSString *titleStr;
@property (nonatomic, copy) NSString *numberStr;
@property (nonatomic, copy) NSString *imageStr;
@property (nonatomic, strong) UIImage *image;
@property (nonatomic, strong) NSData *contentData;
@property (nonatomic, copy) NSString *contentNumberStr;
- (instancetype)initWithTime:(NSString *)timeStr title:(NSString *)titleStr content:(NSAttributedString *)contentStr image:(UIImage *)image;
@end

NS_ASSUME_NONNULL_END
