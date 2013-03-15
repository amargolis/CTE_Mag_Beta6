//
//  articleParser.h
//  CTE_Mag_Beta6
//
//  Created by Andy Margolis on 3/4/13.
//  Copyright (c) 2013 Northshore Technology Services. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AppDelegate.h"
#import "ArticleList.h"
#import "NavigationViewController.h"

@interface articleParser : NSObject <NSXMLParserDelegate> {
    
    AppDelegate *app;
    ArticleList *artList;
    NSMutableString *currentElementValue;
    
}

-(id)initarticleParser;

@end
