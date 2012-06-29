//
//  ContactUs1ViewController.h
//  MyNBC
//
//  Created by Kevin White on 06/01/2012.
//  Copyright 2012 Northampton Borough Council. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import <QuartzCore/QuartzCore.h>
#import <AudioToolbox/AudioToolbox.h>

@interface ContactUs1ViewController : UIViewController<UIPickerViewDelegate> {
    
    NSMutableArray *servicesIntArray;
    NSMutableArray *servicesExtArray;
    NSInteger serviceSelection;
    IBOutlet UIButton *button;
}

@property (nonatomic, retain, readonly) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, retain, readonly) NSManagedObjectModel *managedObjectModel;
@property (nonatomic, retain, readonly) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (IBAction)submitServiceArea:(id)sender;

- (NSURL *)applicationDocumentsDirectory;

@end
