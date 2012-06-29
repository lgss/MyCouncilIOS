//
//  SocialEntry.m
//  MyNBC
//
//  Created by Kevin White on 09/11/2011.
//  Copyright 2011 Northampton Borough Council. All rights reserved.
//

#import "SocialEntry.h"

@implementation SocialEntry
@synthesize entryDate = _entryDate;
@synthesize entryTitle = _entryTitle;
@synthesize entryUrl = _entryUrl;
@synthesize entryType = _entryType;
@synthesize entryTypeDesc = _entryTypeDesc;

//- (id)initWithRSSDate:(NSDate *)entryDate entryTitle:(NSString *)entryTitle entryUrl:(NSString *)entryUrl
//{
//    if ((self = [super init])) {
//        _entryDate = [entryDate copy];
//        _entryTitle = [entryTitle copy];
//        _entryUrl = [entryUrl copy];
//    }
//    return self;
//}

- (id)initWithType:(NSString *)entryType entryTypeDesc:(NSString *)entryTypeDesc entryDate:(NSDate *)entryDate entryTitle:(NSString *)entryTitle entryUrl:(NSString *)entryUrl
{
    if ((self = [super init])) {
        _entryDate = [entryDate copy];
        _entryTitle = [entryTitle copy];
        _entryUrl = [entryUrl copy];
        _entryType = [entryType copy];
        _entryTypeDesc = [entryTypeDesc copy];
    }
    return self;
}


- (void)dealloc {
    [_entryTitle release];
    _entryTitle = nil;
    [_entryUrl release];
    _entryUrl = nil;
    [_entryDate release];
    _entryDate = nil;
    [_entryType release];
    _entryType = nil;
    [_entryTypeDesc release];
    _entryTypeDesc = nil;
    [super dealloc];
}

@end
