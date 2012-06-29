//
//  Report2ViewController.h
//  MyNBC
//
//  Created by Kevin White on 26/04/2012.
//  Copyright 2012 Northampton Borough Council. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import <AudioToolbox/AudioToolbox.h>

@interface Report2ViewController : UIViewController<UINavigationControllerDelegate,UIImagePickerControllerDelegate> {
    IBOutlet UIButton *buttonTakePhoto;
    IBOutlet UIButton *buttonUsePhoto;
    IBOutlet UIButton *buttonNoPhoto;
    UIImagePickerController *imagePicker;
    bool usingCamera;
}

@property (nonatomic, retain) UIImagePickerController *imagePicker;

- (IBAction)takePhoto;
- (IBAction)usePhoto;
- (IBAction)noPhoto;

- (UIImage *) scaleAndRotateImage:(UIImage *)image;

@end
