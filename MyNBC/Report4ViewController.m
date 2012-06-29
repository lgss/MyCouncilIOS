//
//  Report4ViewController.m
//  MyNBC
//
//  Created by Kevin White on 27/04/2012.
//  Copyright 2012 Northampton Borough Council. All rights reserved.
//

#import "Report4ViewController.h"
#import "ResponseViewController.h"

@implementation Report4ViewController

@synthesize textView;

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
    self.navigationItem.title=@"Any details?";
    UIBarButtonItem *sendButton = [[UIBarButtonItem alloc] 
                                   initWithTitle:@"Next"                                            
                                   style:UIBarButtonItemStyleBordered 
                                   target:self 
                                   action:@selector(setDetails:)];
    self.navigationItem.rightBarButtonItem = sendButton;
    [sendButton release];
    textView.returnKeyType = UIReturnKeyDone;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)viewWillAppear:(BOOL)flag {
    [super viewWillAppear:flag];
   [textView becomeFirstResponder];
}

- (IBAction)setDetails:(id)sender{
    SystemSoundID klick;
	AudioServicesCreateSystemSoundID((CFURLRef)[NSURL fileURLWithPath:[[NSBundle mainBundle]pathForResource:@"button-20" ofType:@"wav"]isDirectory:NO],&klick);
	AudioServicesPlaySystemSound(klick);
    [self moveOnToNextScreen];
}

- (BOOL) textView:(UITextView *)paramTextView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    if([text isEqualToString:@"\n"]){
        [paramTextView resignFirstResponder];
        [self moveOnToNextScreen];
        return NO;
    }else{
        return YES;
    }
}

-(void)moveOnToNextScreen{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];    
    [defaults setObject:textView.text forKey:@"ProblemDescription"];    
    [defaults synchronize]; 
    ResponseViewController *vcResponse = [[ResponseViewController alloc] initWithNibName:@"ResponseViewController" bundle:nil fromReport:true fromContact:false];
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationItem.backBarButtonItem = backButton;
    [backButton release];
    [self.navigationController pushViewController:vcResponse animated:YES];
    [vcResponse release];    
}


@end
