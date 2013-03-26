//
//  YouTubeTableViewController.h
//  YouTubePlayer
//
//  Created by Istvan Szabo on 2012.08.08..
//  Copyright (c) 2012 Istvan Szabo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MediaPlayer/MediaPlayer.h>
#import "LBYouTubeExtractor.h"


@interface YouTubeTableViewController : UITableViewController

@property (nonatomic, strong) NSArray *ytvideosPlist;
@property (nonatomic, strong) NSDictionary *youtubePlist;
@property (strong, nonatomic) IBOutlet UIImageView *headerImage;
@property (strong, nonatomic) IBOutlet UILabel *headerTitle;
@property (nonatomic, strong) MPMoviePlayerViewController* controller;
@property (nonatomic, strong) LBYouTubeExtractor *extractor;
@property (nonatomic) BOOL highQuality;

- (void)loadYouTubeURL:(NSURL *)URL;
- (void)loadYouTubeVideoWithID:(NSString *)videoID;
- (void)_didSuccessfullyExtractYouTubeURL:(NSURL*)videoURL;
- (void)_failedExtractingYouTubeURLWithError:(NSError*)error;

- (IBAction)playButton:(id)sender;
- (IBAction)refreshButton:(id)sender;

@end
