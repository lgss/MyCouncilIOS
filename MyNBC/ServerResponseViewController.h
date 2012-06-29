//
//  ServerResponseViewController.h
//  MyNBC
//
//  Created by Kevin White on 30/04/2012.
//  Copyright 2012 Northampton Borough Council. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AddressBook/AddressBook.h>
#import <AddressBookUI/AddressBookUI.h>
#import <MapKit/MapKit.h>
#import <QuartzCore/QuartzCore.h>
#import <AudioToolbox/AudioToolbox.h>

@interface ServerResponseViewController : UIViewController<NSXMLParserDelegate> {
    
        NSMutableData *serverResponse;
        UIActivityIndicatorView *activityIndicator;
        IBOutlet UILabel *labelCallNumberText;
        IBOutlet UILabel *labelCallNumber;
        IBOutlet UILabel *labelSlaDateText;
        IBOutlet UILabel *labelSlaDate;
        NSXMLParser *xmlParser;
        NSString *currentElement;  
        NSMutableString *result;
        NSMutableString *callNumber;
        NSMutableString *slaDate; 
        bool fromReport;
        bool fromContact;
        CLLocationCoordinate2D problemLocation;
        NSURLConnection *serverConnection;
        IBOutlet UIButton *retryButton;
}

- (void)submitFailed;
- (void)parseThis:(NSString *)xml;
- (NSString *)cleanseString:(NSMutableString *)inputString;
- (IBAction)retrySubmit;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil fromReport:(bool)paramFromReport fromContact:(bool)paramFromContact;

@end
