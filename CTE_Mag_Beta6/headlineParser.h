//
//  headlineParser.h
//  CTE_Mag_Beta6
//
//  Created by Andy Margolis on 3/4/13.
//  Copyright (c) 2013 Northshore Technology Services. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AppDelegate.h"
#import "HeadlinesList.h"
#import "SecondNavigationViewController.h"

@interface headlineParser : NSObject <NSXMLParserDelegate> {
    
    AppDelegate *app;
    HeadlinesList *headList;
    NSMutableString *currentElementValue;
    
}

-(id)initheadlineParser;

@end
