//
//  BinEntry.h
//  MyNBC
//
//  Created by Kevin White on 14/12/2011.
//  Copyright 2011 Northampton Borough Council. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface BinEntry : NSObject {
    NSString *_entryAddress;
    NSString *_entryDate;
    NSString *_entryDay;
    NSString *_entryType;
}

@property (copy) NSString *entryAddress;
@property (copy) NSString *entryDate;
@property (copy) NSString *entryDay;
@property (copy) NSString *entryType;

- (id)initWithAddress:(NSString*)entryAddress
            entryDate:(NSString*)entryDate 
            entryDay:(NSString*)entryDay
            entryType:(NSString*)entryType;

@end

