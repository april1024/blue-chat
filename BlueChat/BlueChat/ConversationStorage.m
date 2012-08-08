//
//  ConversationStorage.m
//  BlueChat
//
//  Created by Lee TaeHwan on 8/8/12.
//  Copyright (c) 2012 NHN Map FE. All rights reserved.
//

#import "ConversationStorage.h"

@implementation ConversationStorage

- (id)init
{
    if (self = [super init])
    {
        [self initDB:@SQLITE_FILE_NAME];
    }
    
    return self;
}

- (void)initDB: (NSString *)sqlFileName {
    NSString *docsDir;
    NSArray *dirPaths;
    
    //  documents directory 확인하기
    dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    docsDir = [dirPaths objectAtIndex:0];
    
    //  database file path 구성하기
    databasePath = [[NSString alloc] initWithString:[docsDir stringByAppendingPathComponent:sqlFileName]];
    
    NSFileManager *fileMgr = [NSFileManager defaultManager];
    
    if ([fileMgr fileExistsAtPath:databasePath] == NO) {
        const char *dbpath = [databasePath UTF8String];
        
        if (sqlite3_open(dbpath, &blueChatDB) == SQLITE_OK) {
            NSError *error;
            NSString *ddl = [[NSString alloc] initWithContentsOfFile:@DDL_FILE_NAME encoding:NSUTF8StringEncoding error:&error];
            
            if (ddl == nil) {
                NSLog(@"Failed to read file %@", error);
            }
            
            char *errMsg;
            const char *sql_stmt = [ddl UTF8String];
            
            if (sqlite3_exec(blueChatDB, sql_stmt, NULL, NULL, &errMsg) != SQLITE_OK) {
                NSLog(@"Failed to create table %s", errMsg);
            }
            
            sqlite3_close(blueChatDB);
        } else {
            NSLog(@"Failed to open database");
        }
    }
}

- (void)insertPerson: (NSString *)id name:(NSString *)name
{
    
}

- (NSMutableArray *)getChatRoomList
{
    
}

- (NSMutableArray *)getChatList: (NSString *)roomId
{
    
}

- (void)insertChat: (Chat *)chat
{
    
}

- (void)insertChatRoom: (NSString *)roomId
{
    
}

- (void)insertChatRoomParticipant: (NSString *)roomId personId:(NSString *)personId
{
    
}

- (void)deleteChatRoomParticipant: (NSString *)roomId psersonId:(NSString *)personId
{
    
}

- (void)deleteChatRoom: (NSString *)roomId
{
    
}

@end
