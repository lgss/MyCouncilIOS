//
//  BinFinder3ViewController.h
//  MyNBC
//
//  Created by Kevin White on 16/12/2011.
//  Copyright 2011 Northampton Borough Council. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import <AudioToolbox/AudioToolbox.h>

@interface BinFinder3ViewController : UIViewController {
    
    IBOutlet UILabel *lookupResponse;
    NSString *postcode;
    IBOutlet UIButton *buttonCheck;
    IBOutlet UIButton *buttonCall;
    
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil postcodeParam:(NSString *)postcodeParam;
- (IBAction)submitFindPostcode:(id)sender;
- (IBAction)submitCallUs:(id)sender;

@end
