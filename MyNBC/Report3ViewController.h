//
//  Report3ViewController.h
//  MyNBC
//
//  Created by Kevin White on 26/04/2012.
//  Copyright 2012 Northampton Borough Council. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import <AudioToolbox/AudioToolbox.h>

@interface Report3ViewController : UIViewController<UINavigationControllerDelegate,UIImagePickerControllerDelegate> {
    IBOutlet UIButton *usebutton;
    IBOutlet UIButton *reselectbutton;
    IBOutlet UIImageView *image;
}

@property (nonatomic, retain) UIImagePickerController *imagePicker;

- (IBAction)usePhoto;
- (IBAction)selectPhoto;

@end


