//
//  BinEntry.m
//  MyNBC
//
//  Created by Kevin White on 14/12/2011.
//  Copyright 2011 Northampton Borough Council. All rights reserved.
//

#import "BinEntry.h"

@implementation BinEntry
@synthesize entryAddress = _entryAddress;
@synthesize entryDate = _entryDate;
@synthesize entryDay = _entryDay;
@synthesize entryType = _entryType;

- (id)initWithAddress:(NSString *)entryAddress entryDate:(NSString *)entryDate entryDay:(NSString *)entryDay entryType:(NSString *)entryType
{
    if ((self = [super init])) {
        _entryAddress = [entryAddress copy];
        _entryDate = [entryDate copy];
        _entryDay = [entryDay copy];
        _entryType = [entryType copy];
    }
    return self;
}

- (void)dealloc {
    [_entryAddress release];
    _entryAddress = nil;
    [_entryDate release];
    _entryDate = nil;
    [_entryDay release];
    _entryDay = nil;
    [_entryType release];
    _entryType = nil;
    [super dealloc];
}

@end
