//
//  BinFinder1ViewController.m
//  MyNBC
//
//  Created by Kevin White on 07/12/2011.
//  Copyright 2011 Northampton Borough Council. All rights reserved.
//

#import "BinFinder1ViewController.h"
#import "BinFinder2ViewController.h"
#import "BinFinder3ViewController.h"
#import "BinFinder4ViewController.h"
#import "xmlBinParser.h"

@implementation BinFinder1ViewController

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
    
    awaitingResponse=false;
    
    [[button layer] setCornerRadius:8.0f];
    [[button layer] setMasksToBounds:YES];
    [[button layer] setBorderWidth:1.0f];
    [[button layer] setBackgroundColor:[[UIColor colorWithRed:75/255.0
                                                        green:172/255.0
                                                         blue:198/255.0
                                                        alpha:1.0] CGColor]];
    
    numbers = [[NSArray alloc] initWithObjects:@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"0",nil]; 
    alphabet = [[NSArray alloc] initWithObjects:@"A",@"B",@"C",@"D",@"E",@"F",@"G",@"H",@"I",@"J",@"K",@"L",@"M",@"N",@"O",@"P",@"Q",@"R",@"S",@"T",@"U",@"V",@"W",@"X",@"Y",@"Z",nil]; 
    postCode3=@"1";
    postCode4=@"1";
    postCode5=@"D";
    postCode6=@"E";
    self.navigationItem.title=@"Find Your Bin Collection Day";
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if([defaults objectForKey:@"Postcode"]){
        postCode3=[[defaults objectForKey:@"Postcode"] substringWithRange:NSMakeRange(2,1)];
        postCode4=[[defaults objectForKey:@"Postcode"] substringWithRange:NSMakeRange(3,1)];
        postCode5=[[defaults objectForKey:@"Postcode"] substringWithRange:NSMakeRange(4,1)];
        postCode6=[[defaults objectForKey:@"Postcode"] substringWithRange:NSMakeRange(5,1)];
    }
    
    [postcodePicker selectRow:[numbers indexOfObject: postCode3] inComponent:2 animated:YES];
    [postcodePicker selectRow:[numbers indexOfObject: postCode4] inComponent:3 animated:YES]; 
    [postcodePicker selectRow:[alphabet indexOfObject: postCode5] inComponent:4 animated:YES];
    [postcodePicker selectRow:[alphabet indexOfObject: postCode6] inComponent:5 animated:YES];
    
    [postCode3 retain];
    [postCode4 retain];
    [postCode5 retain];
    [postCode6 retain];

}

- (void)viewDidUnload
{
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)thePickerView {
    return 6;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    
    switch (component)
    {
        case 0:
            return 1;
            break;
        case 1:
            return 1;
            break;
        case 2:
            return 5;
            break;
        case 3:
            return 10;
            break;
        case 4:
            return 26;
            break;
        case 5:
            return 26;
            break;

        default:
            return 0;
    }
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    switch (component)
    {
        case 0:
            return @"N";
            break;
        case 1:
            return @"N";
            break;
        case 2:
            return [numbers objectAtIndex:row];
            break;
        case 3:
            return [numbers objectAtIndex:row];
            break;
        case 4:            
            return [alphabet objectAtIndex:row];
            break;
        case 5:
            return [alphabet objectAtIndex:row];
            break;
        default:
            return @"";
    }
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    switch (component)
    {
        case 2:
            postCode3 = [numbers objectAtIndex:row];
            break;
        case 3:
            postCode4 = [numbers objectAtIndex:row];
            break;
        case 4:            
            postCode5 = [alphabet objectAtIndex:row];
            break;
        case 5:
            postCode6 = [alphabet objectAtIndex:row];
            break;            
        default:
            break;
    }

}

-(IBAction)submitPostCode:(id)sender{
    if(!awaitingResponse){
        SystemSoundID klick;
        AudioServicesCreateSystemSoundID((CFURLRef)[NSURL fileURLWithPath:[[NSBundle mainBundle]pathForResource:@"button-20" ofType:@"wav"]isDirectory:NO],&klick);
        AudioServicesPlaySystemSound(klick);
        UIActivityIndicatorView  *indicator = [[[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge] autorelease];
        indicator.frame=CGRectMake(132, 123, 50, 50);
        indicator.tag  = 1;
        [self.view addSubview:indicator];
        [indicator startAnimating];
       awaitingResponse=true;
       NSString *temp1 = @"NN";
       NSString *temp2 = [temp1 stringByAppendingString:postCode3];
       NSString *temp3 = [temp2 stringByAppendingString:postCode4];
       NSString *temp4 = [temp3 stringByAppendingString:postCode5];
       NSString *postCode = [temp4 stringByAppendingString:postCode6];
       NSString *preURL = @"http:selfserve.northampton.gov.uk/mycouncil/BinRoundFinder?postcode=";
       NSString *postURL = @"&mobileApp=true";
       NSString *url1 = [preURL stringByAppendingString:postCode];
       NSString *url2 = [url1 stringByAppendingString:postURL];
       NSURLRequest *binXML=[NSURLRequest requestWithURL:[NSURL URLWithString:url2]
                                          cachePolicy:NSURLRequestUseProtocolCachePolicy
                                          timeoutInterval:30.0];
       nbcBinConnection=[[NSURLConnection alloc] initWithRequest:binXML delegate:self];
       if (nbcBinConnection) {
           xmlData = [[NSMutableData data] retain];
       } else {
        [self requestFailed];
       }  
    }
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    [xmlData setLength:0];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [xmlData appendData:data];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    awaitingResponse=false;
    UIActivityIndicatorView *currentIndicator = (UIActivityIndicatorView *)[self.view viewWithTag:1];
    [currentIndicator removeFromSuperview];
    xmlBinParser *xmlParser = [[[xmlBinParser alloc]init]autorelease];
    [xmlParser parseThis:[[[NSString alloc] initWithData:xmlData encoding:NSUTF8StringEncoding]autorelease]];
    [connection release];
    [xmlData release];
    NSString *temp1 = @"NN";
    NSString *temp2 = [temp1 stringByAppendingString:postCode3];
    NSString *temp3 = [temp2 stringByAppendingString:postCode4];
    NSString *temp4 = [temp3 stringByAppendingString:postCode5];
    NSString *postCode = [temp4 stringByAppendingString:postCode6];
    switch ([[xmlParser xmlBinEntries]count]) {
        case 0:
        {
            BinFinder3ViewController *vcBin3 = [[BinFinder3ViewController alloc] initWithNibName:@"BinFinder3ViewController" bundle:nil postcodeParam:postCode];
            UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStylePlain target:nil action:nil];
            self.navigationItem.backBarButtonItem = backButton;
            [backButton release];
            [self.navigationController pushViewController:vcBin3 animated:YES];
            [vcBin3 release];
            break;
        }
        case 1:
        {
            BinFinder4ViewController *vcBin4 = [[BinFinder4ViewController alloc]initWithNibName:@"BinFinder4ViewController" bundle:nil data:[xmlParser xmlBinEntries] arrayEntry:0  postcodeParam:postCode];
            UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStylePlain target:nil action:nil];
            self.navigationItem.backBarButtonItem = backButton;
            [backButton release];
            [self.navigationController pushViewController:vcBin4 animated:YES];
            [vcBin4 release];
            break;
        }
        default:
        {
            BinFinder2ViewController *vcBin2 = [[BinFinder2ViewController alloc] initWithNibName:@"BinFinder2ViewController" bundle:nil data:[xmlParser xmlBinEntries] postcodeParam:postCode];
            UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStylePlain target:nil action:nil];
            self.navigationItem.backBarButtonItem = backButton;
            [backButton release];
            [self.navigationController pushViewController:vcBin2 animated:YES];
            [vcBin2 release];
            break;
        }
    }
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error{
    [self requestFailed];
    [connection release];
}

- (void)requestFailed{
    awaitingResponse=false;
    UIActivityIndicatorView *currentIndicator = (UIActivityIndicatorView *)[self.view viewWithTag:1];
    [currentIndicator removeFromSuperview]; 
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" 
                                                    message:@"Sorry, this service is currently unavailable. Please try again later."
                                                   delegate:nil 
                                          cancelButtonTitle:@"OK" 
                                          otherButtonTitles: nil];
    [alert show];
    [alert release];

}

@end
