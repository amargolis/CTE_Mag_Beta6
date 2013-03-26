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
@synthesize scrollView = _scrollView;
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
    
    self.scrollView.contentSize = CGSizeMake(320, 1000);

    ///Article Title Label
    // Create label
    UILabel *label =  [[UILabel alloc] initWithFrame:CGRectZero];
    label.text = artList.ARTICLE_TITLE;
    [self.view addSubview:label];
    // Resize Label
    label.font = [UIFont fontWithName:@"Optima-Bold" size:18];
    CGSize constraintSize = CGSizeMake(label.frame.size.width,40);
    CGSize labelSize = [label.text sizeWithFont:label.font constrainedToSize:constraintSize lineBreakMode:NSLineBreakByWordWrapping];
    label.frame = CGRectMake(10, label.frame.origin.y, 300, labelSize.height);
    [label setNumberOfLines:0];
    
    ///Article Author Label
    // Create label
    UILabel *label2 =  [[UILabel alloc] initWithFrame:CGRectZero];
    label2.text = artList.ARTICLE_AUTHOR;
    [self.view addSubview:label2];
    // Resize Label
    label2.font = [UIFont fontWithName:@"Optima" size:15];
    CGSize constraintSize2 = CGSizeMake(label2.frame.size.width,CGFLOAT_MAX);
    CGSize label2Size = [label2.text sizeWithFont:label2.font constrainedToSize:constraintSize2 lineBreakMode:NSLineBreakByWordWrapping];
    label2.frame = CGRectMake(10, label.frame.origin.y + label.bounds.size.height, 300,label2Size.height);
    [label2 setNumberOfLines:0];
    [label2 sizeToFit];
    
    ///Article Date Label
    // Create label
    UILabel *label3 =  [[UILabel alloc] initWithFrame:CGRectZero];
    label3.text = artList.ARTICLE_DATE;
    [self.view addSubview:label3];
    // Resize Label
    label3.font = [UIFont fontWithName:@"Optima" size:12];
    CGSize constraintSize3 = CGSizeMake(label3.frame.size.width,CGFLOAT_MAX);
    CGSize label3Size = [label3.text sizeWithFont:label3.font constrainedToSize:constraintSize3 lineBreakMode:NSLineBreakByWordWrapping];
    label3.frame = CGRectMake(10, label2.frame.origin.y + label2.bounds.size.height, 300,label3Size.height);
    [label3 setNumberOfLines:0];
    [label3 sizeToFit];
    
    ///Article Volume Info Label
    // Create label
    UILabel *label4 =  [[UILabel alloc] initWithFrame:CGRectZero];
    label4.text = artList.ARTICLE_PAGE;
    [self.scrollView addSubview:label4];
    // Resize Label
    label4.font = [UIFont fontWithName:@"Optima" size:12];
    CGSize constraintSize4 = CGSizeMake(label4.frame.size.width,30);
    CGSize label4Size = [label4.text sizeWithFont:label4.font constrainedToSize:constraintSize4 lineBreakMode:NSLineBreakByWordWrapping];
    label4.frame = CGRectMake(10, label3.frame.origin.y + label3.bounds.size.height, 300,label4Size.height);
    [label4 setNumberOfLines:0];
    
    ///Article Description Label
    // Create label
    UILabel *label5 =  [[UILabel alloc] initWithFrame:CGRectZero];
    label5.text = artList.ARTICLE_DESCRIPTION;
    [self.view addSubview:label5];
    // Resize Label
    label5.font = [UIFont fontWithName:@"Optima" size:17];
    CGSize constraintSize5 = CGSizeMake(label5.frame.size.width,CGFLOAT_MAX);
    CGSize label5Size = [label5.text sizeWithFont:label5.font constrainedToSize:constraintSize5 lineBreakMode:NSLineBreakByWordWrapping];
    label5.frame = CGRectMake(10, label4.frame.origin.y + label4.bounds.size.height, 300,label5Size.height);
    [label5 setNumberOfLines:0];
    [label5 sizeToFit];
    
    //CGFloat height = 0;
    //for(UIView* sub in myScrollView.subviews)
        //height += sub.frame.size.height
        
        //myScrollView.contentSize = CGSizeMake(self.contentSize.width, height)
     
}


@end