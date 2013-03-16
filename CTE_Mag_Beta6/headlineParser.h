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

@class headlineParser;
@interface headlineParser : NSObject <NSXMLParserDelegate> {
    
    NSMutableString *currentElementValue;
    HeadlinesList *headList;
    AppDelegate *app;
    NSMutableArray *headliness;
}

@property (nonatomic, retain) HeadlinesList *headList;
@property (nonatomic, retain) NSMutableArray *headliness;

-(headlineParser *) initheadlineParser;
//remove if working, reimpplement if not working and delete above
//-(id)initheadlineParser;

@end
