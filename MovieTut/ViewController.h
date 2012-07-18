//
//  ViewController.h
//  MovieTut
//
//  Created by 경택 구 on 12. 7. 18..
//  Copyright (c) 2012년 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MediaPlayer/MediaPlayer.h>

@interface ViewController : UIViewController

@property (strong, nonatomic) MPMoviePlayerController *moviePlayer;
@property (weak, nonatomic) IBOutlet UIButton *btnPlayMovie;

- (IBAction) playMovie;

@end
