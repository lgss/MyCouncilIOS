//
//  WebViewController.m
//  MyNBC
//
//  Created by Kevin White on 24/11/2011.
//  Copyright 2011 Northampton Borough Council. All rights reserved.
//

#import "WebViewController.h"

@implementation WebViewController

@synthesize website;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil url:(NSString *)paramURL homePage:(bool)paramHomePage
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        websiteUrl=paramURL;
        homePage=paramHomePage;
     }
    return self;
}

- (void)dealloc
{
    [website setDelegate:nil];
    [website stopLoading];
    [website release];
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
    if(homePage){
        self.navigationItem.hidesBackButton = YES;
    }
    NSURL *url = [[NSURL alloc] initWithString:websiteUrl];
    NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
    website = [[UIWebView alloc] initWithFrame:CGRectMake(0,0,320,370)];
    [website setBackgroundColor:[UIColor blackColor]];
    [website setOpaque:NO];
    [website setDelegate:self];
    [[self view] addSubview:[self website]];
    UIActivityIndicatorView  *indicator = [[[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge] autorelease];
    indicator.frame=CGRectMake(132, 160, 50, 50);
    indicator.tag  = 1;
    [self.view addSubview:indicator];
    [indicator startAnimating];  
    [website loadRequest:requestObj];
    [url release];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    UIActivityIndicatorView *currentIndicator = (UIActivityIndicatorView *)[self.view viewWithTag:1];
    [currentIndicator removeFromSuperview]; 
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    if ([error code] != -999) {
        UIActivityIndicatorView *currentIndicator = (UIActivityIndicatorView *)[self.view viewWithTag:1];
        [currentIndicator removeFromSuperview]; 
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" 
                                                        message:@"Sorry, this page is currently unavailable"
                                                       delegate:nil 
                                              cancelButtonTitle:@"OK" 
                                              otherButtonTitles: nil];
        [alert show];
        [alert release];
    }
}

- (void)viewWillDisappear:(BOOL)animated{
      [super viewWillDisappear:animated];
//    UIActivityIndicatorView *currentIndicator = (UIActivityIndicatorView *)[self.view viewWithTag:1];
//    [currentIndicator removeFromSuperview]; 
//    [website stopLoading];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
