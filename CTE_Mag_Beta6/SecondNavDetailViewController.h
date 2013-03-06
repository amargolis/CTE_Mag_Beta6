//
//  SecondNavDetailViewController.h
//  CTE_Mag_Beta6
//
//  Created by Andy Margolis on 3/4/13.
//  Copyright (c) 2013 Northshore Technology Services. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HeadlinesList.h"
@interface SecondNavDetailViewController : UIViewController{
    
    //link xml elements to labels in NavDetailViewController
    IBOutlet UILabel *id;
    IBOutlet UILabel *content;
    IBOutlet UILabel *dateadded;
    IBOutlet UILabel *url;
    IBOutlet UILabel *headline_ID;
}

@property (nonatomic, retain) HeadlinesList *headList;

@end
