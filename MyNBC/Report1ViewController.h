//
//  Report1ViewController.h
//  MyNBC
//
//  Created by Kevin White on 04/04/2012.
//  Copyright 2012 Northampton Borough Council. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import <QuartzCore/QuartzCore.h>
#import <AudioToolbox/AudioToolbox.h>

@interface Report1ViewController : UIViewController<UIPickerViewDelegate> {

    IBOutlet UIImageView *displayImage;
    NSMutableArray *problemDescriptionArray;
    NSMutableArray *problemNumberArray;
    NSInteger problemSelection;
    IBOutlet UIButton *button;
    
}

@property (nonatomic, retain, readonly) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, retain, readonly) NSManagedObjectModel *managedObjectModel;
@property (nonatomic, retain, readonly) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (NSURL *)applicationDocumentsDirectory;
- (IBAction)submitProblemType:(id)sender;

@end
