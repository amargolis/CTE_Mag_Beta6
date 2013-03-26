//
//  ArticleList.h
//  CTE_Mag_Beta6
//
//  Created by Andy Margolis on 3/4/13.
//  Copyright (c) 2013 Northshore Technology Services. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ArticleList : NSObject
@property (nonatomic, retain) NSString *ARTICLE_TITLE;
@property (nonatomic, retain) NSString *ARTICLE_AUTHOR;
@property (nonatomic, retain) NSString *ARTICLE_DATE;
@property (nonatomic, retain) NSString *ARTICLE_PAGE;
@property (nonatomic, retain) NSString *ARTICLE_DESCRIPTION;
@property (nonatomic, retain) NSString *STATIC_WEBPAGE;
@property (nonatomic, retain) NSString *ARTICLE_ID;
@property (nonatomic, readwrite) NSInteger articleID;
@end
