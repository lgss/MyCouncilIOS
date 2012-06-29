//
//  xmlBinParser.h
//  MyNBC
//
//  Created by Kevin White on 14/12/2011.
//  Copyright 2011 Northampton Borough Council. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface xmlBinParser : NSObject <NSXMLParserDelegate> 
{
    NSMutableArray *xmlBinEntries;
@private
    NSXMLParser *xmlParser;
    Boolean *doneParsing;
    NSInteger depth;
    NSString *currentElement;
    NSMutableString *currentAddress;
    NSMutableString *currentDate;
    NSMutableString *currentDay;
    NSMutableString *currentType;
}

@property (nonatomic, retain) NSMutableArray *xmlBinEntries;
@property (nonatomic) Boolean *doneParsing;

- (void)parseThis:(NSString *)xml;

@end
