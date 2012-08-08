//
//  MainViewController.h
//  BlueChat
//
//  Created by Kyoungtaek Koo on 12. 7. 31..
//  Copyright (c) 2012년 NHN Map FE. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ClientTableViewController.h"
#import "ServerTableViewController.h"

@interface MainViewController : UITabBarController
<ClientTableViewControllerDelegate, ServerTableViewControllerDelegate>
@end
