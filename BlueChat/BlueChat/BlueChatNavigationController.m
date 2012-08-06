//
//  BlueChatNavigationController.m
//  BlueChat
//
//  Created by Kyoungtaek Koo on 12. 8. 6..
//  Copyright (c) 2012년 NHN Map FE. All rights reserved.
//

#import "BlueChatNavigationController.h"

@interface BlueChatNavigationController ()

@end

@implementation BlueChatNavigationController

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
        [self.navigationBar setBackgroundImage:[UIImage imageNamed:@"navigation_bar.png"] forBarMetrics:UIBarMetricsDefault];
        [self.navigationBar.backItem.backBarButtonItem setBackButtonBackgroundImage:[UIImage imageNamed:@"navigation_02_btn_01_tab.png"] forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
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

@end
