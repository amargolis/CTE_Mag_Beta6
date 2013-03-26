//
//  articleParser.m
//  CTE_Mag_Beta6
//
//  Created by Andy Margolis on 3/4/13.
//  Copyright (c) 2013 Northshore Technology Services. All rights reserved.
//

#import "articleParser.h"
#import "ArticleList.h"
@class articleParser;
@implementation articleParser
@synthesize artList;
@synthesize articless;

//-(id) initarticleParser {

    //if (self == [super init]) {
-(articleParser *) initarticleParser {
    [super init];
    articless = [[NSMutableArray alloc] init];
    app = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    return self;
}

-(void) parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict{
    
    if ([elementName isEqualToString:@"articless"]) {
        
        app.articlelistArray = [[NSMutableArray alloc] init];
    }
    else if([elementName isEqualToString:@"articles"]) {
        artList = [[ArticleList alloc] init];
        
        artList.articleID = [[attributeDict objectForKey:@"id"] integerValue];
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
    
    if ([elementName isEqualToString:@"articless"]) {
        return;
    }
    
    if ([elementName isEqualToString:@"articles"]) {
        [app.articlelistArray addObject:artList];
        
        artList = nil;
        
    }
    else
        [artList setValue:currentElementValue forKey:elementName];
    
    currentElementValue = nil;
    
    
}

@end
