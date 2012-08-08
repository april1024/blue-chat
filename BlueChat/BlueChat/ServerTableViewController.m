//
//  ServerTableViewController.m
//  BlueChat
//
//  Created by SUMIN LIM on 12. 8. 7..
//  Copyright (c) 2012년 NHN Map FE. All rights reserved.
//

#import "ServerTableViewController.h"
#import "Client.h"

@interface ServerTableViewController ()
@property (nonatomic, weak) IBOutlet UITableView *tableView;
@end

@implementation ServerTableViewController{
    Client *_client;
    QuitReason _quitReason;
}

@synthesize delegate = _delegate;
@synthesize tableView = _tableView;

- (IBAction)close:(id)sender
{
    [self dismissModalViewControllerAnimated:YES];
}

- (IBAction)exitAction:(id)sender
{
	_quitReason = QuitReasonUserQuit;
	[_client disconnectFromServer];
	[self.delegate serverTableViewControllerDidCancel:self];
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
    NSLog(@"LOAD Client's View");
    if (_client == nil)
	{
        _quitReason = QuitReasonConnectionDropped;
        
		_client = [[Client alloc] init];
        _client.delegate = self;
		[_client startSearchingForServersWithSessionID:SESSION_ID];
         
        
		NSLog(@"%@", _client.session.displayName);
		[self.tableView reloadData];
	}

    
    
    
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
 

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	[tableView deselectRowAtIndexPath:indexPath animated:YES];
    
	if (_client != nil)
	{
        
		NSString *peerID = [_client peerIDForAvailableServerAtIndex:indexPath.row];
		[_client connectToServerWithPeerID:peerID];
        NSLog(@"== Your PeerID is : %@", peerID);
    }
}



#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	if (_client != nil)
		return [_client availableServerCount];
	else
		return 0;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	static NSString *CellIdentifier = @"Cell";
    
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
	if (cell == nil)
		cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    
	NSString *peerID = [_client peerIDForAvailableServerAtIndex:indexPath.row];
    cell.textLabel.text = [_client displayNameForPeerID:peerID];
    
	return cell;
}


#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
	[textField resignFirstResponder];
	return NO;
}


#pragma mark - ClientDelegate

- (void)client:(Client *)client serverBecameAvailable:(NSString *)peerID
{
	[self.tableView reloadData];
}

- (void)client:(Client *)client serverBecameUnavailable:(NSString *)peerID
{
	[self.tableView reloadData];
}

- (void)client:(Client *)client didDisconnectFromServer:(NSString *)peerID
{
	_client.delegate = nil;
	_client = nil;
	[self.tableView reloadData];
	[self.delegate serverTableViewController:self didDisconnectWithReason:_quitReason];
}

- (void)client:(Client *)client didConnectToServer:(NSString *)peerID
{
    //To set name, describe here...sumin lim TODO
    
    NSString *name = _client.session.displayName;
	[self.delegate serverTableViewController:self startChattingWithSession:_client.session playerName:name server:peerID];

  }

- (void)clientNoNetwork:(Client *)client
{
	_quitReason = QuitReasonNoNetwork;
}


@end
