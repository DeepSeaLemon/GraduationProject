//
//  GPDrawModel.h
//  GraduationProject
//
//  Created by CYM on 2020/5/2.
//  Copyright © 2020年 CYM. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface GPDrawModel : NSObject

@property (nonatomic, copy  ) NSString *name;
@property (nonatomic, copy  ) NSString *numberStr;
@property (nonatomic, strong) UIImage *image;
@property (nonatomic, copy  ) NSString *imageData;
@property (nonatomic, strong) NSData *pathsData;
@property (nonatomic, strong) NSMutableArray *paths;
@property (nonatomic, strong) NSData *colorsData;
@property (nonatomic, strong) NSMutableArray *colors;

- (instancetype)initWithName:(NSString *)nameStr image:(UIImage *)image paths:(NSMutableArray *)paths colors:(NSMutableArray *)colors;

@end

NS_ASSUME_NONNULL_END
