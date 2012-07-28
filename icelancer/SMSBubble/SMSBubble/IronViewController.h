//
//  IronViewController.h
//  SMSBubble
//
//  Created by 광호 김 on 12. 7. 28..
//  Copyright (c) 2012년 sendtoghkim@gmail.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface IronViewController : UIViewController
    <UITableViewDelegate, UITableViewDataSource> 
{
    IBOutlet UITableView *tbl;
    NSMutableArray *messages;
}

@property (strong, nonatomic) UITableView *tbl;
@property (strong, nonatomic) NSMutableArray *messages;

@end
