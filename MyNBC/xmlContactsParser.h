//
//  xmlContactsParser.h
//  MyNBC
//
//  Created by Kevin White on 20/03/2012.
//  Copyright 2012 Northampton Borough Council. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface xmlContactsParser : NSObject<NSXMLParserDelegate>  {
    NSMutableArray *xmlContactEntries;
@private
    NSXMLParser *xmlParser;
    bool stopParsing;
    NSString *currentElement;
    NSString *contactOptionsVersion;
    NSMutableString *version;
    NSMutableString *currentServiceAreaExt;
    NSMutableString *currentServiceAreaInt;
    NSMutableString *currentSectionExt;
    NSMutableString *currentSectionInt;
    NSMutableString *currentReasonExt;
    NSMutableString *currentReasonInt;    
}

@property (nonatomic, retain) NSMutableArray *xmlContactEntries;
@property (nonatomic, retain, readonly) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, retain, readonly) NSManagedObjectModel *managedObjectModel;
@property (nonatomic, retain, readonly) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (void)parseThis:(NSString *)xml ContactOptionsVersion:(NSString *)paramContactOptionsVersion;
- (NSString *)cleanseString:(NSMutableString *)inputString removeSpace:(bool) paramRemoveSpace;
- (NSURL *)applicationDocumentsDirectory;


@end
