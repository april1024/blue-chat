//
//  ViewController.m
//  MovieTut
//
//  Created by 경택 구 on 12. 7. 18..
//  Copyright (c) 2012년 __MyCompanyName__. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

@synthesize moviePlayer = _moviePlayer;
@synthesize btnPlayMovie = _btnPlayMovie;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidUnload
{
    [self setBtnPlayMovie:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

- (void)playMovie
{
    if(_moviePlayer == nil){
        NSURL *url = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"IMG_1045" ofType:@"MOV"]];
    //    NSURL *url = [NSURL URLWithString:@"http://www.ebookfrenzy.com/ios_book/movie/movie.mov"];
        _moviePlayer = [[MPMoviePlayerController alloc] initWithContentURL:url];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(moviePlayBackDidFinish:) name:MPMoviePlayerPlaybackDidFinishNotification object:_moviePlayer];

        [_moviePlayer.view setFrame:CGRectMake(38, 100, 250, 163)];
    //     [_moviePlayer setFullscreen:YES animated:YES];
        _moviePlayer.scalingMode = MPMovieScalingModeFill;

         _moviePlayer.controlStyle = MPMovieControlStyleEmbedded;

//         _moviePlayer.shouldAutoplay = YES;
         [self.view addSubview:_moviePlayer.view];
    }

    
    if(_moviePlayer.playbackState != MPMoviePlaybackStatePlaying){
        [_moviePlayer play];
//        _btnPlayMovie.titleLabel.text = @"Stop Movie";
        [self setPlayButtonTitle:[NSString stringWithString:@"Stop Movie"]];
    }else{
        [_moviePlayer pause];
        [self setPlayButtonTitle:[NSString stringWithString:@"Resume Movie"]];
    }

}

     
- (void)moviePlayBackDidFinish:(NSNotification *)notification
{
    MPMoviePlayerController *player = [notification object];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:MPMoviePlayerPlaybackDidFinishNotification object:player];
    
    if([player respondsToSelector:@selector(setFullscreen:animated:)]){
        [player.view removeFromSuperview];
        _moviePlayer = nil;
        [self setPlayButtonTitle:[NSString stringWithString:@"Play Movie"]];
    }
}

- (void)setPlayButtonTitle:(NSString *)title
{
    [_btnPlayMovie setTitle:title forState:UIControlStateNormal];
    [_btnPlayMovie setTitle:title forState:UIControlStateSelected];
    [_btnPlayMovie setTitle:title forState:UIControlStateHighlighted];
}

@end
