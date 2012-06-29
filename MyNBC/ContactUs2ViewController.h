//
//  ContactUs2ViewController.h
//  MyNBC
//
//  Created by Kevin White on 06/01/2012.
//  Copyright 2012 Northampton Borough Council. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import <QuartzCore/QuartzCore.h>
#import <AudioToolbox/AudioToolbox.h>

@interface ContactUs2ViewController : UIViewController<UIPickerViewDelegate> {
    NSString *serviceArea;
    NSMutableArray *sectionsExtArray;
    NSMutableArray *sectionsIntArray;
    NSInteger wheelSelection;
    IBOutlet UIButton *button;
}

@property (nonatomic, retain, readonly) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, retain, readonly) NSManagedObjectModel *managedObjectModel;
@property (nonatomic, retain, readonly) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (IBAction)submitSubject:(id)sender;

- (NSURL *)applicationDocumentsDirectory;

@end
