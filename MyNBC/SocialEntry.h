//
//  SocialEntry.h
//  MyNBC
//
//  Created by Kevin White on 09/11/2011.
//  Copyright 2011 Northampton Borough Council. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface SocialEntry : NSObject {
    NSDate *_entryDate;
    NSString *_entryTitle;
    NSString *_entryUrl;
    NSString *_entryType;
    NSString *_entryTypeDesc;
}

@property (copy) NSDate *entryDate;
@property (copy) NSString *entryTitle;
@property (copy) NSString *entryUrl;
@property (copy) NSString *entryType;
@property (copy) NSString *entryTypeDesc;

//- (id)initWithRSSDate:(NSDate*)entryDate entryTitle:(NSString*)entryTitle entryUrl:(NSString*)entryUrl;
- (id)initWithType:(NSString*)entryType entryTypeDesc:(NSString*)entryTypeDesc entryDate:(NSDate*)entryDate entryTitle:(NSString*)entryTitle entryUrl:(NSString*)entryUrl;

@end
