//
//  IronViewController.m
//  SMSBubble
//
//  Created by 광호 김 on 12. 7. 28..
//  Copyright (c) 2012년 sendtoghkim@gmail.com. All rights reserved.
//

#import "IronViewController.h"
#import "IronMessageTableCell.h"

@interface IronViewController ()

@end

@implementation IronViewController

@synthesize tbl, messages;

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"BlueChat";
    messages = [[NSMutableArray alloc] initWithObjects:@"오늘 야근ㅠㅠ", @"헐...진짜?",
                @"ㄴㅇ러민아ㅓ림나어리ㅏㅁ누이파ㅜㅁ니아푸미;나ㅜㅇ피ㅏㅜㄴㅁ이ㅏ푼미우피나ㅜㅇ핀무이푼밍품니우핌눙핌나ㅜ이파ㅜㄴㅁ이ㅏ품니ㅏ우피ㅏㅁㄴ우ㅏㅣ푸니ㅏㅇㅇㅇㅇㅇㅇㅇ우미나우핌나우피ㅏㅁ누이파누이ㅏ푼미아ㅜ피나우핀마ㅜㅇ피ㅏ눔이ㅏ푼미ㅏ우핀뭉피ㅏ눔이푸닝푸니우핌우\n멘붕!!!",
                @"ㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋ",
                @"웃지마라..ㅡㅡ^",nil];

    tbl.backgroundColor = [UIColor colorWithRed:219.0/255.0 green:226.0/255.0 blue:237.0/255.0 alpha:1.0];

    
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}

- (UITableViewCell *) tableView:(UITableView *)tableView 
          cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    IronMessageTableCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[IronMessageTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    } else {
        cell.balloonView = (UIImageView *)[[cell.contentView viewWithTag:0] viewWithTag:1];
        cell.label = (UILabel *)[[cell.contentView viewWithTag:0] viewWithTag:2];
        cell.senderView = (UIImageView *)[[cell.contentView viewWithTag:0] viewWithTag:3];
    }
    
    NSString *text = [messages objectAtIndex:indexPath.row];
    CGSize size = [text sizeWithFont:[UIFont systemFontOfSize:14.0] constrainedToSize:CGSizeMake(240.0f, 480.0f) lineBreakMode:UILineBreakModeWordWrap];
    
    //TODO 말한 사람이 누군지에 따라 분기하도록 수정할 것
    UIImage *balloon;
    
    
    if (indexPath.row % 2 == 0) {
        cell.senderView.image = nil;
        cell.balloonView.frame = CGRectMake(320.0f - (size.width + 28.0f), 10.0f, size.width + 28.0f, size.height + 15.0f);
        balloon = [[UIImage imageNamed:@"green.png"] stretchableImageWithLeftCapWidth:24 topCapHeight:15];
        cell.label.frame = CGRectMake(307.0f - (size.width + 5.0f), 16.0f, size.width + 5.0f, size.height);
    } else {
        UIImage *sender = [UIImage imageNamed:@"imgres.jpeg"];
        cell.senderView.frame = CGRectMake(0, size.height - 20, 40, 40);
        cell.senderView.image = sender;
        cell.balloonView.frame = CGRectMake(40, 10.0f, size.width + 28.0f, size.height + 15);
        balloon = [[UIImage imageNamed:@"grey.png"] stretchableImageWithLeftCapWidth:24 topCapHeight:15];
		cell.label.frame = CGRectMake(16 + 40, 16, size.width + 5, size.height);
    }
    
    cell.balloonView.image = balloon;
    cell.label.text = text;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *body = [messages objectAtIndex:indexPath.row];
	CGSize size = [body sizeWithFont:[UIFont systemFontOfSize:14.0] constrainedToSize:CGSizeMake(240.0, 480.0) lineBreakMode:UILineBreakModeWordWrap];
	return size.height + 22;
}
@end
