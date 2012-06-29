//
//  BinFinder2ViewController.h
//  MyNBC
//
//  Created by Kevin White on 14/12/2011.
//  Copyright 2011 Northampton Borough Council. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import <AudioToolbox/AudioToolbox.h>

@interface BinFinder2ViewController : UIViewController<UIPickerViewDelegate> {
    
    NSMutableArray *addresses;
    int currentAddressArrayEntry;
    NSString *strPostcode;
    IBOutlet UIButton *button;
    
}

@property (nonatomic, retain) NSMutableArray *addresses;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil data:(NSMutableArray *)addresses postcodeParam:postCode;
- (IBAction)submitAddress:(id)sender;

@end
