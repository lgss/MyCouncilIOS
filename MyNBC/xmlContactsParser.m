//
//  xmlContactsParser.m
//  MyNBC
//
//  Created by Kevin White on 20/03/2012.
//  Copyright 2012 Northampton Borough Council. All rights reserved.
//

#import "xmlContactsParser.h"


@implementation xmlContactsParser

@synthesize xmlContactEntries;
@synthesize managedObjectContext=_managedObjectContext;
@synthesize managedObjectModel=_managedObjectModel;
@synthesize persistentStoreCoordinator=_persistentStoreCoordinator;

- (void)dealloc
{
    [currentElement release];
    [currentServiceAreaExt release];
    [currentServiceAreaInt release];
    [currentSectionExt release];
    [currentSectionInt release];
    [currentReasonExt release];
    [currentReasonInt release];
    [xmlParser release];
    [super dealloc];
}

- (void)parseThis:(NSString *)xml ContactOptionsVersion:(NSString *)paramContactOptionsVersion
{
    contactOptionsVersion = paramContactOptionsVersion;
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
    else if ([currentElement isEqualToString:@"service-area-ext"])
    {
        [currentServiceAreaExt release];
        currentServiceAreaExt = [[NSMutableString alloc] init];
    }
    else if ([currentElement isEqualToString:@"service-area-int"])
    {
        [currentServiceAreaInt release];
        currentServiceAreaInt = [[NSMutableString alloc] init];
    }
    else if ([currentElement isEqualToString:@"section-int"])
    {
        [currentSectionInt release];
        currentSectionInt = [[NSMutableString alloc] init];
    }
    else if ([currentElement isEqualToString:@"section-ext"])
    {
        [currentSectionExt release];
        currentSectionExt = [[NSMutableString alloc] init];
    }
    else if ([currentElement isEqualToString:@"reason-int"])
    {
        [currentReasonInt release];
        currentReasonInt = [[NSMutableString alloc] init];
    }
    else if ([currentElement isEqualToString:@"reason-ext"])
    {
        [currentReasonExt release];
        currentReasonExt = [[NSMutableString alloc] init];
    }
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
    if ([currentElement isEqualToString:@"version"]) 
    {
        [version appendString:string];
    } 
    else if ([currentElement isEqualToString:@"service-area-ext"]) 
    {
        [currentServiceAreaExt appendString:string];
    } 
    else if ([currentElement isEqualToString:@"service-area-int"]) 
    {
        [currentServiceAreaInt appendString:string];
    } 
    else if ([currentElement isEqualToString:@"section-ext"]) 
    {
        [currentSectionExt appendString:string];
    } 
    else if ([currentElement isEqualToString:@"section-int"]) 
    {
        [currentSectionInt appendString:string];
    } 
    else if ([currentElement isEqualToString:@"reason-ext"]) 
    {
        [currentReasonExt appendString:string];
    } 
    else if ([currentElement isEqualToString:@"reason-int"]) 
    {
        [currentReasonInt appendString:string];
    } 
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName 
  namespaceURI:(NSString *)namespaceURI 
 qualifiedName:(NSString *)qName
{
        
    if ([elementName isEqualToString:@"reason-int"]&&!stopParsing) 
    {
        NSManagedObjectContext *context = [self managedObjectContext];
        NSError *error;
                
        NSManagedObject *contactOptions = [NSEntityDescription
                                       insertNewObjectForEntityForName:@"ContactOptions" 
                                       inManagedObjectContext:context];
        [contactOptions setValue:[self cleanseString:currentServiceAreaExt removeSpace:false] forKey:@"ServiceAreaExt"];
        [contactOptions setValue:[self cleanseString:currentServiceAreaInt removeSpace:true] forKey:@"ServiceAreaInt"];
        [contactOptions setValue:[self cleanseString:currentSectionExt removeSpace:false] forKey:@"SectionExt"];
        [contactOptions setValue:[self cleanseString:currentSectionInt removeSpace:true] forKey:@"SectionInt"];
        [contactOptions setValue:[self cleanseString:currentReasonExt removeSpace:false] forKey:@"ReasonExt"];
        [contactOptions setValue:[self cleanseString:currentReasonInt removeSpace:true] forKey:@"ReasonInt"];
        if (![context save:&error]) {
            NSLog(@"Error creating CustomerID: %@", [error localizedDescription]);
        }
    }    
    else if ([elementName isEqualToString:@"version"])
    {
        if([version isEqualToString:contactOptionsVersion]){ 
            stopParsing = true;
        }else{
            NSManagedObjectContext *context = [self managedObjectContext];
            NSError *error;
            NSFetchRequest *fetchRequest = [[[NSFetchRequest alloc] init]autorelease];
            NSEntityDescription *entity = [NSEntityDescription entityForName:@"ContactOptions"inManagedObjectContext:context];
            [fetchRequest setEntity:entity];
            NSArray *fetchedObjects = [context executeFetchRequest:fetchRequest error:&error];
            for (NSManagedObject *info in fetchedObjects) {
               [context deleteObject:info];
                if (![context save:&error]) {
                   NSLog(@"Error deleting Contact Options: %@", [error localizedDescription]);
                }  
            }  
            NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];    
            [defaults setObject:version forKey:@"ContactOptionsVersion"];
            [defaults synchronize]; 
        }

    }    
} 

- (NSString *)cleanseString:(NSMutableString *)inputString removeSpace:(bool) paramRemoveSpace{
    NSString *cleansedString = [inputString stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    if(paramRemoveSpace){
       cleansedString = [cleansedString stringByReplacingOccurrencesOfString:@" " withString:@""];
    }
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
