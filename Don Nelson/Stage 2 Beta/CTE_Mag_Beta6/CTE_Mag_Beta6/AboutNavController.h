//
//  AboutNavController.h
//  CTE_Mag_Beta6
//
//  Created by Andy Margolis on 3/4/13.
//  Copyright (c) 2013 Northshore Technology Services. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

@interface AboutNavController : UIViewController
<UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) IBOutlet UIView *view;
@property (strong, nonatomic) NSArray *aboutlist;
@property (strong, nonatomic) IBOutlet UITableViewCell *webViewCell;



@end
