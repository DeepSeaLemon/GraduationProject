//
//  GPNoteModel.h
//  GraduationProject
//
//  Created by CYM on 2020/5/7.
//  Copyright © 2020年 CYM. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class GPNoteContentModel;

@interface GPNoteModel : NSObject

@property (nonatomic, copy) NSString *coverImageStr;
@property (nonatomic, strong) UIImage *coverImage;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *numberStr;

- (instancetype)initWith:(NSString *)name image:(UIImage *)image;

@end

NS_ASSUME_NONNULL_END
