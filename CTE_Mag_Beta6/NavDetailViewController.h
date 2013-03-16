//
//  NavDetailViewController.h
//  CTE_Mag_Beta6
//
//  Created by Andy Margolis on 3/4/13.
//  Copyright (c) 2013 Northshore Technology Services. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ArticleList.h"
@interface NavDetailViewController : UIViewController{
    
    
   
    //link xml elements to labels in NavDetailViewController
    IBOutlet UILabel *ARTICLE_TITLE;
    IBOutlet UILabel *ARTICLE_AUTHOR;
    IBOutlet UILabel *ARTICLE_DATE;
    IBOutlet UILabel *ARTICLE_PAGE;
    IBOutlet UILabel *ARTICLE_DESCRIPTION;
    IBOutlet UILabel *STATIC_WEBPAGE;
    IBOutlet UILabel *ARTICLE_ID;
}

@property (nonatomic, retain) ArticleList *artList;

- (IBAction)presentWebViewController;

@end