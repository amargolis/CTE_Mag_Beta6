//
//  SVWebViewController.h
//  CTE_Mag_Beta6
//
//  Created by Andy Margolis on 3/4/13.
//  Copyright (c) 2013 Northshore Technology Services. All rights reserved.
//

#import <MessageUI/MessageUI.h>

#import "SVModalWebViewController.h"

@interface SVWebViewController : UIViewController

- (id)initWithAddress:(NSString*)urlString;
- (id)initWithURL:(NSURL*)URL;

@property (nonatomic, readwrite) SVWebViewControllerAvailableActions availableActions;

@end


//not lining up with actual articles**