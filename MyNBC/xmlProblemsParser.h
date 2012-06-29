//
//  xmlProblemsParser.h
//  MyNBC
//
//  Created by Kevin White on 20/03/2012.
//  Copyright 2012 Northampton Borough Council. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface xmlProblemsParser : NSObject<NSXMLParserDelegate>  {
    NSMutableArray *xmlProblemEntries;
@private
    NSXMLParser *xmlParser;
    bool stopParsing;
    NSString *currentElement;
    NSString *problemsVersion;
    NSMutableString *version;
    NSMutableString *currentProblemDescription;
    NSMutableString *currentProblemNumber;
}

@property (nonatomic, retain) NSMutableArray *xmlContactEntries;
@property (nonatomic, retain, readonly) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, retain, readonly) NSManagedObjectModel *managedObjectModel;
@property (nonatomic, retain, readonly) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (void)parseThis:(NSString *)xml ProblemsVersion:(NSString *)paramProblemsVersion;
- (NSString *)cleanseString:(NSMutableString *)inputString;
- (NSURL *)applicationDocumentsDirectory;


@end
