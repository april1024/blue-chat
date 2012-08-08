//
//  Chat.h
//  BlueChat
//
//  Created by Lee TaeHwan on 8/8/12.
//  Copyright (c) 2012 NHN Map FE. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MessageType.h"

@interface Chat : NSObject{
    NSString *chatRoomId;
    NSString *personId;
    NSString *message;
    NSDate *date;
    MessageType messageType;
}

@property (strong, nonatomic) NSString *chatRoomId;
@property (strong, nonatomic) NSString *personId;
@property (strong, nonatomic) NSString *message;
@property (strong, nonatomic) NSDate *date;
@property (nonatomic) MessageType messageType;

@end
