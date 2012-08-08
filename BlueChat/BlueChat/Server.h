//
//  Server.h
//  BlueChat
//
//  Created by SUMIN LIM on 12. 8. 6..
//  Copyright (c) 2012년 NHN Map FE. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Server;

@protocol ServerDelegate <NSObject>

- (void)server:(Server *)server clientDidConnect:(NSString *)peerID;
- (void)server:(Server *)server clientDidDisconnect:(NSString *)peerID;
- (void)serverSessionDidEnd:(Server *)server;
- (void)serverNoNetwork:(Server *)server;

@end

@interface Server : NSObject <GKSessionDelegate>

@property (nonatomic, assign) int maxClients;
@property (nonatomic, strong, readonly) NSArray *connectedClients;
@property (nonatomic, strong, readonly) GKSession *session;
@property (nonatomic, weak) id <ServerDelegate> delegate;

- (void)endSession;
- (void)startAcceptingConnectionsForSessionID:(NSString *)sessionID;
- (NSUInteger)connectedClientCount;
- (NSString *)peerIDForConnectedClientAtIndex:(NSUInteger)index;
- (NSString *)displayNameForPeerID:(NSString *)peerID;
- (void)stopAcceptingConnections;

@end
