//
//  ConversationStorage.h
//  BlueChat
//
//  Created by Lee TaeHwan on 8/8/12.
//  Copyright (c) 2012 NHN Map FE. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "/usr/include/sqlite3.h"
#import "Chat.h"
#import "ChatRoom.h"

#define SQLITE_FILE_NAME "blueChat.db"
#define DDL_FILE_NAME    "ddl.txt"

@interface ConversationStorage : NSObject{
    sqlite3 *blueChatDB;
    NSString *databasePath;
}

- (void)insertPerson: (NSString *)id name:(NSString *)name;
- (NSMutableArray *)selectChatRoomList;
- (NSMutableArray *)selectChatList: (NSString *)roomId;
- (void)insertChat: (Chat *)chat;
- (void)insertChatRoom: (NSString *)roomId;
- (void)insertChatRoomParticipant: (NSString *)roomId personId:(NSString *)personId;
- (void)deleteChatRoomParticipant: (NSString *)roomId psersonId:(NSString *)personId;
- (void)deleteChatRoom: (NSString *)roomId;

@end
