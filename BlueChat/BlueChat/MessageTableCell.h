//
//  MessageTableCell.h
//  BlueChat
//
//  Created by 김광호 on 12. 7. 31..
//  Copyright (c) 2012년 NHN Map FE. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MessageTableCell : UITableViewCell
{
    UIImageView *balloonView;
    UIImageView *senderView;
    UILabel *label;
}

@property (strong, nonatomic) UILabel *label;
@property (strong, nonatomic) UIImageView *balloonView;
@property (strong, nonatomic) UIImageView *senderView;
@end
