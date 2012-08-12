//
//  ChatViewController.h
//  BlueChat
//
//  Created by Kyoungtaek Koo on 12. 7. 31..
//  Copyright (c) 2012년 NHN Map FE. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ChatViewController;

@protocol ChatViewControllerDelegate <NSObject>
  
- (void)chatViewController:(ChatViewController *)controller startChatWithSession:(GKSession *)session playerName:(NSString *)name clients:(NSArray *)clients;

@end


@interface ChatViewController : UIViewController
    <UITableViewDelegate, UITableViewDataSource>
{
    IBOutlet UITableView *tbl;
    IBOutlet UIToolbar *toolbar;
    IBOutlet UITextField *field;
    NSMutableArray *messages;
}

@property (strong, nonatomic) id <ChatViewControllerDelegate> delegate;


@property (strong, nonatomic) UITableView *tbl;
@property (strong, nonatomic) UIToolbar *toolbar;
@property (strong, nonatomic) UITextField *field;
@property (strong, nonatomic) NSMutableArray *messages;

@end
