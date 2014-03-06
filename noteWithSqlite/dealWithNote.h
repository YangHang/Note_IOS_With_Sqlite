//
//  dealWithNote.h
//  noteWithSqlite
//
//  Created by Yang on 14-3-3.
//  Copyright (c) 2014年 Yang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Note.h"
#import "sqlite3.h"

#define DBFILE_NAME @"NotesList.sqlite3"

@interface dealWithNote : NSObject
{
    sqlite3 *db;
}

@property(nonatomic,strong)NSMutableArray *listData;

+ (dealWithNote *)sharedManager;
- (NSString *)applicationDocumentsDirector;
- (void)createEditableCopyOfDatabaseIfNeeded;
- (void)add:(Note *)model;
- (NSMutableArray *)show;
- (void)deleteNote:(Note *)model;


@end
