//
//  Client.h
//  BlueChat
//
//  Created by SUMIN LIM on 12. 8. 6..
//  Copyright (c) 2012년 NHN Map FE. All rights reserved.
//

@class Client;

@protocol ClientDelegate <NSObject>

- (void)client:(Client *)client serverBecameAvailable:(NSString *)peerID;
- (void)client:(Client *)client serverBecameUnavailable:(NSString *)peerID;
- (void)client:(Client *)client didDisconnectFromServer:(NSString *)peerID;
- (void)clientNoNetwork:(Client *)client;
- (void)client:(Client *)client didConnectToServer:(NSString *)peerID;

@end

@interface Client : NSObject <GKSessionDelegate>

@property (nonatomic, strong, readonly) NSArray *availableServers;
@property (nonatomic, strong, readonly) GKSession *session;
@property (nonatomic, weak) id <ClientDelegate> delegate;

- (void)startSearchingForServersWithSessionID:(NSString *)sessionID;
- (NSUInteger)availableServerCount;
- (NSString *)peerIDForAvailableServerAtIndex:(NSUInteger)index;
- (NSString *)displayNameForPeerID:(NSString *)peerID;
- (void)connectToServerWithPeerID:(NSString *)peerID;
- (void)disconnectFromServer;

@end
