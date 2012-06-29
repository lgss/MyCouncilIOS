//
//  MyDetailsPhoneViewController.h
//  MyNBC
//
//  Created by Kevin White on 03/05/2012.
//  Copyright 2012 Northampton Borough Council. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import <AudioToolbox/AudioToolbox.h>

@interface MyDetailsPhoneViewController : UIViewController<UITextFieldDelegate> {
    bool fromReport;
    bool fromContact;
    IBOutlet UIButton *button;
}

@property (nonatomic, retain) IBOutlet UITextField *textView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil fromReport:(bool)paramFromReport fromContact:(bool)paramFromContact;
- (IBAction)submitPhoneNumber:(id)sender;

@end