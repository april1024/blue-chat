//
//  ChatRoom.h
//  BlueChat
//
//  Created by Lee TaeHwan on 8/8/12.
//  Copyright (c) 2012 NHN Map FE. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ChatRoom : NSObject{
    NSString *id;
    NSDate *created;
    NSMutableArray *participantList;
}

@property (strong, nonatomic) NSString *id;
@property (strong, nonatomic) NSDate *created;
@property (strong, nonatomic) NSMutableArray *participantList;

@end
