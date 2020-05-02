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
@property (nonatomic, copy  ) NSString *imageData;
@property (nonatomic, copy  ) NSString *pathsData;
@property (nonatomic, copy  ) NSString *pathsImageData;
@property (nonatomic, strong) NSNumber *imageIndex;
@property (nonatomic, strong) UIImage *image;
@property (nonatomic, strong) NSMutableArray *paths;

- (instancetype)initWithName:(NSString *)nameStr image:(UIImage *)image paths:(NSMutableArray *)paths;
- (void)restorePathsArrayWith:(NSString *)pathsStr pathsImage:(NSString *)pathsImageStr imageIndex:(NSNumber *)imageIndex;
@end

NS_ASSUME_NONNULL_END
