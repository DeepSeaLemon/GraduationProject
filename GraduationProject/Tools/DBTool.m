//
//  DBTool.m
//  GraduationProject
//
//  Created by CYM on 2020/4/28.
//  Copyright © 2020年 CYM. All rights reserved.
//

#import "DBTool.h"
#import <FMDB/FMDB.h>

static DBTool *_singleInstance = nil;

@interface DBTool ()

@end

@implementation DBTool

#pragma mark - funcs

- (void)getDocumentPath {
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSLog(@"path = %@",path);
    NSString *filePath = [path stringByAppendingPathComponent:@"YourBasedateName.sqlite"];
    NSLog(@"filePath = %@",filePath);
}

- (void)createAppAllDBs {
    [self createTimeTableDB];
    [self createMemorandumDB];
    [self createNoteDB];
    [self createDrawingDB];
    [self createAccountDB];
}

- (void)createTimeTableDB {
    NSString *folderPath = [self createFolderDBWithName:@"TimeTable"];
    NSString *dbPath = [folderPath stringByAppendingPathComponent:@"TimeTable.sqlite"];
    FMDatabase *db = [FMDatabase databaseWithPath:dbPath];
    if ([db open]) {
        NSLog(@"打开数据库成功");
    }else{
        NSLog(@"打开数据库失败");
    }
}

- (void)createMemorandumDB {
    NSString *folderPath = [self createFolderDBWithName:@"Memorandum"];
}

- (void)createNoteDB {
    NSString *folderPath = [self createFolderDBWithName:@"Note"];
}

- (void)createDrawingDB {
    NSString *folderPath = [self createFolderDBWithName:@"Drawing"];
}

- (void)createAccountDB {
    NSString *folderPath = [self createFolderDBWithName:@"Account"];
}

- (NSString *)createFolderDBWithName:(NSString *)folderName {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *documentPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *folderPath = [documentPath stringByAppendingPathComponent:folderName];
    BOOL isDir;
    BOOL isExit = [fileManager fileExistsAtPath:folderPath isDirectory:&isDir];
    if (!isExit || !isDir) {
        [fileManager createDirectoryAtPath:folderPath withIntermediateDirectories:YES attributes:nil error:nil];
    }
    return folderPath;
}


#pragma mark - shareInstance

+ (instancetype)shareInstance
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (_singleInstance == nil) {
            _singleInstance = [[self alloc]init];
        }
    });
    return _singleInstance;
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _singleInstance = [super allocWithZone:zone];
    });
    return _singleInstance;
}

- (id)copyWithZone:(NSZone *)zone
{
    return _singleInstance;
}

- (id)mutableCopyWithZone:(NSZone *)zone {
    return _singleInstance;
}

@end
