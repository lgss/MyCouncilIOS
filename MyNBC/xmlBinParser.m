//
//  xmlBinParser.m
//  MyNBC
//
//  Created by Kevin White on 14/12/2011.
//  Copyright 2011 Northampton Borough Council. All rights reserved.
//

#import "xmlBinParser.h"
#import "BinEntry.h"

@implementation xmlBinParser

@synthesize xmlBinEntries;
@synthesize doneParsing;

- (void)dealloc
{
    [currentElement release];
    [currentAddress release];
    [currentDate release];
    [currentDay release];
    [currentType release];
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
    xmlBinEntries = [[NSMutableArray alloc] init];
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
    
    if ([currentElement isEqualToString:@"item"])
    {
        ++depth;
    }
    else if ([currentElement isEqualToString:@"address"])
    {
        [currentAddress release];
        currentAddress = [[NSMutableString alloc] init];
    }
    else if ([currentElement isEqualToString:@"date"])
    {
        [currentDate release];
        currentDate = [[NSMutableString alloc] init];
    }
    else if ([currentElement isEqualToString:@"day"])
    {
        [currentDay release];
        currentDay = [[NSMutableString alloc] init];
    }
    else if ([currentElement isEqualToString:@"type"])
    {
        [currentType release];
        currentType = [[NSMutableString alloc] init];
    }
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName 
  namespaceURI:(NSString *)namespaceURI 
 qualifiedName:(NSString *)qName
{
    
    if ([elementName isEqualToString:@"property"]) 
    {
        --depth;
    }
    else if ([elementName isEqualToString:@"type"])
    {
        BinEntry *entry1 = [[[BinEntry alloc] initWithAddress:currentAddress
                                                    entryDate:currentDate 
                                                     entryDay:currentDay 
                                                    entryType:currentType]autorelease];
        [xmlBinEntries addObject:entry1];
    }
    
}        

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
    if ([currentElement isEqualToString:@"address"]) 
    {
        [currentAddress appendString:string];
    } 
    else if ([currentElement isEqualToString:@"date"]) 
    {
        [currentDate appendString:string];
    } 
    else if ([currentElement isEqualToString:@"day"]) 
    {
        [currentDay appendString:string];
    } 
    else if ([currentElement isEqualToString:@"type"]) 
    {
        [currentType appendString:string];
    } 
}


@end
