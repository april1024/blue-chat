//
//  IronViewController.m
//  BluetoothTest
//
//  Created by 광호 김 on 12. 7. 15..
//  Copyright (c) 2012년 sendtoghkim@gmail.com. All rights reserved.
//

#import "IronViewController.h"


@implementation IronViewController

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    GKPeerPickerController *picker = [[GKPeerPickerController alloc] init];
    picker.delegate = self;
    picker.connectionTypesMask = GKPeerPickerConnectionTypeNearby ;
    [picker show];
}

- (void) peerPickerController: (GKPeerPickerController *)picker didSelectConnectionType:(GKPeerPickerConnectionType)type
{
    if (type == GKPeerPickerConnectionTypeOnline) {
        picker.delegate = nil;
        [picker dismiss];
        //Implement your own interner user interface here.
    }
}

- (void) session:(GKSession *)session peer:(NSString *)peerID didChangeState:(GKPeerConnectionState)state
{
    switch (state) {
        case GKPeerStateConnected:
            NSLog(@"sdfsdf- connected");
            break;
        case GKPeerStateDisconnected:
            NSLog(@"Disconnected");
            break;
        default:
            break;
    }
    
    return;
}

- (void)peerPickerController: (GKPeerPickerController *)picker didConnectPeer:(NSString *)peerID toSession:(GKSession *)session 
{
    peerSession = session;
    [picker dismiss];
}

- (IBAction)sendData:(id)sender
{
    [self sendMusic];
}

- (void) sendMusic
{
    NSInputStream *inputStream = [NSInputStream inputStreamWithFileAtPath:@"16 The Thorny One.mp3"];
    [inputStream open];
    
    Byte buffer[2048];
    while ([inputStream hasBytesAvailable])
    {
        int bytesRead = [inputStream read:buffer maxLength:2048];
        NSData *myData = [NSData dataWithBytes:buffer length:bytesRead];
        [peerSession sendDataToAllPeers:myData withDataMode:GKSendDataReliable error:nil];
    }

}

- (void) receiveData:(NSData *)data fromPeer:(NSString *)peer inSession: (GKSession *)session context:(void *)context
{
    NSLog(@"received");

}

@end
