//
//  ResponseViewController.h
//  MyNBC
//
//  Created by Kevin White on 28/04/2012.
//  Copyright 2012 Northampton Borough Council. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import <AudioToolbox/AudioToolbox.h>

@interface ResponseViewController : UIViewController {
  
    IBOutlet UIButton *buttonResponseEmail;
    IBOutlet UIButton *buttonResponsePhone;
    IBOutlet UIButton *buttonResponseNo;
    bool fromReport;
    bool fromContact;
    
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil fromReport:(bool)paramFromReport fromContact:(bool)paramFromContact;

- (IBAction)responseByEMail:(id)sender;
- (IBAction)responseByPhone:(id)sender;
- (IBAction)responseNotRequired:(id)sender;

@end
