//
//  MainViewController.m
//  BlueChat
//
//  Created by Kyoungtaek Koo on 12. 7. 31..
//  Copyright (c) 2012년 NHN Map FE. All rights reserved.
//

#import "MainViewController.h"
#import "ServerTableViewController.h"
#import "ClientTableViewController.h"
#import "ChatViewController.h"
#import "Chat.h"


@interface MainViewController ()

@end

@implementation MainViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
//        [self.tabBar setBackgroundImage:[UIImage imageNamed:@"tabbar_02.png"]];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


#pragma mark - Misc

- (void)startChattingWithBlock:(void (^)(Chat *))block
{
	ChatViewController *chatViewController = [[ChatViewController alloc] initWithNibName:@"ChatViewController" bundle:nil];
	chatViewController.delegate = self;
    
	[self presentViewController:chatViewController animated:NO completion:^
     {/*
         Chat *chat = [[Chat alloc] init];
         chatViewController.chat = chat;
         chat.delegate = chatViewController;
         block(chat);*/
     }];
}

              
#pragma mark - Delloc
              
              - (void)dealloc
    {
#ifdef DEBUG
        NSLog(@"dealloc %@", self);
#endif
    }
              

@end
