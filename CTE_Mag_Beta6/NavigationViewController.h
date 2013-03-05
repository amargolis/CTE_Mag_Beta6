//
//  NavigationViewController.h
//  CTE_Mag_Beta6
//
//  Created by Andy Margolis on 3/4/13.
//  Copyright (c) 2013 Northshore Technology Services. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "ArticleList.h"

@interface NavigationViewController : UIViewController
<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, retain) AppDelegate *app;
@property (nonatomic, retain) ArticleList *artList;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) IBOutlet UIView *view;

@end
