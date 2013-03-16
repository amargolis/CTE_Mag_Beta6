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
<UITableViewDataSource, UITableViewDelegate, NSXMLParserDelegate>


//added NSXMLParserDelegate to above list in effort to get rid of undeclared identifier thearticleparser warning

//@property (nonatomic, retain) AppDelegate *app;
@property (nonatomic, retain) ArticleList *artList;
@property (strong, nonatomic) NSMutableArray *articlelistArray;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) IBOutlet UIView *view;


@end

