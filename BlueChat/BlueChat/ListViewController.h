//
//  ListViewController.h
//  BlueChat
//
//  Created by Kyoungtaek Koo on 12. 7. 31..
//  Copyright (c) 2012년 NHN Map FE. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ListViewController : UIViewController
    <UITableViewDelegate, UITableViewDataSource>
{
    IBOutlet UITableView *tbl;
    NSMutableArray *messages;
}

@property (strong, nonatomic) UITableView *tbl;
@property (strong, nonatomic) NSMutableArray *messages;

@end
