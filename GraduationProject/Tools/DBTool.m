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
#import "GPAccountModel.h"
#import "GPMemorandumModel.h"
#import "GPNoteModel.h"
#import "GPNoteContentModel.h"

static DBTool *_singleInstance = nil;

@interface DBTool ()

@property (nonatomic, copy) NSString *timeTableList;
@property (nonatomic, copy) NSString *timeTable;
@property (nonatomic, copy) NSString *timeTableDB;

@property (nonatomic, copy) NSString *drawingList;
@property (nonatomic, copy) NSString *drawing;
@property (nonatomic, copy) NSString *drawingDB;

@property (nonatomic, copy) NSString *accountList;
@property (nonatomic, copy) NSString *account;
@property (nonatomic, copy) NSString *accountDB;

@property (nonatomic, copy) NSString *memorandumList;
@property (nonatomic, copy) NSString *memorandum;
@property (nonatomic, copy) NSString *memorandumDB;

@property (nonatomic, copy) NSString *noteList;
@property (nonatomic, copy) NSString *note;
@property (nonatomic, copy) NSString *noteContentList;
@property (nonatomic, copy) NSString *noteDB;

@end

@implementation DBTool

#pragma mark - delete

- (void)deleteNoteContentWith:(GPNoteContentModel *)model complate:(void(^)(BOOL success))complate {
    FMDatabase *noteDB = [self getDatabaseWith:self.note];
    if ([noteDB open]) {
        NSString *delete = [NSString stringWithFormat:@"delete from %@ where contentNumberStr = ?",self.noteContentList];
        BOOL success = [noteDB executeUpdate:delete, model.contentNumberStr];
        !complate?:complate(success);
    } else {
        !complate?:complate(NO);
    }
    [noteDB close];
}

- (void)deleteNoteWith:(GPNoteModel *)model complate:(void(^)(BOOL success))complate {
    FMDatabase *noteDB = [self getDatabaseWith:self.note];
    if ([noteDB open]) {
        NSString *delete1 = [NSString stringWithFormat:@"delete from %@ where numberStr = ?",self.noteList];
        BOOL success1 = [noteDB executeUpdate:delete1, model.numberStr];
        NSString *delete2 = [NSString stringWithFormat:@"delete from %@ where numberStr = ?",self.noteContentList];
        BOOL success2 = [noteDB executeUpdate:delete2, model.numberStr];
        BOOL success = (success1 && success2)?YES:NO;
        !complate?:complate(success);
    } else {
        !complate?:complate(NO);
    }
    [noteDB close];
}

- (void)deleteDrawingWith:(GPDrawModel *)model complate:(void(^)(BOOL success))complate {
    FMDatabase *drawDB = [self getDatabaseWith:self.drawing];
    if ([drawDB open]) {
        NSString *delete = [NSString stringWithFormat:@"delete from %@ where numberStr = ?",self.drawingList];
        BOOL success = [drawDB executeUpdate:delete, model.numberStr];
        !complate?:complate(success);
    } else {
        !complate?:complate(NO);
    }
    [drawDB close];
}

- (void)deleteMemorandumWith:(NSString *)numberStr complate:(void(^)(BOOL success))complate {
    FMDatabase *memorandumDB = [self getDatabaseWith:self.memorandum];
    if ([memorandumDB open]) {
        NSString *delete = [NSString stringWithFormat:@"delete from %@ where numberStr = ?",self.memorandumList];
        BOOL success = [memorandumDB executeUpdate:delete, numberStr];
        !complate?:complate(success);
    } else {
       !complate?:complate(NO);
    }
    [memorandumDB close];
}

#pragma mark - get

- (void)getNoteContentWith:(GPNoteModel *)noteModel noteContents:(void (^)(NSArray *noteContents))noteContent {
    NSMutableArray <GPNoteContentModel *>*noteContentArray = [NSMutableArray array];
    FMDatabase *noteDB = [self getDatabaseWith:self.note];
    if ([noteDB open]) {
        NSString *sql = [NSString stringWithFormat:@"select * FROM %@ where numberStr = ?",self.noteContentList];
        FMResultSet *rs = [noteDB executeQuery:sql,noteModel.numberStr];
        if (rs.columnCount > 0) {
            while ([rs next]) {
                GPNoteContentModel *model = [[GPNoteContentModel alloc] init];
                model.timeStr = [rs stringForColumn:@"timeStr"];
                model.titleStr = [rs stringForColumn:@"titleStr"];
                model.numberStr = [rs stringForColumn:@"numberStr"];
                model.imageStr = [rs stringForColumn:@"imageStr"];
                NSData *decodedImageData = [[NSData alloc] initWithBase64EncodedString:[rs stringForColumn:@"imageStr"] options:NSDataBase64DecodingIgnoreUnknownCharacters];
                model.image = [UIImage imageWithData:decodedImageData];
                model.contentData = [rs dataForColumn:@"content"];
                model.contentNumberStr = [rs stringForColumn:@"contentNumberStr"];
                [noteContentArray addObject:model];
            }
            !noteContent?:noteContent(noteContentArray);
        } else {
            !noteContent?:noteContent(noteContentArray);
        }
    } else {
        !noteContent?:noteContent(noteContentArray);
    }
    [noteDB close];
}

- (void)getNote:(void (^)(NSArray *notes))note {
    NSMutableArray <GPNoteModel *>*noteArray = [NSMutableArray array];
    FMDatabase *noteDB = [self getDatabaseWith:self.note];
    if ([noteDB open]) {
        NSString *sql = [NSString stringWithFormat:@"select * FROM %@",self.noteList];
        FMResultSet *rs = [noteDB executeQuery:sql];
        if (rs.columnCount > 0) {
            while ([rs next]) {
                GPNoteModel *model = [[GPNoteModel alloc] init];
                model.name = [rs stringForColumn:@"name"];
                model.numberStr = [rs stringForColumn:@"numberStr"];
                model.coverImageStr = [rs stringForColumn:@"coverImageStr"];
                NSData *decodedImageData = [[NSData alloc] initWithBase64EncodedString:[rs stringForColumn:@"coverImageStr"] options:NSDataBase64DecodingIgnoreUnknownCharacters];
                model.coverImage = [UIImage imageWithData:decodedImageData];
                [noteArray addObject:model];
            }
            !note?:note(noteArray);
        } else {
            !note?:note(noteArray);
        }
    } else {
        !note?:note(noteArray);
    }
    [noteDB close];
}

- (void)getMemorandum:(void (^)(NSArray *))memorandum {
    NSMutableArray <GPMemorandumModel *>*memorandumArr = [NSMutableArray array];
    FMDatabase *memorandumDB = [self getDatabaseWith:self.memorandum];
    if ([memorandumDB open]) {
        NSString *sql = [NSString stringWithFormat:@"select * FROM %@",self.memorandumList];
        FMResultSet *rs = [memorandumDB executeQuery:sql];
        if (rs.columnCount > 0) {
            while ([rs next]) {
                GPMemorandumModel *model = [[GPMemorandumModel alloc] init];
                model.endTime = [rs stringForColumn:@"endTime"];
                model.isEveryday  = [NSNumber numberWithInt:[rs intForColumn:@"isEveryday"]];
                if ([NSDate compareDateWithNow:model.endTime] || [model.isEveryday boolValue]) {
                    model.content   = [rs stringForColumn:@"content"];
                    model.startTime = [rs stringForColumn:@"startTime"];
                    model.isCountDown = [NSNumber numberWithInt:[rs intForColumn:@"isCountDown"]];
                    model.isRemind    = [NSNumber numberWithInt:[rs intForColumn:@"isRemind"]];
                    model.sortTime    = [NSNumber numberWithInt:[rs intForColumn:@"sortTime"]];
                    model.remindTime = [rs stringForColumn:@"remindTime"];
                    model.numberStr = [rs stringForColumn:@"numberStr"];
                    [memorandumArr addObject:model];
                }
            }
            !memorandum?:memorandum(memorandumArr);
        } else {
            !memorandum?:memorandum(memorandumArr);
        }
    } else {
        !memorandum?:memorandum(memorandumArr);
    }
    [memorandumDB close];
}

- (void)getAccount:(void (^)(NSArray *))account {
    NSMutableArray <GPAccountModel *>*accountArr = [NSMutableArray array];
    FMDatabase *accountDB = [self getDatabaseWith:self.account];
    if ([accountDB open]) {
        NSString *sql = [NSString stringWithFormat:@"select * FROM %@",self.accountList];
        FMResultSet *rs = [accountDB executeQuery:sql];
        if (rs.columnCount > 0) {
            while ([rs next]) {
                GPAccountModel *model = [[GPAccountModel alloc] init];
                model.year      = [NSNumber numberWithInt:[rs intForColumn:@"year"]];
                model.month     = [NSNumber numberWithInt:[rs intForColumn:@"month"]];
                model.day       = [NSNumber numberWithInt:[rs intForColumn:@"day"]];
                model.amount    = [NSNumber numberWithDouble:[rs doubleForColumn:@"amount"]];
                model.isInput   = [NSNumber numberWithInt:[rs intForColumn:@"isInput"]];
                model.content   = [rs stringForColumn:@"content"];
                model.timeStr   = [rs stringForColumn:@"timeStr"];
                model.dateStr   = [rs stringForColumn:@"dateStr"];
                model.numberStr = [rs stringForColumn:@"numberStr"];
                [accountArr addObject:model];
            }
            !account?:account(accountArr);
        } else {
            !account?:account(accountArr);
        }
    } else {
        !account?:account(accountArr);
    }
    [accountDB close];
}

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
                model.name      = [rs stringForColumn:@"name"];
                model.imageData = [rs stringForColumn:@"imageData"];
                model.pathsData = [rs dataForColumn:@"pathsData"];
                model.numberStr = [rs stringForColumn:@"numberStr"];
                model.colorsData = [rs dataForColumn:@"colorsData"];
                NSData *decodedImageData = [[NSData alloc] initWithBase64EncodedString:[rs stringForColumn:@"imageData"] options:NSDataBase64DecodingIgnoreUnknownCharacters];
                model.image =  [UIImage imageWithData:decodedImageData];
                NSArray *pathsArray = [NSKeyedUnarchiver unarchiveObjectWithData:model.pathsData];
                model.paths = [NSMutableArray arrayWithArray:pathsArray];
                NSArray *colorsArray = [NSKeyedUnarchiver unarchiveObjectWithData:model.colorsData];
                model.colors = [NSMutableArray arrayWithArray:colorsArray];
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
- (void)saveNoteWith:(GPNoteModel *)model complate:(void(^)(BOOL success))complate {
    FMDatabase *noteDB = [self getDatabaseWith:self.note];
    if ([noteDB open]) {
        // 查询是否存在这一条数据
        NSString *sql = [NSString stringWithFormat:@"select * FROM %@ where numberStr = ?",self.noteList];
        FMResultSet *rs = [noteDB executeQuery:sql,model.numberStr];
        if (rs.next) {
            // 存在，走修改
            NSString *update = [NSString stringWithFormat:@"update %@ set name = ?, coverImageStr = ? where numberStr = ?",self.noteList];
            BOOL success = [noteDB executeUpdate:update,model.name,model.coverImageStr,model.numberStr];
            !complate?:complate(success);
        } else {
            // 不存在，走保存
            NSString *insertData = [NSString stringWithFormat:@"insert into %@ (name,coverImageStr,numberStr) values (?,?,?)",self.noteList];
            BOOL success = [noteDB executeUpdate:insertData,model.name,model.coverImageStr,model.numberStr];
            !complate?:complate(success);
        }
    }
}


- (void)saveNoteContentWith:(GPNoteContentModel *)contentModel complate:(void(^)(BOOL success))complate {
    FMDatabase *noteDB = [self getDatabaseWith:self.note];
    if ([noteDB open]) {
        // 查询是否存在这一条数据
        NSString *sql = [NSString stringWithFormat:@"select * FROM %@ where contentNumberStr = ?",self.noteContentList];
        FMResultSet *rs = [noteDB executeQuery:sql,contentModel.numberStr];
        if (rs.next) {
            // 存在，走修改
            NSString *update = [NSString stringWithFormat:@"update %@ set timeStr = ?, titleStr = ?,imageStr = ?,content = ? where contentNumberStr = ?",self.noteContentList];
            
            BOOL success = [noteDB executeUpdate:update,contentModel.timeStr,contentModel.titleStr,contentModel.imageStr,contentModel.contentData];
            !complate?:complate(success);
        } else {
            // 不存在，走保存
            NSString *insertData = [NSString stringWithFormat:@"insert into %@ (timeStr, titleStr,imageStr,content ,numberStr,contentNumberStr) values (?,?,?,?,?,?)",self.noteContentList];
            BOOL success = [noteDB executeUpdate:insertData,contentModel.timeStr,contentModel.titleStr,contentModel.imageStr,contentModel.contentData,contentModel.numberStr,contentModel.contentNumberStr];
            !complate?:complate(success);
        }
    }
}


- (void)saveMemorandumWith:(GPMemorandumModel *)model complate:(void (^)(BOOL))complate {
    FMDatabase *memorandumDB = [self getDatabaseWith:self.memorandum];
    if ([memorandumDB open]) {
        // 查询是否存在这一条数据
        NSString *sql = [NSString stringWithFormat:@"select * FROM %@ where numberStr = ?",self.memorandumList];
        FMResultSet *rs = [memorandumDB executeQuery:sql,model.numberStr];
        if (rs.next) {
            // 存在，走修改
            NSString *update = [NSString stringWithFormat:@"update %@ set content = ?, startTime = ?, endTime = ?,remindTime = ?,isCountDown = ?,isRemind = ?,isEveryday = ?,sortTime = ? where numberStr = ?",self.memorandumList];
            BOOL success = [memorandumDB executeUpdate:update,model.content,model.startTime,model.endTime,model.remindTime,model.isCountDown,model.isRemind,model.isEveryday,model.sortTime,model.numberStr];
            !complate?:complate(success);
        } else {
            // 不存在，走保存
            NSString *insertData = [NSString stringWithFormat:@"insert into %@ (content,startTime,endTime,remindTime,isCountDown,isRemind,isEveryday,sortTime,numberStr) values (?,?,?,?,?,?,?,?,?)",self.memorandumList];
            BOOL success = [memorandumDB executeUpdate:insertData,model.content,model.startTime,model.endTime,model.remindTime,model.isCountDown,model.isRemind,model.isEveryday,model.sortTime,model.numberStr];
            !complate?:complate(success);
        }
    }
}

- (void)saveAccountWith:(GPAccountModel *)model complate:(void (^)(BOOL))complate {
    FMDatabase *accountDB = [self getDatabaseWith:self.account];
    if ([accountDB open]) {
        // 查询是否存在这一条数据
        NSString *sql = [NSString stringWithFormat:@"select * FROM %@ where numberStr = ?",self.accountList];
        FMResultSet *rs = [accountDB executeQuery:sql,model.numberStr];
        if (rs.next) {
            // 存在，走修改
            NSString *update = [NSString stringWithFormat:@"update %@ set year = ?,month = ?,day = ?,amount = ?,isInput = ?,content = ?,timeStr = ?,dateStr = ? where numberStr = ?",self.accountList];
            BOOL success = [accountDB executeUpdate:update,model.year,model.month,model.day,model.amount,model.isInput,model.content,model.timeStr,model.dateStr,model.numberStr];
            !complate?:complate(success);
        } else {
            // 不存在，走保存
            NSString *insertData = [NSString stringWithFormat:@"insert into %@ (year,month,day,amount,isInput,content,timeStr,dateStr,numberStr) values (?,?,?,?,?,?,?,?,?)",self.accountList];
            BOOL success = [accountDB executeUpdate:insertData,model.year,model.month,model.day,model.amount,model.isInput,model.content,model.timeStr,model.dateStr,model.numberStr];
            !complate?:complate(success);
        }
    }
}

- (void)saveDrawingWith:(GPDrawModel *)model complate:(void(^)(BOOL success))complate {
    FMDatabase *drawingDB = [self getDatabaseWith:self.drawing];
    if ([drawingDB open]) {
        // 查询是否存在这一条数据
        NSString *sql = [NSString stringWithFormat:@"select * FROM %@ where numberStr = ?",self.drawingList];
        FMResultSet *rs = [drawingDB executeQuery:sql,model.numberStr];
        if (rs.next) {
            // 存在，走修改
            NSString *update = [NSString stringWithFormat:@"update %@ set name = ?,imageData = ?,pathsData = ? ,colorsData = ? where numberStr = ?",self.drawingList];
            BOOL success = [drawingDB executeUpdate:update,model.name,model.imageData,model.pathsData,model.colorsData,model.numberStr];
            !complate?:complate(success);
        } else {
            // 不存在，走保存
            NSString *insertData = [NSString stringWithFormat:@"insert into %@ (name,imageData,pathsData,colorsData,numberStr) values (?,?,?,?,?)",self.drawingList];
            BOOL success = [drawingDB executeUpdate:insertData,model.name,model.imageData,model.pathsData,model.colorsData,model.numberStr];
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
    [self createMemorandumDB];
    [self createNoteDB];
    [self createDrawingDB];
    [self createAccountDB];
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

- (void)createMemorandumDB {
    NSString *folderPath = [self createFolderDBWithName:self.memorandum];
    NSString *dbPath = [folderPath stringByAppendingPathComponent:self.memorandumDB];
    FMDatabase *db = [FMDatabase databaseWithPath:dbPath];
    if ([db open]) {
        NSLog(@"打开Memorandum数据库成功");
        NSString *createTable = [NSString stringWithFormat:@"create table if not exists %@ (content text, startTime text, endTime text,remindTime text,isCountDown integer,isRemind integer,isEveryday integer,sortTime integer ,numberStr text primary key)",self.memorandumList];
        if ([db executeUpdate:createTable]) {
            NSLog(@"创造Memorandum表成功");
        } else {
            NSLog(@"创造Memorandum表失败");
        }
    }else{
        NSLog(@"打开Memorandum数据库失败");
    }
    [db close];
}

- (void)createNoteDB {
    NSString *folderPath = [self createFolderDBWithName:self.note];
    NSString *dbPath = [folderPath stringByAppendingPathComponent:self.noteDB];
    FMDatabase *db = [FMDatabase databaseWithPath:dbPath];
    if ([db open]) {
        NSLog(@"打开Note数据库成功");
        NSString *createTable1 = [NSString stringWithFormat:@"create table if not exists %@ (name text, coverImageStr text,numberStr text primary key)",self.noteList];
        if ([db executeUpdate:createTable1]) {
            NSLog(@"创造Note表成功");
        } else {
            NSLog(@"创造Note表失败");
        }
        NSString *createTable2 = [NSString stringWithFormat:@"create table if not exists %@ (timeStr text, titleStr text,imageStr text,content blob,numberStr text,contentNumberStr text primary key)",self.noteContentList];
        if ([db executeUpdate:createTable2]) {
            NSLog(@"创造NoteContent表成功");
        } else {
            NSLog(@"创造NoteContent表失败");
        }
    }else{
        NSLog(@"打开Note数据库失败");
    }
    [db close];
}

- (void)createDrawingDB {
    NSString *folderPath = [self createFolderDBWithName:self.drawing];
    NSString *dbPath = [folderPath stringByAppendingPathComponent:self.drawingDB];
    FMDatabase *db = [FMDatabase databaseWithPath:dbPath];
    if ([db open]) {
        NSLog(@"打开Drawing数据库成功");
        NSString *createTable = [NSString stringWithFormat:@"create table if not exists %@ (name text, imageData text, pathsData blob, colorsData blob,numberStr text primary key)",self.drawingList];
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

- (void)createAccountDB {
    NSString *folderPath = [self createFolderDBWithName:self.account];
    NSString *dbPath = [folderPath stringByAppendingPathComponent:self.accountDB];
    FMDatabase *db = [FMDatabase databaseWithPath:dbPath];
    if ([db open]) {
        NSLog(@"打开Account数据库成功");
        NSString *createTable = [NSString stringWithFormat:@"create table if not exists %@ (year integer, month integer, day integer, amount real, isInput integer, content text, timeStr text, dateStr text, numberStr text primary key)",self.accountList];
        if ([db executeUpdate:createTable]) {
            NSLog(@"创造Account表成功");
        } else {
            NSLog(@"创造Account表失败");
        }
    }else{
        NSLog(@"打开Account数据库失败");
    }
    [db close];
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
            
            _singleInstance.timeTable = @"TimeTable";
            _singleInstance.timeTableList = @"time_table_list";
            _singleInstance.timeTableDB = @"TimeTable.sqlite";
            
            _singleInstance.drawing = @"Drawing";
            _singleInstance.drawingList = @"drawing_list";
            _singleInstance.drawingDB = @"Drawing.sqlite";
            
            _singleInstance.account = @"Account";
            _singleInstance.accountList = @"account_list";
            _singleInstance.accountDB = @"Account.sqlite";
            
            _singleInstance.memorandum = @"Memorandum";
            _singleInstance.memorandumList = @"memorandum_list";
            _singleInstance.memorandumDB = @"Memorandum.sqlite";
            
            _singleInstance.note = @"Note";
            _singleInstance.noteList = @"note_list";
            _singleInstance.noteContentList = @"note_content_list";
            _singleInstance.noteDB = @"Note.sqlite";
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
