//
//  ContactUs3ViewController.m
//  MyNBC
//
//  Created by Kevin White on 09/01/2012.
//  Copyright 2012 Northampton Borough Council. All rights reserved.
//

#import "ContactUs3ViewController.h"
#import "ContactUs4ViewController.h"

@implementation ContactUs3ViewController

@synthesize managedObjectContext=_managedObjectContext;
@synthesize managedObjectModel=_managedObjectModel;
@synthesize persistentStoreCoordinator=_persistentStoreCoordinator;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}


- (void)dealloc
{
    [super dealloc];
    [pageTitle release];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.title=@"And the subject?";
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults]; 
    if([defaults objectForKey:@"ContactServiceArea"]){
        serviceArea=[defaults objectForKey:@"ContactServiceArea"]; 
    }
    if([defaults objectForKey:@"ContactSection"]){
        section=[defaults objectForKey:@"ContactSection"]; 
    }

    reasonsExtArray = [[NSMutableArray alloc] init];
    reasonsIntArray = [[NSMutableArray alloc] init];
    
    [[button layer] setCornerRadius:8.0f];
    [[button layer] setMasksToBounds:YES];
    [[button layer] setBorderWidth:1.0f];
    [[button layer] setBackgroundColor:[[UIColor colorWithRed:75/255.0
                                                        green:172/255.0
                                                         blue:198/255.0
                                                        alpha:1.0] CGColor]];
    
    NSManagedObjectContext *context = [self managedObjectContext];
    NSError *error;
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    [fetchRequest setResultType:NSDictionaryResultType];
    NSEntityDescription *entity = [NSEntityDescription 
                                   entityForName:@"ContactOptions" inManagedObjectContext:context];
    [fetchRequest setEntity:entity];   
    NSDictionary *entityProperties = [entity propertiesByName];
    [fetchRequest setReturnsDistinctResults:true];
    [fetchRequest setPropertiesToFetch:[NSArray arrayWithObjects:[entityProperties objectForKey:@"SectionExt"],
                                                                 [entityProperties objectForKey:@"ReasonExt"],
                                                                 [entityProperties objectForKey:@"ReasonInt"], 
                                        nil]];    
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc]
                                        initWithKey:@"ReasonExt" ascending:YES];
    [fetchRequest setSortDescriptors:[NSArray arrayWithObject:sortDescriptor]];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"(ServiceAreaInt MATCHES %@) AND (SectionInt MATCHES %@)", serviceArea, section];
    [fetchRequest setPredicate:predicate];
    [sortDescriptor release];
    
    NSArray *fetchedObjects = [context executeFetchRequest:fetchRequest error:&error];
    for (NSManagedObject *info in fetchedObjects) {
        [reasonsExtArray addObject:[info valueForKey:@"ReasonExt"]];
        [reasonsIntArray addObject:[info valueForKey:@"ReasonInt"]];
    }
    [fetchRequest release];  
    [reasonsExtArray retain];
    [reasonsIntArray retain];

}

- (void)viewDidUnload
{
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)thePickerView {
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    
    return [reasonsIntArray count];
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return [reasonsExtArray objectAtIndex:row];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    
    wheelSelection = row;
}


- (IBAction)submitRegarding:(id)sender{
    SystemSoundID klick;
    AudioServicesCreateSystemSoundID((CFURLRef)[NSURL fileURLWithPath:[[NSBundle mainBundle]pathForResource:@"button-20" ofType:@"wav"]isDirectory:NO],&klick);
    AudioServicesPlaySystemSound(klick);
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];    
    [defaults setObject:[reasonsIntArray objectAtIndex:wheelSelection] forKey:@"ContactReason"];    
    [defaults synchronize]; 
    ContactUs4ViewController *vcContact4 = [[ContactUs4ViewController alloc] initWithNibName:@"ContactUs4ViewController" bundle:nil];
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationItem.backBarButtonItem = backButton;
    [backButton release];
    [self.navigationController pushViewController:vcContact4 animated:YES];
    [vcContact4 release];
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
