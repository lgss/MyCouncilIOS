//
//  ServicesMenuViewController.h
//  MyNBC
//
//  Created by Kevin White on 16/05/2012.
//  Copyright (c) 2012 Northampton Borough Council. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import <AudioToolbox/AudioToolbox.h>

@interface ServicesMenuViewController : UIViewController<UINavigationControllerDelegate>{
   IBOutlet UIButton *buttonWebsite;
   IBOutlet UIButton *buttonMyDetails;
}

- (IBAction)gotoWebsite;
- (IBAction)gotoMyDetails;

@end
