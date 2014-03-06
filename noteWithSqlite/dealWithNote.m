//
//  dealWithNote.m
//  noteWithSqlite
//
//  Created by Yang on 14-3-3.
//  Copyright (c) 2014年 Yang. All rights reserved.
//

#import "dealWithNote.h"


@implementation dealWithNote

static dealWithNote *sharedManager = nil;

+ (dealWithNote *)sharedManager
{
    static dispatch_once_t onece;
    dispatch_once(&onece,^{
        sharedManager = [[self alloc] init];
        [sharedManager createEditableCopyOfDatabaseIfNeeded];
    });
    return sharedManager;
}

- (NSString *)applicationDocumentsDirector
{
    
    NSString *documentPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *path = [documentPath stringByAppendingPathComponent:DBFILE_NAME];
    return path;
}

- (void)createEditableCopyOfDatabaseIfNeeded

{
    
        NSString *writableDBPath = [self applicationDocumentsDirector];
        if (sqlite3_open([writableDBPath UTF8String], &db) != SQLITE_OK) {
            sqlite3_close(db);
            NSLog(@"打开数据库失败！");
        }else{
        char *err;
        NSString *createSQL = [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS Note (ID INTEGER PRIMARY KEY AUTOINCREMENT,content TEXT);"];
        if (sqlite3_exec(db, [createSQL UTF8String], NULL, NULL, &err) !=  SQLITE_OK) {
            sqlite3_close(db);  
            NSLog(@"Error making INSERT: %s", sqlite3_errmsg(db));
        }
    }
    sqlite3_close(db);
}

- (NSMutableArray *)show
{
    NSString *path = [self applicationDocumentsDirector];
    
    
    if (sqlite3_open([path UTF8String], &db) != SQLITE_OK) {
        sqlite3_close(db);
        NSAssert(NO, @"Open Failed");
    }else{
        NSString *findAllQuery = @"SELECT  ID,content FROM Note";
        sqlite3_stmt *statement;
        if (sqlite3_prepare_v2(db, [findAllQuery UTF8String], -1, &statement, NULL) == SQLITE_OK)
        {
            self.listData = [[NSMutableArray alloc] init];
            Note *note = [[Note alloc] init];
            while (sqlite3_step(statement) == SQLITE_ROW) {

            int myid = sqlite3_column_int(statement, 0);
            char *content = sqlite3_column_text(statement, 1);
                NSString *nscontent =   [NSString stringWithFormat:@"%s",content];
            NSNumber *nsid = [NSNumber numberWithInt:myid];
            Note *note = [[Note alloc] init];
            note.content = nscontent;
            note.iid = nsid;
            [self.listData addObject:note];
        }
      }
        
        sqlite3_finalize(statement);
        sqlite3_close(db);
    }

    return self.listData;
}

- (void)add:(Note *)model
{
    
    NSString *path = [self applicationDocumentsDirector];
    
    if (sqlite3_open([path UTF8String], &db) != SQLITE_OK) {
        NSAssert(NO, @"Open Failed");
        NSLog(@"faile open");
    }else{
        NSString *insertQuery = @"INSERT OR REPLACE INTO Note (ID,content) VALUES(NULL,?)";
        sqlite3_stmt *statement;
        if (sqlite3_prepare_v2(db, [insertQuery UTF8String], -1, &statement, NULL) == SQLITE_OK) {
            
            NSString *nscontent = model.content;
            sqlite3_bind_text(statement,1, [nscontent UTF8String], -1, NULL);
    
            if (sqlite3_step(statement) != SQLITE_DONE) {
                NSAssert(NO, @"insert failed");
            }
        }
        sqlite3_finalize(statement);
        sqlite3_close(db);
    }
}

- (void)deleteNote:(Note *)model

{
    NSString *deleteQuery = @"DELETE content FROM Note WHERE content = ?";
    NSString *path = [self applicationDocumentsDirector];
    sqlite3_stmt *statement;
    if (sqlite3_open([path UTF8String], &db) != SQLITE_OK) {
        sqlite3_close(db);
        NSAssert(NO, @"Open Failed");
        NSLog(@"fuck");

    }else{
        if (sqlite3_prepare_v2(db, [deleteQuery UTF8String], -1, &statement, NULL) == SQLITE_OK) {
            NSLog(@"dfdfdf");
            sqlite3_bind_text(statement, 1, [model.content UTF8String], -1, SQLITE_TRANSIENT);
        }

}
}
@end
