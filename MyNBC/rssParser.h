//
//  rssParser.h
//  MyNBC
//
//  Created by Kevin White on 10/11/2011.
//  Copyright 2011 Northampton Borough Council. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface rssParser : NSObject <NSXMLParserDelegate> 
{
NSMutableArray *rssEntries;
@private
    NSXMLParser *xmlParser;
    Boolean *doneParsing;
    NSInteger depth;
    NSMutableString *currentTitle;
    NSMutableString *currentURL;
    NSMutableString *currentType;
    NSMutableString *currentTypeDesc;
    NSString *currentElement;
    NSDate *currentDate;
}

@property (nonatomic, retain) NSMutableArray *rssEntries;
@property (nonatomic) Boolean *doneParsing;

- (void)parseThis:(NSString *)xml;

@end