//
//  SecondNavDetailViewController.m
//  CTE_Mag_Beta6
//
//  Created by Andy Margolis on 3/4/13.
//  Copyright (c) 2013 Northshore Technology Services. All rights reserved.
//

#import "SecondNavDetailViewController.h"

@interface SecondNavDetailViewController ()

@end

@implementation SecondNavDetailViewController

@synthesize headList;

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
    
    content.text = headList.content;
    
    dateadded.text = headList.dateadded;
    
    url.text = headList.url;
    
    //id.text = headList.id;
    
    content.numberOfLines = 0;
    [content sizeToFit];
    
}

@end
