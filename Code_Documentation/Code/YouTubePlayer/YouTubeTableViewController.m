//
//  YouTubeTableViewController.m
//  YouTubePlayer
//
//  Created by Istvan Szabo on 2012.08.08..
//  Copyright (c) 2012 Istvan Szabo. All rights reserved.
//

#import "YouTubeTableViewController.h"
#import "YouTubeCell.h"
#import <AVFoundation/AVFoundation.h>
#import <AudioToolbox/AudioToolbox.h>
#import "Reachability.h"
#import "UIImageView+WebCache.h"

#define URL_DATA @"https://dl.dropbox.com/u/71008334/YouTube.plist"

@interface YouTubeTableViewController () {
   
}
@end

@implementation YouTubeTableViewController
@synthesize headerImage;
@synthesize headerTitle;
@synthesize extractor = extractor_;
@synthesize controller, highQuality;
@synthesize youtubePlist;
@synthesize ytvideosPlist;

- (void)awakeFromNib
{
    [super awakeFromNib];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    
    self.youtubePlist = [NSDictionary dictionaryWithContentsOfURL:[NSURL URLWithString:URL_DATA]];
    self.ytvideosPlist = [youtubePlist objectForKey:@"YouTubeVideos"];
    self.headerTitle.text = [youtubePlist valueForKey:@"LatestTitle"];
    [headerImage.layer setBorderColor: [[UIColor grayColor] CGColor]];
    [headerImage.layer setBorderWidth: 1.0];
    [headerImage setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://i4.ytimg.com/vi/%@/mqdefault.jpg",[youtubePlist valueForKey:@"LatestVideoID"]]]
               placeholderImage:[UIImage imageNamed:@"thumbnail.png"]];
    
       
    // show in the status bar that network activity stop
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    
}

- (void)viewDidUnload
{
    [self setYoutubePlist:nil];
    [self setYtvideosPlist:nil];
    [self setController:nil];
    [self setExtractor:nil];
    [self setHeaderImage:nil];
    [self setHeaderTitle:nil];
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


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

-(void)loadYouTubeURL:(NSURL *)URL {
    
    if (self.extractor == nil) {
        self.extractor = [LBYouTubeExtractor new];
        __unsafe_unretained YouTubeTableViewController *weakSelf = self;
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

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [ytvideosPlist count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"CustomCell";
    
    YouTubeCell *cell = (YouTubeCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    
    
    NSDictionary *videoItem = [ytvideosPlist objectAtIndex:indexPath.row];
    
    cell.ytTitle.text =[videoItem valueForKey:@"Title"];
    cell.ytDuration.text =[videoItem valueForKey:@"Duration"];
    cell.ytAuthor.text =[videoItem valueForKey:@"Author"];
    
    
    [cell.ytThumbnail.layer setBorderColor: [[UIColor grayColor] CGColor]];
    [cell.ytThumbnail.layer setBorderWidth: 1.0];
    [cell.ytThumbnail setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://i4.ytimg.com/vi/%@/default.jpg",[videoItem valueForKey:@"VideoID"]]]
                placeholderImage:[UIImage imageNamed:@"thumbnail.png"]];
    
    
    return cell;
    
    
}


- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *videoItem = [ytvideosPlist objectAtIndex:indexPath.row];

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
    
    [self loadYouTubeVideoWithID:[videoItem valueForKey:@"VideoID"]];
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
}
*/

-(void)_didSuccessfullyExtractYouTubeURL:(NSURL *)videoURL {
    /* Succesfully extract */}

-(void)_failedExtractingYouTubeURLWithError:(NSError *)error {
    /* Error */
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
    
    [self loadYouTubeVideoWithID:[youtubePlist valueForKey:@"LatestVideoID"]];

}

- (IBAction)refreshButton:(id)sender {
    // show in the status bar that network activity is starting
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    [self performSelector:@selector(viewDidLoad) withObject:nil];
    [self.tableView reloadData];
    // show in the status bar that network activity stop
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
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
