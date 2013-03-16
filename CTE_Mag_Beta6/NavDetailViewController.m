//
//  NavDetailViewController.m
//  CTE_Mag_Beta6
//
//  Created by Andy Margolis on 3/4/13.
//  Copyright (c) 2013 Northshore Technology Services. All rights reserved.
//

#import "NavDetailViewController.h"

#import "SVWebViewController.h"

#import "NavigationViewController.h"

@interface NavDetailViewController ()
@end

@implementation NavDetailViewController
@synthesize artList;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {

    }
    return self;
}

- (void)presentWebViewController {
    NSString *urlString=
    [NSString stringWithFormat:@"http://www.ctemag.com/aa_pages/2013/%@",[artList.STATIC_WEBPAGE stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
	NSURL *URL = [NSURL URLWithString:urlString];
	SVModalWebViewController *webViewController = [[SVModalWebViewController alloc] initWithURL:URL];
	webViewController.modalPresentationStyle = UIModalPresentationPageSheet;
    webViewController.availableActions = SVWebViewControllerAvailableActionsOpenInSafari | SVWebViewControllerAvailableActionsOpenInChrome | SVWebViewControllerAvailableActionsCopyLink | SVWebViewControllerAvailableActionsMailLink;
    [self presentViewController:webViewController animated:YES completion:nil];

}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    ARTICLE_TITLE.text = artList.ARTICLE_TITLE;
    
    ARTICLE_AUTHOR.text = artList.ARTICLE_AUTHOR;
    
    ARTICLE_DATE.text = artList.ARTICLE_DATE;
    
    ARTICLE_PAGE.text = artList.ARTICLE_PAGE;
    
    ARTICLE_DESCRIPTION.text = artList.ARTICLE_DESCRIPTION;
    
    STATIC_WEBPAGE.text = artList.STATIC_WEBPAGE;
    
    ARTICLE_ID.text = artList.ARTICLE_ID;
    
    ARTICLE_TITLE.numberOfLines = 0;
    [ARTICLE_TITLE sizeToFit];
    
    ARTICLE_DESCRIPTION.numberOfLines = 0;
    [ARTICLE_DESCRIPTION sizeToFit];
    
    ARTICLE_AUTHOR.numberOfLines = 0;
    [ARTICLE_AUTHOR sizeToFit];
    

}


@end