//
//  MyDetailsViewController1.h
//  MyNBC
//
//  Created by Kevin White on 20/02/2012.
//  Copyright 2012 Northampton Borough Council. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import <AudioToolbox/AudioToolbox.h>

@interface MyDetailsViewController1 : UIViewController {
        
    IBOutlet UIButton *changeName;
    IBOutlet UIButton *changePostcode;
    IBOutlet UIButton *changeEmail;
    IBOutlet UIButton *changePhoneNumber;
    
}

- (IBAction)submitSetName:(id)sender;
- (IBAction)submitSetPostcode:(id)sender;
- (IBAction)submitSetEmail:(id)sender;
- (IBAction)submitSetPhoneNumber:(id)sender;

@end
