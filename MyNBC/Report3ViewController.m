//
//  Report3ViewController.m
//  MyNBC
//
//  Created by Kevin White on 26/04/2012.
//  Copyright 2012 Northampton Borough Council. All rights reserved.
//

#import "Report3ViewController.h"
#import "Report4ViewController.h"

@implementation Report3ViewController
@synthesize imagePicker;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil 
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (void)dealloc
{
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.title=@"This picture?";  
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults]; 
    NSData * imageData = [defaults objectForKey:@"ImageData"];
    image.image=[UIImage imageWithData:imageData];
    [[usebutton layer] setCornerRadius:8.0f];
    [[usebutton layer] setMasksToBounds:YES];
    [[usebutton layer] setBorderWidth:1.0f];
    [[usebutton layer] setBackgroundColor:[[UIColor colorWithRed:142/255.0
                                                               green:191/255.0
                                                                blue:12/255.0
                                                               alpha:1.0] CGColor]];
    
    [[reselectbutton layer] setCornerRadius:8.0f];
    [[reselectbutton layer] setMasksToBounds:YES];
    [[reselectbutton layer] setBorderWidth:1.0f];
    [[reselectbutton layer] setBackgroundColor:[[UIColor colorWithRed:226/255.0
                                                               green:34/255.0
                                                                blue:8/255.0
                                                               alpha:1.0] CGColor]];

}

- (void)viewDidUnload
{
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction)usePhoto {
    SystemSoundID klick;
	AudioServicesCreateSystemSoundID((CFURLRef)[NSURL fileURLWithPath:[[NSBundle mainBundle]pathForResource:@"button-20" ofType:@"wav"]isDirectory:NO],&klick);
	AudioServicesPlaySystemSound(klick);
    Report4ViewController *vcReport4 = [[Report4ViewController alloc] initWithNibName:@"Report4ViewController" bundle:nil];
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationItem.backBarButtonItem = backButton;
    [backButton release];
    [self.navigationController pushViewController:vcReport4 animated:YES];
    [vcReport4 release];
}

- (IBAction)selectPhoto {
    SystemSoundID klick;
	AudioServicesCreateSystemSoundID((CFURLRef)[NSURL fileURLWithPath:[[NSBundle mainBundle]pathForResource:@"button-20" ofType:@"wav"]isDirectory:NO],&klick);
	AudioServicesPlaySystemSound(klick);
    [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:[self.navigationController.viewControllers count]-2] animated:YES];
}


@end
