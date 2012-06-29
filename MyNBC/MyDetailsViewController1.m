//
//  MyDetailsViewController1.m
//  MyNBC
//
//  Created by Kevin White on 20/02/2012.
//  Copyright 2012 Northampton Borough Council. All rights reserved.
//

#import "MyDetailsViewController1.h"
#import "MyDetailsNameViewController.h"
#import "MyDetailsEmailViewController.h"
#import "MyDetailsPhoneViewController.h"
#import "MyDetailsPostcodeViewController.h"

@implementation MyDetailsViewController1

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
    self.navigationItem.title=@"My Details";
    [[changeName layer] setCornerRadius:8.0f];
    [[changeName layer] setMasksToBounds:YES];
    [[changeName layer] setBorderWidth:1.0f];
    [[changeName layer] setBackgroundColor:[[UIColor colorWithRed:75/255.0
                                                                green:172/255.0
                                                                 blue:198/255.0
                                                                alpha:1.0] CGColor]];  
    [[changePostcode layer] setCornerRadius:8.0f];
    [[changePostcode layer] setMasksToBounds:YES];
    [[changePostcode layer] setBorderWidth:1.0f];
    [[changePostcode layer] setBackgroundColor:[[UIColor colorWithRed:75/255.0
                                                            green:172/255.0
                                                             blue:198/255.0
                                                            alpha:1.0] CGColor]];
    [[changeEmail layer] setCornerRadius:8.0f];
    [[changeEmail layer] setMasksToBounds:YES];
    [[changeEmail layer] setBorderWidth:1.0f];
    [[changeEmail layer] setBackgroundColor:[[UIColor colorWithRed:75/255.0
                                                                green:172/255.0
                                                                 blue:198/255.0
                                                                alpha:1.0] CGColor]];
    [[changePhoneNumber layer] setCornerRadius:8.0f];
    [[changePhoneNumber layer] setMasksToBounds:YES];
    [[changePhoneNumber layer] setBorderWidth:1.0f];
    [[changePhoneNumber layer] setBackgroundColor:[[UIColor colorWithRed:75/255.0
                                                             green:172/255.0
                                                              blue:198/255.0
                                                             alpha:1.0] CGColor]]; 
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
     NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if([defaults objectForKey:@"CustomerName"]){
        [changeName setTitle:@"Change Your Name" forState:UIControlStateNormal];
        [changeName setTitle:@"Change Your Name" forState:UIControlStateSelected];
        [changeName setTitle:@"Change Your Name" forState:UIControlStateHighlighted];

    }else{
        [changeName setTitle:@"Set Your Name" forState:UIControlStateNormal];
        [changeName setTitle:@"Set Your Name" forState:UIControlStateSelected];
        [changeName setTitle:@"Set Your Name" forState:UIControlStateHighlighted];
    }
    if([defaults objectForKey:@"Postcode"]){
        [changePostcode setTitle:@"Change Your Postcode" forState:UIControlStateNormal];
        [changePostcode setTitle:@"Change Your Postcode" forState:UIControlStateSelected];
        [changePostcode setTitle:@"Change Your Postcode" forState:UIControlStateHighlighted];
    }else{
        [changePostcode setTitle:@"Set Your Postcode" forState:UIControlStateNormal];
        [changePostcode setTitle:@"Set Your Postcode" forState:UIControlStateSelected];
        [changePostcode setTitle:@"Set Your Postcode" forState:UIControlStateHighlighted];
    }     
    if([defaults objectForKey:@"EmailAddress"]){
        [changeEmail setTitle:@"Change Your Email Address" forState:UIControlStateNormal];
        [changeEmail setTitle:@"Change Your Email Address" forState:UIControlStateSelected];
        [changeEmail setTitle:@"Change Your Email Address" forState:UIControlStateHighlighted];    
    }else{
        [changeEmail setTitle:@"Set Your Email Address" forState:UIControlStateNormal];
        [changeEmail setTitle:@"Set Your Email Address" forState:UIControlStateSelected];
        [changeEmail setTitle:@"Set Your Email Address" forState:UIControlStateHighlighted];  
    }
    if([defaults objectForKey:@"PhoneNumber"]){
        [changePhoneNumber setTitle:@"Change Your Phone Number" forState:UIControlStateNormal];
        [changePhoneNumber setTitle:@"Change Your Phone Number" forState:UIControlStateSelected];
        [changePhoneNumber setTitle:@"Change Your Phone Number" forState:UIControlStateHighlighted];        
    }else{
        [changePhoneNumber setTitle:@"Set Your Phone Number" forState:UIControlStateNormal];
        [changePhoneNumber setTitle:@"Set Your Phone Number" forState:UIControlStateSelected];
        [changePhoneNumber setTitle:@"Set Your Phone Number" forState:UIControlStateHighlighted]; 
    }     
}

- (void)viewDidUnload
{
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction)submitSetName:(id)sender{
    SystemSoundID klick;
    AudioServicesCreateSystemSoundID((CFURLRef)[NSURL fileURLWithPath:[[NSBundle mainBundle]pathForResource:@"button-20" ofType:@"wav"]isDirectory:NO],&klick);
    AudioServicesPlaySystemSound(klick);
    MyDetailsNameViewController *vcName = [[MyDetailsNameViewController alloc] initWithNibName:@"MyDetailsNameViewController" bundle:nil];
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationItem.backBarButtonItem = backButton;
    [backButton release];
    [self.navigationController pushViewController:vcName animated:YES];
    [vcName release];
}

- (IBAction)submitSetPostcode:(id)sender{
    SystemSoundID klick;
    AudioServicesCreateSystemSoundID((CFURLRef)[NSURL fileURLWithPath:[[NSBundle mainBundle]pathForResource:@"button-20" ofType:@"wav"]isDirectory:NO],&klick);
    AudioServicesPlaySystemSound(klick);
    MyDetailsPostcodeViewController *vcPostcode = [[MyDetailsPostcodeViewController alloc] initWithNibName:@"MyDetailsPostcodeViewController" bundle:nil];
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationItem.backBarButtonItem = backButton;
    [backButton release];
    [self.navigationController pushViewController:vcPostcode animated:YES];
    [vcPostcode release];
}

- (IBAction)submitSetEmail:(id)sender{
    SystemSoundID klick;
    AudioServicesCreateSystemSoundID((CFURLRef)[NSURL fileURLWithPath:[[NSBundle mainBundle]pathForResource:@"button-20" ofType:@"wav"]isDirectory:NO],&klick);
    AudioServicesPlaySystemSound(klick);
    MyDetailsEmailViewController *vcEmail = [[MyDetailsEmailViewController alloc] initWithNibName:@"MyDetailsEmailViewController" bundle:nil];
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationItem.backBarButtonItem = backButton;
    [backButton release];
    [self.navigationController pushViewController:vcEmail animated:YES];
    [vcEmail release];
}

- (IBAction)submitSetPhoneNumber:(id)sender{
    SystemSoundID klick;
    AudioServicesCreateSystemSoundID((CFURLRef)[NSURL fileURLWithPath:[[NSBundle mainBundle]pathForResource:@"button-20" ofType:@"wav"]isDirectory:NO],&klick);
    AudioServicesPlaySystemSound(klick);
    MyDetailsPhoneViewController *vcPhone = [[MyDetailsPhoneViewController alloc] initWithNibName:@"MyDetailsPhoneViewController" bundle:nil];
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationItem.backBarButtonItem = backButton;
    [backButton release];
    [self.navigationController pushViewController:vcPhone animated:YES];
    [vcPhone release];

}

@end
