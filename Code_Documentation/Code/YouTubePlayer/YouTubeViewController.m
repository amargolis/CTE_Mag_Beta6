//
//  YouTubeViewController.m
//  YouTubePlayer
//
//  Created by Istvan Szabo on 2012.08.08..
//  Copyright (c) 2012 Istvan Szabo. All rights reserved.
//

#import "YouTubeViewController.h"
#import <AVFoundation/AVFoundation.h>
#import <AudioToolbox/AudioToolbox.h>
#import "Reachability.h"

#define YOUTUBE_VIDEO_ID @"czWMh3LwtAc"


@interface YouTubeViewController ()

@end

@interface YouTubeViewController ()

@end

@implementation YouTubeViewController

@synthesize extractor = extractor_;
@synthesize controller, highQuality;



- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    
}

- (void)viewDidUnload
{
    [self setController:nil];
    [self setExtractor:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}


-(void)dealloc {
    
    self.extractor.completionHandler = nil;
    [self.extractor cancel];
}

-(void)_loadVideoWithContentOfURL:(NSURL *)videoURL {
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    
    self.controller = [[MPMoviePlayerViewController alloc] initWithContentURL:videoURL];
    [self presentMoviePlayerViewControllerAnimated:controller];
    
    controller.moviePlayer.allowsAirPlay = YES;
    
    AVAudioSession *audioSession = [AVAudioSession sharedInstance];
    
    NSError *setCategoryError = nil;
    [audioSession setCategory:AVAudioSessionCategoryPlayback error:&setCategoryError];
    if (setCategoryError) { /* handle the error condition */ }
    
    NSError *activationError = nil;
    [audioSession setActive:YES error:&activationError];
    if (activationError) { /* handle the error condition */ }
    
}

-(void)loadYouTubeVideoWithID:(NSString*)videoID {
    [self loadYouTubeURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://www.youtube.com/watch?v=%@", videoID]]];
}

- (IBAction)playButton:(id)sender {
    
    Reachability *reachability = [Reachability reachabilityForInternetConnection];
    [reachability startNotifier];
    
    NetworkStatus status = [reachability currentReachabilityStatus];
    
    if (status == ReachableViaWiFi)
    {
        self.highQuality = YES;
    }
    else if (status == ReachableViaWWAN)
    {
        self.highQuality = NO;
    }
    [self loadYouTubeVideoWithID:YOUTUBE_VIDEO_ID];
    
}

-(void)loadYouTubeURL:(NSURL *)URL {
    
    if (self.extractor == nil) {
        self.extractor = [LBYouTubeExtractor new];
        __unsafe_unretained YouTubeViewController *weakSelf = self;
        self.extractor.completionHandler = ^(NSURL *extractedURL, NSError *error)
        {
            if (extractedURL) {
                [weakSelf _didSuccessfullyExtractYouTubeURL:extractedURL];
                [weakSelf _loadVideoWithContentOfURL:extractedURL];
            }
            else {
                [weakSelf _failedExtractingYouTubeURLWithError:error];
            }
        };
    }
    else {
        [self.extractor cancel];
    }
    
    self.extractor.youTubeURL = URL;
    self.extractor.highQuality = self.highQuality;
    
    [self.extractor start];
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;    
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


-(void)_didSuccessfullyExtractYouTubeURL:(NSURL *)videoURL {
    /* Succesfully extract */}

-(void)_failedExtractingYouTubeURLWithError:(NSError *)error {
    /* Error */
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    if ([[Reachability reachabilityForInternetConnection] currentReachabilityStatus] == NotReachable) {
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"No Internet Connection" message:@"You must have an active network connection in order to watch CTE Videos" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        
        [alert show];
    }
    
}



@end
