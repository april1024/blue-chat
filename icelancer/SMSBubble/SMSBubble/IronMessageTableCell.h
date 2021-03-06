//
//  IronMessageTableCell.h
//  SMSBubble
//
//  Created by 광호 김 on 12. 7. 28..
//  Copyright (c) 2012년 sendtoghkim@gmail.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface IronMessageTableCell : UITableViewCell
{
    UIImageView *balloonView;
    UIImageView *senderView;
    UILabel *label;
}

@property (strong, nonatomic) UILabel *label;
@property (strong, nonatomic) UIImageView *balloonView;
@property (strong, nonatomic) UIImageView *senderView;

@end
