//
//  headlineParser.m
//  CTE_Mag_Beta6
//
//  Created by Andy Margolis on 3/4/13.
//  Copyright (c) 2013 Northshore Technology Services. All rights reserved.
//

#import "headlineParser.h"
#import "HeadlinesList.h"
@class headlineParser;
@implementation headlineParser
//added two synthesize values as well as import articleList.h
@synthesize headList;
@synthesize headliness;

//-(id) initheadlineParser {
    
    //if (self == [super init]) {
-(headlineParser *) initheadlineParser; {
    [super init];
    headliness = [[NSMutableArray alloc] init];
    app = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    return self;
}



-(void) parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict{
    
    if ([elementName isEqualToString:@"headliness"]) {
        
        app.headlineslistArray = [[NSMutableArray alloc] init];
    }
    else if([elementName isEqualToString:@"headlines"]) {
        headList = [[HeadlinesList alloc] init];
        
        headList.headlineID = [[attributeDict objectForKey:@"id"] integerValue];
    }
    
}

-(void) parser:(NSXMLParser *)parser foundCharacters:(NSString *)string{
    
    if (!currentElementValue) {
        currentElementValue = [[NSMutableString alloc] initWithString:string];
    }
    else
        [currentElementValue appendString:string];
    
}

-(void) parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName{
    
    if ([elementName isEqualToString:@"headliness"]) {
        return;
    }
    
    if ([elementName isEqualToString:@"headlines"]) {
        [app.headlineslistArray addObject:headList];
        
        headList = nil;
        
    }
    else
        [headList setValue:currentElementValue forKey:elementName];
    
    currentElementValue = nil;
    
    
}

@end
