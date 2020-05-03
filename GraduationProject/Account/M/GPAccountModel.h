//
//  GPAccountModel.h
//  GraduationProject
//
//  Created by CYM on 2020/5/3.
//  Copyright © 2020年 CYM. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface GPAccountModel : NSObject

@property (nonatomic, strong) NSNumber *year;
@property (nonatomic, strong) NSNumber *month;
@property (nonatomic, strong) NSNumber *day;
@property (nonatomic, strong) NSNumber *amount;
@property (nonatomic, strong) NSNumber *isInput;
@property (nonatomic, copy  ) NSString *content;
@property (nonatomic, copy  ) NSString *timeStr;
@property (nonatomic, copy  ) NSString *dateStr;
@property (nonatomic, copy  ) NSString *numberStr;

- (instancetype)initWith:(NSString *)amountStr isInput:(BOOL)isInput content:(NSString *)content;

@end

NS_ASSUME_NONNULL_END
