//
//  ContactUs3ViewController.h
//  MyNBC
//
//  Created by Kevin White on 09/01/2012.
//  Copyright 2012 Northampton Borough Council. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import <QuartzCore/QuartzCore.h>
#import <AudioToolbox/AudioToolbox.h>

@interface ContactUs3ViewController : UIViewController<UIPickerViewDelegate> {
    NSString *serviceArea;
    NSString *section;
    NSMutableArray *reasonsExtArray;
    NSMutableArray *reasonsIntArray;
    IBOutlet UIButton *button;
    NSInteger wheelSelection;
    NSString *pageTitle;
}

@property (nonatomic, retain, readonly) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, retain, readonly) NSManagedObjectModel *managedObjectModel;
@property (nonatomic, retain, readonly) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (IBAction)submitRegarding:(id)sender;
- (NSURL *)applicationDocumentsDirectory;

@end
