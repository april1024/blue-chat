//
//  ServerTableViewController.h
//  BlueChat
//
//  Created by SUMIN LIM on 12. 8. 7..
//  Copyright (c) 2012년 NHN Map FE. All rights reserved.
//
#import "Client.h"
#import <Foundation/Foundation.h>

@class ServerTableViewController;

@protocol ServerTableViewControllerDelegate <NSObject>

- (void)serverTableViewControllerDidCancel:(ServerTableViewController *)controller;
- (void)serverTableViewController:(ServerTableViewController *)controller didDisconnectWithReason:(QuitReason)reason;
- (void)serverTableViewController:(ServerTableViewController *)controller startChattingWithSession:(GKSession *)session playerName:(NSString *)name server:(NSString *)peerID;

@end



@interface ServerTableViewController : UITableViewController<UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate, ClientDelegate>
@property (nonatomic, weak) id <ServerTableViewControllerDelegate> delegate;

- (IBAction)close:(id)sender;

@end
