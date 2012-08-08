//
//  ClientTableViewController.m
//  BlueChat
//
//  Created by 김광호 on 12. 8. 6..
//  Created by SUMIN LIM on 12. 8. 6..
//  Copyright (c) 2012년 NHN Map FE. All rights reserved.
//

#import "ClientTableViewController.h"
#import "Server.h"
@interface ClientTableViewController ()
@property (nonatomic, weak) IBOutlet UITableView *tableView;
@property (nonatomic, weak) IBOutlet UIButton *startButton; 
@end



@implementation ClientTableViewController
{
	Server *_server;
    QuitReason _quitReason;
}
 
@synthesize tableView = _tableView;
@synthesize delegate = _delegate;
@synthesize startButton = _startButton;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (IBAction)close:(id)sender
{
    [self dismissModalViewControllerAnimated:YES];
}
- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if (_server == nil)
	{
		_server = [[Server alloc] init];
		_server.maxClients = 3;
        _server.delegate = self;
		[_server startAcceptingConnectionsForSessionID:SESSION_ID];
        NSLog(@"Me: %@", _server.session.displayName);
		[self.tableView reloadData];
	}
 
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}



- (IBAction)startAction:(id)sender
{
	if (_server != nil && [_server connectedClientCount] > 0)
	{
		NSString *name = _server.session.displayName;
        
		[_server stopAcceptingConnections];
        
		[self.delegate clientTableViewController:self startChattingWithSession:_server.session playerName:name clients:_server.connectedClients];
	}
}



#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    return 1;
    
}
- (IBAction)exitAction:(id)sender
{
	_quitReason = QuitReasonUserQuit;
	[_server endSession];
	[self.delegate clientTableViewControllerDidCancel:self];
}


#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
	if (_server != nil)
		return [_server connectedClientCount];
	else
		return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{static NSString *CellIdentifier = @"Cell";
    
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
		cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    
	NSString *peerID = [_server peerIDForConnectedClientAtIndex:indexPath.row];
	cell.textLabel.text = [_server displayNameForPeerID:peerID];
    
	return cell;
   }
#pragma mark - ServerDelegate

- (void)server:(Server *)server clientDidConnect:(NSString *)peerID
{
    NSLog(@"clientDIDConnected");
	[self.tableView reloadData];
}

- (void)server:(Server *)server clientDidDisconnect:(NSString *)peerID
{
     NSLog(@"clientDIDDisConnected");
	[self.tableView reloadData];
}

- (void)serverSessionDidEnd:(Server *)server
{NSLog(@"serverSessionDidEnd");
	_server.delegate = nil;
	_server = nil;
	[self.tableView reloadData];
	[self.delegate clientTableViewController:self didEndSessionWithReason:_quitReason];
}

- (void)serverNoNetwork:(Server *)session
{
    NSLog(@"serverNoNetwork");
	_quitReason = QuitReasonNoNetwork;
}
 

@end
