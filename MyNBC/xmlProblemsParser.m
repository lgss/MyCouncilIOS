//
//  xmlProblemsParser.m
//  MyNBC
//
//  Created by Kevin White on 20/03/2012.
//  Copyright 2012 Northampton Borough Council. All rights reserved.
//

#import "xmlProblemsParser.h"


@implementation xmlProblemsParser

@synthesize xmlContactEntries;
@synthesize managedObjectContext=_managedObjectContext;
@synthesize managedObjectModel=_managedObjectModel;
@synthesize persistentStoreCoordinator=_persistentStoreCoordinator;

- (void)dealloc
{
    [currentElement release];
    [currentProblemDescription release];
    [currentProblemNumber release];
    [xmlParser release];
    [super dealloc];
}

- (void)parseThis:(NSString *)xml ProblemsVersion:(NSString *)paramProblemsVersion
{
    problemsVersion = paramProblemsVersion;
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
    xmlContactEntries = [[NSMutableArray alloc] init];
    stopParsing = false;
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
    
    if ([currentElement isEqualToString:@"version"])
    {
        [version release];
        version = [[NSMutableString alloc] init];
    }
    else if ([currentElement isEqualToString:@"problem-description"])
    {
        [currentProblemDescription release];
        currentProblemDescription = [[NSMutableString alloc] init];
    }
    else if ([currentElement isEqualToString:@"problem-number"])
    {
        [currentProblemNumber release];
        currentProblemNumber = [[NSMutableString alloc] init];
    }
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
    if ([currentElement isEqualToString:@"version"]) 
    {
        [version appendString:string];
    } 
    else if ([currentElement isEqualToString:@"problem-description"]) 
    {
        [currentProblemDescription appendString:string];
    } 
    else if ([currentElement isEqualToString:@"problem-number"]) 
    {
        [currentProblemNumber appendString:string];
    } 
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName 
  namespaceURI:(NSString *)namespaceURI 
 qualifiedName:(NSString *)qName
{
    
    if ([elementName isEqualToString:@"problem-number"]&&!stopParsing) 
    {
        NSManagedObjectContext *context = [self managedObjectContext];
        NSError *error;
        NSManagedObject *contactOptions = [NSEntityDescription
                                           insertNewObjectForEntityForName:@"Problems" 
                                           inManagedObjectContext:context];
        [contactOptions setValue:[self cleanseString:currentProblemDescription] forKey:@"ProblemDescription"];
        [contactOptions setValue:[self cleanseString:currentProblemNumber] forKey:@"ProblemNumber"];
        if (![context save:&error]) {
            NSLog(@"Error creating Problem: %@", [error localizedDescription]);
        }
    }    
    else if ([elementName isEqualToString:@"version"])
    {
        if([version isEqualToString:problemsVersion]){ 
            stopParsing = true;
        }else{
            NSManagedObjectContext *context = [self managedObjectContext];
            NSError *error;
            NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
            NSEntityDescription *entity = [NSEntityDescription entityForName:@"Problems"inManagedObjectContext:context];
            [fetchRequest setEntity:entity];
            NSArray *fetchedObjects = [context executeFetchRequest:fetchRequest error:&error];
            for (NSManagedObject *info in fetchedObjects) {
                [context deleteObject:info];
                if (![context save:&error]) {
                    NSLog(@"Error deleting Problems: %@", [error localizedDescription]);
                }  
            }        
            [fetchRequest release]; 
            NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];    
            [defaults setObject:version forKey:@"ProblemsVersion"];
            [defaults synchronize]; 
        }
        
    }    
} 

- (NSString *)cleanseString:(NSMutableString *)inputString{
    NSString *cleansedString = [inputString stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    cleansedString = [cleansedString stringByReplacingOccurrencesOfString:@"  " withString:@""];
    return cleansedString; 
}

#pragma mark - Core Data stack

- (NSManagedObjectContext *)managedObjectContext
{
    if (_managedObjectContext != nil)
    {
        return _managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (coordinator != nil)
    {
        _managedObjectContext = [[NSManagedObjectContext alloc] init];
        [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    }
    return _managedObjectContext;
}

- (NSManagedObjectModel *)managedObjectModel {
    
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"MyNBC" ofType:@"momd"];
    NSURL *momURL = [NSURL fileURLWithPath:path];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:momURL];
    
    return _managedObjectModel; 
}

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator
{
    if (_persistentStoreCoordinator != nil)
    {
        return _persistentStoreCoordinator;
    }
    
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"MyNBC.sqlite"];
    
    NSError *error = nil;
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error])
    {
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
    }    
    
    return _persistentStoreCoordinator;
}

#pragma mark - Application's Documents directory

- (NSURL *)applicationDocumentsDirectory
{
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

@end
