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
    sqlite3_stmt *statement;
    const char *dbpath = [databasePath UTF8String];
    
    if (sqlite3_open(dbpath, &blueChatDB) == SQLITE_OK) {
        NSString *query = [NSString stringWithFormat:@"INSERT INTO Person (id, name) VALUES (\"%@\", \"%@\")", id, name];
        const char *sql_stmt = [query UTF8String];
        sqlite3_prepare_v2(blueChatDB, sql_stmt, -1, &statement, NULL);
        
        if (sqlite3_step(statement) == SQLITE_DONE) {
            NSLog(@"note added");
        } else {
            NSLog(@"Failed to add person");
        }
        
        sqlite3_finalize(statement);
        sqlite3_close(blueChatDB);
    } else {
        NSLog(@"Failed to open database");
    }
}

- (NSMutableArray *)selectChatRoomList
{
    const char *dbpath = [databasePath UTF8String];
    sqlite3_stmt *statement;
    NSMutableArray *chatRoomList = [[NSMutableArray alloc] init];
    
    if (sqlite3_open(dbpath, &blueChatDB) == SQLITE_OK) {
        NSString *query = [NSString stringWithFormat:@"SELECT id, created FROM ChatRoom"];
        
        const char *sql_stmt = [query UTF8String];
        
        if (sqlite3_prepare_v2(blueChatDB, sql_stmt, -1, &statement, NULL) == SQLITE_OK) {
            while (sqlite3_step(statement) == SQLITE_ROW) {
                NSString *id = [[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 0)];
                /**
                 *  TODO : date 처리
                 */
                NSDate *created = [NSDate dateWithTimeIntervalSince1970:sqlite3_column_double(statement, 1)];
                
                ChatRoom *chatRoom = [[ChatRoom alloc] init];
                chatRoom.id = id;
                chatRoom.created = created;
                
                [chatRoomList addObject:chatRoom];
            }
            
            sqlite3_finalize(statement);
        }
        
        sqlite3_close(blueChatDB);
    } else {
        NSLog(@"Failed to open database");
    }
    
    return chatRoomList;
}

- (NSMutableArray *)selectChatList: (NSString *)roomId
{
    const char *dbpath = [databasePath UTF8String];
    sqlite3_stmt *statement;
    NSMutableArray *chatList = [[NSMutableArray alloc] init];
    
    if (sqlite3_open(dbpath, &blueChatDB) == SQLITE_OK) {
        NSString *query = [NSString stringWithFormat:@"SELECT chatRoomId, personId, message, date, messageType FROM Chat WHERE chatRoomId = \"%@\"", roomId];
        
        const char *sql_stmt = [query UTF8String];
        
        if (sqlite3_prepare_v2(blueChatDB, sql_stmt, -1, &statement, NULL) == SQLITE_OK) {
            while (sqlite3_step(statement) == SQLITE_ROW) {
                NSString *chatRoomId = [[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 0)];
                NSString *personId = [[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 1)];
                NSString *message = [[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 2)];
                /**
                 *  TODO : date 처리
                 */
                NSDate *date = [NSDate dateWithTimeIntervalSince1970:sqlite3_column_double(statement, 3)];
                MessageType messageType = sqlite3_column_int(statement, 4);
                
                Chat *chat = [[Chat alloc] init];
                chat.chatRoomId = chatRoomId;
                chat.personId = personId;
                chat.message = message;
                chat.date = date;
                chat.messageType = messageType;
                
                [chatList addObject:chat];
            }
            
            sqlite3_finalize(statement);
        }
        
        sqlite3_close(blueChatDB);
    } else {
        NSLog(@"Failed to open database");
    }
    
    return chatList;
}

- (void)insertChat: (Chat *)chat
{
    sqlite3_stmt *statement;
    const char *dbpath = [databasePath UTF8String];
    
    if (sqlite3_open(dbpath, &blueChatDB) == SQLITE_OK) {
        /**
         *  TODO : date 처리
         */
        NSString *query = [NSString stringWithFormat:@"INSERT INTO Chat (chatRoomId, personId, message, date, messageType) VALUES (\"%@\", \"%@\", \"%@\", \"%@\", \"%d\")", chat.chatRoomId, chat.personId, chat.message, chat.date, chat.messageType];
        const char *sql_stmt = [query UTF8String];
        sqlite3_prepare_v2(blueChatDB, sql_stmt, -1, &statement, NULL);
        
        if (sqlite3_step(statement) == SQLITE_DONE) {
            NSLog(@"chat added");
        } else {
            NSLog(@"Failed to add chat");
        }
        
        sqlite3_finalize(statement);
        sqlite3_close(blueChatDB);
    } else {
        NSLog(@"Failed to open database");
    }
}

- (void)insertChatRoom: (NSString *)roomId
{
    sqlite3_stmt *statement;
    const char *dbpath = [databasePath UTF8String];
    
    if (sqlite3_open(dbpath, &blueChatDB) == SQLITE_OK) {
        /**
         *  TODO : date 처리
         */
        NSString *query = [NSString stringWithFormat:@"INSERT INTO ChatRoom (id, created) VALUES (\"%@\", DATETIME(\"NOW\"))", roomId];
        const char *sql_stmt = [query UTF8String];
        sqlite3_prepare_v2(blueChatDB, sql_stmt, -1, &statement, NULL);
        
        if (sqlite3_step(statement) == SQLITE_DONE) {
            NSLog(@"chatRoom added");
        } else {
            NSLog(@"Failed to add chatRoom");
        }
        
        sqlite3_finalize(statement);
        sqlite3_close(blueChatDB);
    } else {
        NSLog(@"Failed to open database");
    }
}

- (void)insertChatRoomParticipant: (NSString *)roomId personId:(NSString *)personId
{
    sqlite3_stmt *statement;
    const char *dbpath = [databasePath UTF8String];
    
    if (sqlite3_open(dbpath, &blueChatDB) == SQLITE_OK) {
        NSString *query = [NSString stringWithFormat:@"INSERT INTO ChatRoomParticipant (roomId, personId) VALUES (\"%@\", \"%@\")", roomId, personId];
        const char *sql_stmt = [query UTF8String];
        sqlite3_prepare_v2(blueChatDB, sql_stmt, -1, &statement, NULL);
        
        if (sqlite3_step(statement) == SQLITE_DONE) {
            NSLog(@"chatRoomParticipant added");
        } else {
            NSLog(@"Failed to add chatRoomParticipant");
        }
        
        sqlite3_finalize(statement);
        sqlite3_close(blueChatDB);
    } else {
        NSLog(@"Failed to open database");
    }
}

- (void)deleteChatRoomParticipant: (NSString *)roomId psersonId:(NSString *)personId
{
    const char *dbpath = [databasePath UTF8String];
    sqlite3_stmt *statement;
    
    if (sqlite3_open(dbpath, &blueChatDB) == SQLITE_OK) {
        NSString *querySql = [NSString stringWithFormat:@"DELETE FROM ChatRoomParticipant WHERE roomId = \"%@\" AND personId = \"%@\"", roomId, personId];
        
        const char *query_stmt = [querySql UTF8String];
        
        if (sqlite3_prepare_v2(blueChatDB, query_stmt, -1, &statement, NULL) == SQLITE_OK) {
            if (sqlite3_step(statement) != SQLITE_DONE) {
                NSLog(@"Error while deleting. '%s'", sqlite3_errmsg(blueChatDB));
            }
            
            sqlite3_finalize(statement);
        }
        
        sqlite3_close(blueChatDB);
    }
}

- (void)deleteChatRoom: (NSString *)roomId
{
    const char *dbpath = [databasePath UTF8String];
    sqlite3_stmt *statement;
    
    if (sqlite3_open(dbpath, &blueChatDB) == SQLITE_OK) {
        NSString *querySql = [NSString stringWithFormat:@"DELETE FROM ChatRoom WHERE roomId = \"%@\"", roomId];
        
        const char *query_stmt = [querySql UTF8String];
        
        if (sqlite3_prepare_v2(blueChatDB, query_stmt, -1, &statement, NULL) == SQLITE_OK) {
            if (sqlite3_step(statement) != SQLITE_DONE) {
                NSLog(@"Error while deleting. '%s'", sqlite3_errmsg(blueChatDB));
            }
            
            sqlite3_finalize(statement);
        }
        
        sqlite3_close(blueChatDB);
    }
}

@end
