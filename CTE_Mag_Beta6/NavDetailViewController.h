//
//  NavDetailViewController.h
//  CTE_Mag_Beta6
//
//  Created by Andy Margolis on 3/4/13.
//  Copyright (c) 2013 Northshore Technology Services. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ArticleList.h"
@interface NavDetailViewController : UIViewController <UIScrollViewDelegate>
    
@property (nonatomic, strong) IBOutlet UIScrollView *scrollView;
@property (nonatomic, retain) ArticleList *artList;

- (IBAction)presentWebViewController;

@end