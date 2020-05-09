//
//  GPFileManager.h
//  GraduationProject
//
//  Created by CYM on 2020/5/9.
//  Copyright © 2020年 CYM. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN

@interface GPFileManager : NSObject

+ (instancetype)shareInstance;
- (void)createGPFilesFolder;
- (NSArray *)getFileNames;
- (NSString *)getFilePathWith:(NSString *)fileName;
- (BOOL)deleteFileWith:(NSString *)fileName;
- (BOOL)convertPDFWithImages:(NSArray<UIImage *>*)images fileName:(NSString *)fileName;
- (NSURL *)copyFileToCaches:(NSString *)fileName;
@property (nonatomic, copy)NSString *fileFolderPath;
@end

NS_ASSUME_NONNULL_END
