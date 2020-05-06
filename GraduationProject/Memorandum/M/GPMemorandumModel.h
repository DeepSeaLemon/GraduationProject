//
//  GPMemorandumModel.h
//  GraduationProject
//
//  Created by CYM on 2020/5/5.
//  Copyright © 2020年 CYM. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface GPMemorandumModel : NSObject

@property (nonatomic, strong) NSNumber *isCountDown;
@property (nonatomic, strong) NSNumber *isRemind;
@property (nonatomic, strong) NSNumber *isEveryday;
@property (nonatomic, copy  ) NSString *content;
@property (nonatomic, copy  ) NSString *startTime;
@property (nonatomic, copy  ) NSString *endTime;
@property (nonatomic, copy  ) NSString *numberStr;
@property (nonatomic, copy  ) NSString *remindTime;

- (instancetype)initWith:(NSString *)content startTime:(NSString *)startTime endTime:(NSString *)endTime isCountDown:(BOOL)isCountDown isRemind:(BOOL)isRemind isEveryday:(BOOL)isEveryday timeAhead:(NSInteger)timeAhead;
@end

NS_ASSUME_NONNULL_END
