//
//  HeadlinesList.h
//  CTE_Mag_Beta6
//
//  Created by Andy Margolis on 3/4/13.
//  Copyright (c) 2013 Northshore Technology Services. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HeadlinesList : NSObject

@property (nonatomic, retain) NSString *content;
@property (nonatomic, retain) NSString *dateadded;
@property (nonatomic, retain) NSString *url;
@property (nonatomic, retain) NSString *id;
@property (nonatomic, readwrite) NSInteger headlineID;
@end
