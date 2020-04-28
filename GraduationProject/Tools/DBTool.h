//
//  DBTool.h
//  GraduationProject
//
//  Created by CYM on 2020/4/28.
//  Copyright © 2020年 CYM. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface DBTool : NSObject

+ (instancetype)shareInstance;

- (void)createAppAllDBs;
@end

NS_ASSUME_NONNULL_END
