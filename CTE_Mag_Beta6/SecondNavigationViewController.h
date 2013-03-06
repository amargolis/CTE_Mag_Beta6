//
//  SecondNavigationViewController.h
//  CTE_Mag_Beta6
//
//  Created by Andy Margolis on 3/4/13.
//  Copyright (c) 2013 Northshore Technology Services. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "HeadlinesList.h"

@interface SecondNavigationViewController : UIViewController
<UITableViewDataSource, UITableViewDelegate, NSXMLParserDelegate>

//@property (nonatomic, retain) AppDelegate *app;
@property (strong, nonatomic) NSMutableArray *headlineslistArray;
@property (nonatomic, retain) HeadlinesList *headList;
@property (strong, nonatomic) IBOutlet UIView *view;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end
