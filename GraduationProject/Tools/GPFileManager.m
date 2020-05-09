//
//  GPFileManager.m
//  GraduationProject
//
//  Created by CYM on 2020/5/9.
//  Copyright © 2020年 CYM. All rights reserved.
//

#import "GPFileManager.h"

static GPFileManager *_singleInstance = nil;

@interface GPFileManager ()

@end

@implementation GPFileManager

#pragma mark - funcs

- (NSURL *)getCachesDirectoryPath {
    return [[[NSFileManager defaultManager] URLsForDirectory:NSCachesDirectory inDomains:NSUserDomainMask] lastObject];
}

- (NSURL *)copyFileToCaches:(NSString *)fileName {
    NSString *filePath = [self getFilePathWith:fileName];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSFileManager *manager = [NSFileManager defaultManager];
    NSString *cachesDir = [paths objectAtIndex:0];
    NSString *fileCachsPath = [cachesDir stringByAppendingPathComponent:fileName];
    NSArray *files = [manager contentsOfDirectoryAtPath:cachesDir error:nil];
    [files enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [manager removeItemAtPath:[cachesDir stringByAppendingPathComponent:obj] error:nil];
    }];
    NSError *error = nil;
    [manager copyItemAtPath:filePath toPath:fileCachsPath error:&error];
    NSURL *url = [NSURL fileURLWithPath:fileCachsPath];
    return url;
}

- (NSString *)getFilePathWith:(NSString *)fileName {
    return [self.fileFolderPath stringByAppendingPathComponent:fileName];
}

- (BOOL)deleteFileWith:(NSString *)fileName {
    NSString *filePath = [self.fileFolderPath stringByAppendingPathComponent:fileName];
    if ([[NSFileManager defaultManager] fileExistsAtPath:filePath]) {
        BOOL removed = [[NSFileManager defaultManager] removeItemAtPath:filePath error:nil];
        return removed;
    }
    return NO;
}

- (NSArray *)getFileNames {
    return [[NSFileManager defaultManager] contentsOfDirectoryAtPath:self.fileFolderPath error:nil];
}

- (BOOL)convertPDFWithImages:(NSArray<UIImage *>*)images fileName:(NSString *)fileName {
    if (!images || images.count == 0) return NO;

    NSString *file = [NSString stringWithFormat:@"%@.pdf",fileName];
    NSString *pdfPath = [self.fileFolderPath stringByAppendingPathComponent:file];
    NSArray *files = [self getFileNames];
    [files enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isEqualToString:file]) {
            [self deleteFileWith:file];
        }
    }];
    BOOL result = UIGraphicsBeginPDFContextToFile(pdfPath, CGRectZero, NULL);
    // pdf每一页的尺寸大小
    CGRect pdfBounds = UIGraphicsGetPDFContextBounds();
    CGFloat pdfWidth = pdfBounds.size.width;
    CGFloat pdfHeight = pdfBounds.size.height;
    NSLog(@"%@",NSStringFromCGRect(pdfBounds));
    [images enumerateObjectsUsingBlock:^(UIImage * _Nonnull image, NSUInteger idx, BOOL * _Nonnull stop) {
        UIGraphicsBeginPDFPage();// 绘制PDF
        // 获取每张图片的实际长宽
        CGFloat imageW = image.size.width;
        CGFloat imageH = image.size.height;
        // 如果图片宽高都小于PDF宽高,每张图片居中显示
        if (imageW <= pdfWidth && imageH <= pdfHeight) {
            CGFloat originX = (pdfWidth - imageW) * 0.5;
            CGFloat originY = (pdfHeight - imageH) * 0.5;
            [image drawInRect:CGRectMake(originX, originY, imageW, imageH)];
        } else {
            CGFloat w,h; // 先声明缩放之后的宽高 图片宽高比大于PDF
            if ((imageW / imageH) > (pdfWidth / pdfHeight)){
                w = pdfWidth - 20;
                h = w * imageH / imageW;
            } else { // 图片高宽比大于PDF
                h = pdfHeight - 20;
                w = h * imageW / imageH;
            }
            [image drawInRect:CGRectMake((pdfWidth - w) * 0.5, (pdfHeight - h) * 0.5, w, h)];
        }
    }];
    UIGraphicsEndPDFContext();
    return result;
}


- (void)createGPFilesFolder {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *documentPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *folderPath = [documentPath stringByAppendingPathComponent:@"GPFiles"];
    BOOL isDir;
    BOOL isExit = [fileManager fileExistsAtPath:folderPath isDirectory:&isDir];
    if (!isExit || !isDir) {
        [fileManager createDirectoryAtPath:folderPath withIntermediateDirectories:YES attributes:nil error:nil];
    }
    self.fileFolderPath = folderPath;
}

#pragma mark - shareInstance

+ (instancetype)shareInstance {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (_singleInstance == nil) {
            _singleInstance = [[self alloc]init];
            _singleInstance.fileFolderPath = @"";
        }
    });
    return _singleInstance;
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _singleInstance = [super allocWithZone:zone];
    });
    return _singleInstance;
}

- (id)copyWithZone:(NSZone *)zone {
    return _singleInstance;
}

- (id)mutableCopyWithZone:(NSZone *)zone {
    return _singleInstance;
}

@end
