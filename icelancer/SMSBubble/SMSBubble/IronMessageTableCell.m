//
//  IronMessageTableCell.m
//  SMSBubble
//
//  Created by 광호 김 on 12. 7. 28..
//  Copyright (c) 2012년 sendtoghkim@gmail.com. All rights reserved.
//

#import "IronMessageTableCell.h"

@implementation IronMessageTableCell

@synthesize label, balloonView, senderView;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        senderView = [[UIImageView alloc] initWithFrame:CGRectZero];
        senderView.tag = 3;
        
        balloonView = [[UIImageView alloc] initWithFrame:CGRectZero];
        balloonView.tag = 1;
        
        label = [[UILabel alloc] initWithFrame:CGRectZero];
        label.backgroundColor = [UIColor clearColor];
        label.tag = 2;
        label.numberOfLines = 0;
        label.lineBreakMode = UILineBreakModeWordWrap;
        label.font = [UIFont systemFontOfSize:14.0];
        
        UIView *message = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, 
            self.frame.size.width, self.frame.size.height)];
        message.tag = 0;
        
        [message addSubview:senderView];
        [message addSubview:balloonView];
        [message addSubview:label];
        [self.contentView addSubview:message];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void) dealloc
{
    balloonView = nil;
    label = nil;
}

@end
