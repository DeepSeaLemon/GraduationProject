//
//  DBTool.m
//  GraduationProject
//
//  Created by CYM on 2020/4/28.
//  Copyright © 2020年 CYM. All rights reserved.
//

#import "DBTool.h"
#import <FMDB/FMDB.h>
#import "GPCurriculumModel.h"

static DBTool *_singleInstance = nil;

@interface DBTool ()

@property (nonatomic, strong) FMDatabase *timeTableDB;

@end

@implementation DBTool

#pragma mark - save
- (void)getCurriculums:(void(^)(NSArray *singleArray))singleDate double:(void(^)(NSArray *doubleArray))doubleDate{
    NSMutableArray <GPCurriculumModel *>*singleArr = [NSMutableArray array];
    NSMutableArray <GPCurriculumModel *>*doubleArr = [NSMutableArray array];
    if ([self.timeTableDB open]) {
        NSString *sql = @"select * FROM time_table_list";
        FMResultSet *rs = [self.timeTableDB executeQuery:sql];
        if (rs.columnCount > 0) {
            while ([rs next]) {
                GPCurriculumModel *model = [[GPCurriculumModel alloc] init];
                model.week        = [rs intForColumn:@"week"];
                model.section     = [rs intForColumn:@"section"];
                model.curriculum  = [rs stringForColumn:@"curriculum"];
                model.classroom   = [rs stringForColumn:@"classroom"];
                model.teacher     = [rs stringForColumn:@"teacher"];
                model.curriculum2 = [rs stringForColumn:@"curriculum2"];
                model.classroom2  = [rs stringForColumn:@"classroom2"];
                model.teacher2    = [rs stringForColumn:@"teacher2"];
                model.isSingle    = [rs boolForColumn:@"isSingle"];
                model.isDouble    = [rs boolForColumn:@"isDouble"];
                model.numberStr   = [rs stringForColumn:@"numberStr"];
                if (model.isDouble) {
                    [doubleArr addObject:model];
                } else {
                    [singleArr addObject:model];
                }
            }
            !singleDate?:singleDate(singleArr);
            !doubleDate?:doubleDate(doubleArr);
        } else {
            !singleDate?:singleDate(singleArr);
            !doubleDate?:doubleDate(doubleArr);
        }
    } else {
        !singleDate?:singleDate(singleArr);
        !doubleDate?:doubleDate(doubleArr);
    }
    [self.timeTableDB close];
}

- (void)saveCurriculumWith:(GPCurriculumModel *)model {
    if ([self.timeTableDB open]) {
        // 查询是否存在这一条数据
        NSString *sql = @"select * FROM time_table_list where numberStr = ?";
        FMResultSet *rs = [self.timeTableDB executeQuery:sql,model.numberStr];
        if (rs.next) {
            // 存在，走修改
            NSString *update = @"update time_table_list set curriculum = ?,classroom = ?,teacher = ?,curriculum2 = ?,classroom2 = ?,teacher2 = ? where numberStr = ?";
            [self.timeTableDB executeUpdate:update,model.curriculum,model.classroom,model.teacher,model.curriculum2,model.classroom2,model.teacher2,model.numberStr];
        } else {
            // 不存在，走保存
            NSString *insertData = @"insert into time_table_list (week,section,curriculum,classroom,teacher,curriculum2,classroom2,teacher2,isSingle,isDouble,numberStr) values (?,?,?,?,?,?,?,?,?,?,?)";
            if (!model.isSingle && model.isDouble) {
                // 0, 1
                [self.timeTableDB executeUpdate:insertData,model.week,model.section,model.curriculum,model.classroom,model.teacher,model.curriculum2,model.classroom2,model.teacher2,@0,@1,model.numberStr];
            } else if (!model.isSingle && !model.isDouble) {
                // 0, 0
                [self.timeTableDB executeUpdate:insertData,model.week,model.section,model.curriculum,model.classroom,model.teacher,model.curriculum2,model.classroom2,model.teacher2,@0,@0,model.numberStr];
            } else if (model.isSingle && !model.isDouble) {
                // 1, 0
                [self.timeTableDB executeUpdate:insertData,model.week,model.section,model.curriculum,model.classroom,model.teacher,model.curriculum2,model.classroom2,model.teacher2,@1,@0,model.numberStr];
            } else {
                // 1, 1
                [self.timeTableDB executeUpdate:insertData,model.week,model.section,model.curriculum,model.classroom,model.teacher,model.curriculum2,model.classroom2,model.teacher2,@1,@1,model.numberStr];
            }
        }
    }
    [self.timeTableDB close];
}

#pragma mark - funcs

- (void)getDocumentPath {
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSLog(@"path = %@",path);
    NSString *filePath = [path stringByAppendingPathComponent:@"YourBasedateName.sqlite"];
    NSLog(@"filePath = %@",filePath);
}

- (void)createAppAllDBs {
    [self createTimeTableDB];
//    [self createMemorandumDB];
//    [self createNoteDB];
//    [self createDrawingDB];
//    [self createAccountDB];
}

- (void)createTimeTableDB {
    NSString *folderPath = [self createFolderDBWithName:@"TimeTable"];
    NSString *dbPath = [folderPath stringByAppendingPathComponent:@"TimeTable.sqlite"];
    FMDatabase *db = [FMDatabase databaseWithPath:dbPath];
    self.timeTableDB = db;
    if ([db open]) {
        NSLog(@"打开TimeTable数据库成功");
        NSString *createTable = @"create table if not exists time_table_list (week integer ,section integer ,curriculum text ,classroom text ,teacher text ,curriculum2 text ,classroom2 text ,teacher2 text ,isSingle integer ,isDouble integer ,numberStr text primary key)";
        if ([db executeUpdate:createTable]) {
            NSLog(@"创造TimeTable表成功");
        } else {
            NSLog(@"创造TimeTable表失败");
        }
    }else{
        NSLog(@"打开TimeTable数据库失败");
    }
    [db close];
}

//- (void)createMemorandumDB {
//    NSString *folderPath = [self createFolderDBWithName:@"Memorandum"];
//}
//
//- (void)createNoteDB {
//    NSString *folderPath = [self createFolderDBWithName:@"Note"];
//}
//
//- (void)createDrawingDB {
//    NSString *folderPath = [self createFolderDBWithName:@"Drawing"];
//}
//
//- (void)createAccountDB {
//    NSString *folderPath = [self createFolderDBWithName:@"Account"];
//}

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
