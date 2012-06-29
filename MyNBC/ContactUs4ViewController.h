//
//  ContactUs4ViewController.h
//  MyNBC
//
//  Created by Kevin White on 09/01/2012.
//  Copyright 2012 Northampton Borough Council. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AudioToolbox/AudioToolbox.h>

@interface ContactUs4ViewController : UIViewController<UIApplicationDelegate,UITextViewDelegate> {
    
    NSMutableData *contactData;
    
}

@property (nonatomic, retain) IBOutlet UITextView *textView;

- (IBAction)setContactText:(id)sender;

@end
