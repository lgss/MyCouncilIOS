//
//  ServicesMenuViewController.m
//  MyNBC
//
//  Created by Kevin White on 16/05/2012.
//  Copyright (c) 2012 Northampton Borough Council. All rights reserved.
//

#import "ServicesMenuViewController.h"
#import "MyDetailsViewController1.h"
#import "WebViewController.h"

@interface ServicesMenuViewController ()

@end

@implementation ServicesMenuViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [[buttonWebsite layer] setCornerRadius:8.0f];
    [[buttonWebsite layer] setMasksToBounds:YES];
    [[buttonWebsite layer] setBorderWidth:1.0f];
    [[buttonWebsite layer] setBackgroundColor:[[UIColor colorWithRed:75/255.0
                                                                 green:172/255.0
                                                                  blue:198/255.0
                                                                 alpha:1.0] CGColor]];
    
    [[buttonMyDetails layer] setCornerRadius:8.0f];
    [[buttonMyDetails layer] setMasksToBounds:YES];
    [[buttonMyDetails layer] setBorderWidth:1.0f];
    [[buttonMyDetails layer] setBackgroundColor:[[UIColor colorWithRed:75/255.0
                                                                green:172/255.0
                                                                 blue:198/255.0
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

- (IBAction)gotoWebsite {
    SystemSoundID klick;
	AudioServicesCreateSystemSoundID((CFURLRef)[NSURL fileURLWithPath:[[NSBundle mainBundle]pathForResource:@"button-20" ofType:@"wav"]isDirectory:NO],&klick);
	AudioServicesPlaySystemSound(klick);
    WebViewController *webViewController = [[WebViewController alloc] initWithNibName:@"WebViewController"  bundle:nil url:@"http://northampton.gov.uk"  homePage:false];
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationItem.backBarButtonItem = backButton;
    [backButton release];
    [self.navigationController  pushViewController:webViewController animated:YES];
    [webViewController release];

}

- (IBAction)gotoMyDetails {
    SystemSoundID klick;
	AudioServicesCreateSystemSoundID((CFURLRef)[NSURL fileURLWithPath:[[NSBundle mainBundle]pathForResource:@"button-20" ofType:@"wav"]isDirectory:NO],&klick);
	AudioServicesPlaySystemSound(klick);
    MyDetailsViewController1 *vcDets = [[MyDetailsViewController1 alloc]initWithNibName:@"MyDetailsViewController1" bundle:nil];
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationItem.backBarButtonItem = backButton;
    [backButton release];
    [self.navigationController pushViewController:vcDets animated:YES];
    [vcDets release];
}

@end
