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
#import "GPDrawModel.h"

static DBTool *_singleInstance = nil;

@interface DBTool ()

@property (nonatomic, copy) NSString *timeTableList;
@property (nonatomic, copy) NSString *timeTable;
@property (nonatomic, copy) NSString *timeTableDB;
@property (nonatomic, copy) NSString *drawingList;
@property (nonatomic, copy) NSString *drawing;
@property (nonatomic, copy) NSString *drawingDB;
@end

@implementation DBTool

#pragma mark - get

- (void)getCurriculums:(void(^)(NSArray *singleArray))singleDate double:(void(^)(NSArray *doubleArray))doubleDate{
    NSMutableArray <GPCurriculumModel *>*singleArr = [NSMutableArray array];
    NSMutableArray <GPCurriculumModel *>*doubleArr = [NSMutableArray array];
    FMDatabase *timeTableDB = [self getDatabaseWith:self.timeTable];
    if ([timeTableDB open]) {
        NSString *sql = [NSString stringWithFormat:@"select * FROM %@",self.timeTableList];
        FMResultSet *rs = [timeTableDB executeQuery:sql];
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
    [timeTableDB close];
}

- (void)getDrawing:(void(^)(NSArray *drawings))draw {
    NSMutableArray <GPDrawModel *>*drawingsArr = [NSMutableArray array];
    FMDatabase *drawingDB = [self getDatabaseWith:self.drawing];
    if ([drawingDB open]) {
        NSString *sql = [NSString stringWithFormat:@"select * FROM %@",self.drawingList];
        FMResultSet *rs = [drawingDB executeQuery:sql];
        if (rs.columnCount > 0) {
            while ([rs next]) {
                GPDrawModel *model = [[GPDrawModel alloc] init];
                model.name = [rs stringForColumn:@"name"];
                model.imageData = [rs stringForColumn:@"imageData"];
                model.pathsData = [rs stringForColumn:@"pathsData"];
                model.numberStr   = [rs stringForColumn:@"numberStr"];
                NSData *decodedImageData = [[NSData alloc] initWithBase64EncodedString:[rs stringForColumn:@"imageData"] options:NSDataBase64DecodingIgnoreUnknownCharacters];
                model.image =  [UIImage imageWithData:decodedImageData];
                [model restorePathsArrayWith:[rs stringForColumn:@"pathsData"] pathsImage:[rs stringForColumn:@"pathImage"] imageIndex:[NSNumber numberWithInt:[rs intForColumn:@"imageIndex"]]];                
                [drawingsArr addObject:model];
            }
            !draw?:draw(drawingsArr);
        } else {
            !draw?:draw(drawingsArr);
        }
    } else {
        !draw?:draw(drawingsArr);
    }
    [drawingDB close];
}


#pragma mark - save

- (void)saveDrawingWith:(GPDrawModel *)model complate:(void(^)(BOOL success))complate {
    FMDatabase *drawingDB = [self getDatabaseWith:self.drawing];
    if ([drawingDB open]) {
        // 查询是否存在这一条数据
        NSString *sql = [NSString stringWithFormat:@"select * FROM %@ where numberStr = ?",self.drawingList];
        FMResultSet *rs = [drawingDB executeQuery:sql,model.numberStr];
        if (rs.next) {
            // 存在，走修改
            NSString *update = [NSString stringWithFormat:@"update %@ set name = ?,imageData = ?,pathsData = ?,imageIndex = ?,pathImage = ? where numberStr = ?",self.drawingList];
            BOOL success = [drawingDB executeUpdate:update,model.name,model.imageData,model.pathsData,model.imageIndex,model.pathsImageData,model.numberStr];
            !complate?:complate(success);
        } else {
            // 不存在，走保存
            NSString *insertData = [NSString stringWithFormat:@"insert into %@ (name,imageData,pathsData,imageIndex,pathImage,numberStr) values (?,?,?,?,?,?)",self.drawingList];
            BOOL success = [drawingDB executeUpdate:insertData,model.name,model.imageData,model.pathsData,model.imageIndex,model.pathsImageData,model.numberStr];
            !complate?:complate(success);
        }
    }
}

- (void)saveCurriculumWith:(GPCurriculumModel *)model complate:(void(^)(BOOL success))complate {
    FMDatabase *timeTableDB = [self getDatabaseWith:self.timeTable];
    if ([timeTableDB open]) {
        // 查询是否存在这一条数据
        NSString *sql = [NSString stringWithFormat:@"select * FROM %@ where numberStr = ?",self.timeTableList];
        FMResultSet *rs = [timeTableDB executeQuery:sql,model.numberStr];
        if (rs.next) {
            // 存在，走修改
            NSString *update = [NSString stringWithFormat:@"update %@ set curriculum = ?,classroom = ?,teacher = ?,curriculum2 = ?,classroom2 = ?,teacher2 = ? where numberStr = ?",self.timeTableList];
            BOOL success = [timeTableDB executeUpdate:update,model.curriculum,model.classroom,model.teacher,model.curriculum2,model.classroom2,model.teacher2,model.numberStr];
            !complate?:complate(success);
        } else {
            // 不存在，走保存
            NSString *insertData = [NSString stringWithFormat:@"insert into %@ (week,section,curriculum,classroom,teacher,curriculum2,classroom2,teacher2,isSingle,isDouble,numberStr) values (?,?,?,?,?,?,?,?,?,?,?)",self.timeTableList];
            NSNumber *week = [NSNumber numberWithInteger:model.week];
            NSNumber *section = [NSNumber numberWithInteger:model.section];
            NSNumber *isSingle = [NSNumber numberWithBool:model.isSingle];
            NSNumber *isDouble = [NSNumber numberWithBool:model.isDouble];
            BOOL success = [timeTableDB executeUpdate:insertData,week,section,model.curriculum,model.classroom,model.teacher,model.curriculum2,model.classroom2,model.teacher2,isSingle,isDouble,model.numberStr];
            !complate?:complate(success);
        }
    }
    [timeTableDB close];
}

#pragma mark - funcs

- (FMDatabase *)getDatabaseWith:(NSString *)folderName {
    NSString *documentPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *folderPath = [documentPath stringByAppendingPathComponent:folderName];
    NSString *dbName = [NSString stringWithFormat:@"%@.sqlite",folderName];
    FMDatabase *db = [FMDatabase databaseWithPath:[folderPath stringByAppendingPathComponent:dbName]];
    return db;
}

- (void)createAppAllDBs {
    [self createTimeTableDB];
//    [self createMemorandumDB];
//    [self createNoteDB];
    [self createDrawingDB];
//    [self createAccountDB];
}

- (void)createTimeTableDB {
    NSString *folderPath = [self createFolderDBWithName:self.timeTable];
    NSString *dbPath = [folderPath stringByAppendingPathComponent:self.timeTableDB];
    FMDatabase *db = [FMDatabase databaseWithPath:dbPath];
    if ([db open]) {
        NSLog(@"打开TimeTable数据库成功");
        NSString *createTable = [NSString stringWithFormat:@"create table if not exists %@ (week integer ,section integer ,curriculum text ,classroom text ,teacher text ,curriculum2 text ,classroom2 text ,teacher2 text ,isSingle integer ,isDouble integer ,numberStr text primary key)",self.timeTableList];
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
- (void)createDrawingDB {
    NSString *folderPath = [self createFolderDBWithName:self.drawing];
    NSString *dbPath = [folderPath stringByAppendingPathComponent:self.drawingDB];
    FMDatabase *db = [FMDatabase databaseWithPath:dbPath];
    if ([db open]) {
        NSLog(@"打开Drawing数据库成功");
        NSString *createTable = [NSString stringWithFormat:@"create table if not exists %@ (name text, imageData text, pathsData text, imageIndex integer, pathImage text,numberStr text primary key)",self.drawingList];
        if ([db executeUpdate:createTable]) {
            NSLog(@"创造Drawing表成功");
        } else {
            NSLog(@"创造Drawing表失败");
        }
    }else{
        NSLog(@"打开Drawing数据库失败");
    }
    [db close];
}
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
            _singleInstance.timeTable = @"TimeTable";
            _singleInstance.timeTableList = @"time_table_list";
            _singleInstance.timeTableDB = @"TimeTable.sqlite";
            _singleInstance.drawing = @"Drawing";
            _singleInstance.drawingList = @"drawing_list";
            _singleInstance.drawingDB = @"Drawing.sqlite";
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
