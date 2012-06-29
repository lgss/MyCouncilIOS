//
//  BinFinder5ViewController.h
//  MyNBC
//
//  Created by Kevin White on 17/12/2011.
//  Copyright 2011 Northampton Borough Council. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import <AudioToolbox/AudioToolbox.h>

@interface BinFinder5ViewController : UIViewController<UIPickerViewDelegate> {
    
    NSString *strDay;
    NSString *strPreviousDay;
    int intTime;
    int fireDateModifier;
    NSDate *fireDate;
    IBOutlet UIButton *buttonReminder;
    
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil date:(NSString *)date day:(NSString *)day;

- (IBAction)submitSetReminder:(id)sender;

@end
