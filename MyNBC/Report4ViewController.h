//
//  Report4ViewController.h
//  MyNBC
//
//  Created by Kevin White on 27/04/2012.
//  Copyright 2012 Northampton Borough Council. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AudioToolbox/AudioToolbox.h>

@interface Report4ViewController : UIViewController<UITextViewDelegate> {
}

@property (nonatomic, retain) IBOutlet UITextView *textView;

- (IBAction)setDetails:(id)sender;
-(void)moveOnToNextScreen;

@end
