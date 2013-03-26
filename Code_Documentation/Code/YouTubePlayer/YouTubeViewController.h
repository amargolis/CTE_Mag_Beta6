//
//  YouTubeViewController.h
//  YouTubePlayer
//
//  Created by Istvan Szabo on 2012.08.08..
//  Copyright (c) 2012 Istvan Szabo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MediaPlayer/MediaPlayer.h>
#import "LBYouTubeExtractor.h"

@interface YouTubeViewController : UIViewController

@property (nonatomic, strong) MPMoviePlayerViewController* controller;
@property (nonatomic, strong) LBYouTubeExtractor *extractor;
@property (nonatomic) BOOL highQuality;

- (IBAction)playButton:(id)sender;

- (void)loadYouTubeURL:(NSURL *)URL;
- (void)loadYouTubeVideoWithID:(NSString *)videoID;
- (void)_didSuccessfullyExtractYouTubeURL:(NSURL*)videoURL;
- (void)_failedExtractingYouTubeURLWithError:(NSError*)error;


@end
