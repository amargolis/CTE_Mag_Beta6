//
//  WebViewViewController.m
//  CTE_Mag_Beta6
//
//  Created by Andy Margolis on 3/4/13.
//  Copyright (c) 2013 Northshore Technology Services. All rights reserved.
//

#import "WebViewViewController.h"
#import "NavDetailViewController.h"

@interface WebViewViewController ()

@end

@implementation WebViewViewController

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
    // Do any additional setup after loading the view from its nib.
    
    NSString *urlAddress = @"http://www.ctemag.com/";
    urlAddress = [urlAddress stringByAppendingString:@"STATIC_WEBPAGE"];
    
    
    
    NSURL *url = [NSURL URLWithString:urlAddress];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
