//
//  ClientTableViewController.h
//  BlueChat
//
//  Created by 김광호 on 12. 8. 6..
// Modified by Sumin Lim 12. 8. 8.. 
//  Copyright (c) 2012년 NHN Map FE. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Server.h"

@class ClientTableViewController;

@protocol ClientTableViewControllerDelegate <NSObject>

- (void)clientTableViewControllerDidCancel:(ClientTableViewController *)controller;
- (void)clientTableViewController:(ClientTableViewController *)controller didEndSessionWithReason:(QuitReason)reason;
- (void)clientTableViewController:(ClientTableViewController *)controller startChattingWithSession:(GKSession *)session playerName:(NSString *)name clients:(NSArray *)clients;
@end

@interface ClientTableViewController : UITableViewController<UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate, ServerDelegate>
@property (nonatomic, weak) id <ClientTableViewControllerDelegate> delegate;
 - (IBAction)close:(id)sender;


@end