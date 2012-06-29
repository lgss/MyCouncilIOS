//
//  MyNBCAppDelegate.m
//  MyNBC
//
//  Created by Kevin White on 21/11/2011.
//  Copyright 2011 Northampton Borough Council. All rights reserved.
//

#import "MyNBCAppDelegate.h"
#import "xmlContactsParser.h"
#import "xmlProblemsParser.h"

@implementation MyNBCAppDelegate

@synthesize window=_window;
@synthesize tabBarController=_tabBarController;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window.rootViewController = self.tabBarController;
    [self.window makeKeyAndVisible];
        
    navigation1Controller.navigationBar.tintColor = [UIColor grayColor];
    navigation2Controller.navigationBar.tintColor = [UIColor grayColor]; 
    navigation3Controller.navigationBar.tintColor = [UIColor grayColor]; 
    navigation4Controller.navigationBar.tintColor = [UIColor grayColor]; 
    navigation5Controller.navigationBar.tintColor = [UIColor grayColor]; 
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults]; 
    if(![defaults objectForKey:@"DeviceID"]){
        NSDateFormatter *formatter = [[[NSDateFormatter alloc] init] autorelease];
        [formatter setDateFormat:@"-yyyy-MM-dd-HH-mm-ss"];
        NSDate *todaysDate = [NSDate date ];
        NSString *formattedDate = [formatter stringFromDate:todaysDate];
        CFUUIDRef uuidRef = CFUUIDCreate(NULL);
        NSString *deviceID = [[(NSString *)CFUUIDCreateString(NULL, uuidRef) autorelease] stringByAppendingString:formattedDate];
        CFRelease(uuidRef);
        [defaults setObject:deviceID forKey:@"DeviceID"];  
        [defaults setObject:@"0" forKey:@"ContactOptionsVersion"];
        [defaults setObject:@"0" forKey:@"ProblemsVersion"];
        [defaults synchronize];
    }

    NSString* ContactsContent = [NSString stringWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"contacts" 
                                                                                               ofType:@"xml"]
                                                      encoding:NSUTF8StringEncoding
                                                         error:NULL];
    xmlContactsParser *contactParser = [[xmlContactsParser alloc]init];
    [contactParser parseThis:ContactsContent ContactOptionsVersion:[defaults objectForKey:@"ContactOptionsVersion"]];
    [contactParser release];

    NSString* content = [NSString stringWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"problems" 
                                                                                               ofType:@"xml"]
                                                      encoding:NSUTF8StringEncoding
                                                         error:NULL];
    xmlProblemsParser *problemsParser = [[xmlProblemsParser alloc]init];
    [problemsParser parseThis:content ProblemsVersion:[defaults objectForKey:@"ProblemsVersion"]];
    [problemsParser release];
        
    return YES;
}

- (void)dealloc
{
    [super dealloc];
    [_window release];
    [_tabBarController release];
}

@end
