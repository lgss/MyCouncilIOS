//
//  rssParser.m
//  MyNBC
//
//  Created by Kevin White on 10/11/2011.
//  Copyright 2011 Northampton Borough Council. All rights reserved.
//

#import "rssParser.h"
#import "SocialEntry.h"

@implementation rssParser

@synthesize rssEntries;
@synthesize doneParsing;

- (void)dealloc
{
    [currentElement release];
    [currentTitle release];
    [currentURL release];
    [currentDate release];
    [currentType release];
    [currentTypeDesc release];
    [xmlParser release];
    [super dealloc];
}

- (void)parseThis:(NSString *)xml
{
    xmlParser = [[NSXMLParser alloc] initWithData:[xml dataUsingEncoding:NSUTF8StringEncoding]];
    [xmlParser setDelegate:self];
    [xmlParser setShouldProcessNamespaces:NO];
    [xmlParser setShouldReportNamespacePrefixes:NO];
    [xmlParser setShouldResolveExternalEntities:NO];
    [xmlParser parse];
    
}

#pragma mark -
#pragma mark NSXMLParserDelegate methods

- (void)parserDidStartDocument:(NSXMLParser *)parser 
{
    rssEntries = [[NSMutableArray alloc] init];
    doneParsing = false;
    depth = 0;
    currentElement = nil;
}

- (void)parser:(NSXMLParser *)parser parseErrorOccurred:(NSError *)parseError 
{
    NSLog(@"Error: %@", [parseError localizedDescription]);
}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName 
  namespaceURI:(NSString *)namespaceURI 
 qualifiedName:(NSString *)qName 
    attributes:(NSDictionary *)attributeDict
{
    [currentElement release];
    currentElement = [elementName copy];
    
    if ([currentElement isEqualToString:@"socialentry"])
    {
        ++depth;
    }
    else if ([currentElement isEqualToString:@"heading"])
    {
        [currentTitle release];
        currentTitle = [[NSMutableString alloc] init];
    }
    else if ([currentElement isEqualToString:@"date"])
    {
        [currentDate release];
        currentDate = [[NSDate alloc] init];
    }
    else if ([currentElement isEqualToString:@"type"])
    {
        [currentType release];
        currentType = [[NSMutableString alloc] init];
    }
    else if ([currentElement isEqualToString:@"typedesc"])
    {
        [currentTypeDesc release];
        currentTypeDesc = [[NSMutableString alloc] init];
    }
    else if ([currentElement isEqualToString:@"url"])
    {
        [currentURL release];
        currentURL = [[NSMutableString alloc] init];
    }
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName 
  namespaceURI:(NSString *)namespaceURI 
 qualifiedName:(NSString *)qName
{
    
    if ([elementName isEqualToString:@"socialentry"]) 
    {
        --depth;
        SocialEntry *entry = [[[SocialEntry alloc] initWithType:currentType
                                                   entryTypeDesc:currentTypeDesc 
                                                   entryDate:currentDate
                                                   entryTitle:currentTitle 
                                                   entryUrl:currentURL] autorelease];
        [rssEntries addObject:entry];
    }

}        

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
    if ([currentElement isEqualToString:@"heading"]) 
    {
        [currentTitle appendString:string];
    } 
    else if ([currentElement isEqualToString:@"date"]) 
    {
        NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
        [dateFormat setDateFormat:@"yyyyMMddHHmm"];
        currentDate = [dateFormat dateFromString:string]; 
        [currentDate retain];
       [dateFormat release];
    } 
    else if ([currentElement isEqualToString:@"type"]) 
    {
        [currentType appendString:string];
    } 
    else if ([currentElement isEqualToString:@"typedesc"]) 
    {
        [currentTypeDesc appendString:string];
    } 
    else if ([currentElement isEqualToString:@"url"]) 
    {
        [currentURL appendString:string];
    } 
}

@end