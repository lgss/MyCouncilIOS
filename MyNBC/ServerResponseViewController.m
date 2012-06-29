//
//  ServerResponseViewController.m
//  MyNBC
//
//  Created by Kevin White on 30/04/2012.
//  Copyright 2012 Northampton Borough Council. All rights reserved.
//

#import "ServerResponseViewController.h"


@implementation ServerResponseViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil fromReport:(bool)paramFromReport fromContact:(bool)paramFromContact
{
    fromReport=paramFromReport;
    fromContact=paramFromContact;
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (void)dealloc
{
    [super dealloc];
    [xmlParser release];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];

}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [[retryButton layer] setCornerRadius:8.0f];
    [[retryButton layer] setMasksToBounds:YES];
    [[retryButton layer] setBorderWidth:1.0f];
    [[retryButton layer] setBackgroundColor:[[UIColor colorWithRed:75/255.0
                                                      green:172/255.0
                                                      blue:198/255.0
                                                      alpha:1.0] CGColor]];
    
    self.navigationItem.hidesBackButton = YES;
    [self submit];
}

-(void)submit{
    [retryButton setHidden:TRUE];
    self.navigationItem.title=@"Please Wait";
    
    UIActivityIndicatorView  *indicator = [[[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge] autorelease];
    indicator.frame=CGRectMake(132, 160, 50, 50);
    indicator.tag  = 1;
    [self.view addSubview:indicator];
    [indicator startAnimating];
    if(fromContact){
        [self submitContact];   
    }else{
        [self submitReport];
    }
   
}

-(void)submitReport{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    problemLocation.latitude=[defaults doubleForKey:@"ProblemLatitude"];
    problemLocation.longitude=[defaults doubleForKey:@"ProblemLongitude"];    
    CLGeocoder *geoCoder = [[[CLGeocoder alloc] init]autorelease];    
    [geoCoder reverseGeocodeLocation:[[[CLLocation alloc] initWithLatitude:problemLocation.latitude longitude:problemLocation.longitude]autorelease] completionHandler:
     ^(NSArray* placemarks, NSError* error){
         if ([placemarks count] > 0)
         {
             NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
             [defaults setObject:[[placemarks objectAtIndex:0]thoroughfare] forKey:@"ProblemLocation"];    
             [defaults synchronize];
             [self submitReport2];
          }
     }];
}

-(void)submitReport2{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    //NSString *url = @"http:localhost:8080/mycouncil/CreateCall"; 
    //NSString *url = @"http:selfserve.northampton.gov.uk/mycouncil-test/CreateCall"; 
    NSString *url = @"http:selfserve.northampton.gov.uk/mycouncil/CreateCall"; 
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url]]; 
    [request setHTTPMethod:@"POST"]; 
    [request setTimeoutInterval:240];
    [request addValue:@"image/png" forHTTPHeaderField: @"Content-Type"]; 
    [request addValue:@"myNBC" forHTTPHeaderField: @"dataSource"];
    [request addValue:[defaults objectForKey:@"DeviceID"] forHTTPHeaderField: @"DeviceID"];
    [request addValue:[defaults objectForKey:@"ProblemNumber"] forHTTPHeaderField: @"ProblemNumber"];
    [request addValue:[defaults objectForKey:@"ProblemLatitude"] forHTTPHeaderField: @"ProblemLatitude"];
    [request addValue:[defaults objectForKey:@"ProblemLongitude"] forHTTPHeaderField: @"ProblemLongitude"];
    [request addValue:[[defaults objectForKey:@"ProblemDescription"] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding] forHTTPHeaderField: @"ProblemDescription"];
    [request addValue:[defaults objectForKey:@"ProblemLocation"] forHTTPHeaderField: @"ProblemLocation"];
    if([[defaults objectForKey:@"ReplyBy"] isEqualToString:@"none"]){
      [request addValue:@"" forHTTPHeaderField: @"ProblemEmail"]; 
      [request addValue:@"" forHTTPHeaderField: @"ProblemPhone"];
    }
    if([[defaults objectForKey:@"ReplyBy"] isEqualToString:@"email"]){
        [request addValue:[defaults objectForKey:@"EmailAddress"] forHTTPHeaderField: @"ProblemEmail"]; 
        [request addValue:@"" forHTTPHeaderField: @"ProblemPhone"];
    }
    if([[defaults objectForKey:@"ReplyBy"] isEqualToString:@"phone"]){
        [request addValue:@"" forHTTPHeaderField: @"ProblemEmail"]; 
        [request addValue:[defaults objectForKey:@"PhoneNumber"] forHTTPHeaderField: @"ProblemPhone"];
    }
    if([defaults boolForKey:@"UseImage"]){
        [request addValue:@"true" forHTTPHeaderField: @"includesImage"];
        NSData *imageData = [defaults objectForKey:@"ImageData"];
        NSMutableData *body = [NSMutableData data];       
        [body appendData:[NSData dataWithData:imageData]]; 
        [request setHTTPBody:body]; 
    }else{
        [request addValue:@"false" forHTTPHeaderField: @"includesImage"];
    }
    serverConnection=[[NSURLConnection alloc] initWithRequest:request delegate:self];
    if (serverConnection) {
        serverResponse = [[NSMutableData data] retain];
    } else {
        [self submitFailed];
    }        
}

-(void)submitContact{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults]; 
    //NSString *url = @"http:localhost:8080/mycouncil/CreateContact";
    //NSString *url = @"http:selfserve.northampton.gov.uk/mycouncil-test/CreateContact";
    NSString *url = @"http:selfserve.northampton.gov.uk/mycouncil/CreateContact";
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url]]; 
    [request setHTTPMethod:@"POST"]; 
    [request setTimeoutInterval:240];
    [request addValue:@"myNBC" forHTTPHeaderField: @"dataSource"];
    [request addValue:[defaults objectForKey:@"DeviceID"] forHTTPHeaderField: @"DeviceID"];
    [request addValue:[defaults objectForKey:@"ContactServiceArea"] forHTTPHeaderField: @"service"];
    [request addValue:[defaults objectForKey:@"ContactSection"] forHTTPHeaderField: @"team"];
    [request addValue:[defaults objectForKey:@"ContactReason"] forHTTPHeaderField: @"reason"];
    [request addValue:[defaults objectForKey:@"CustomerName"] forHTTPHeaderField: @"name"];
    [request addValue:[defaults objectForKey:@"Postcode"] forHTTPHeaderField: @"Postcode"];
    if([[defaults objectForKey:@"ReplyBy"] isEqualToString:@"email"]){
        [request addValue:[defaults objectForKey:@"EmailAddress"] forHTTPHeaderField: @"emailAddress"]; 
        [request addValue:@"" forHTTPHeaderField: @"PhoneNumber"];
    }
    if([[defaults objectForKey:@"ReplyBy"] isEqualToString:@"phone"]){
        [request addValue:@"" forHTTPHeaderField: @"EmailAddress"]; 
        [request addValue:[defaults objectForKey:@"PhoneNumber"] forHTTPHeaderField: @"phoneNumber"];
    }
    [request addValue:[[defaults objectForKey:@"ContactText"] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding] forHTTPHeaderField: @"details"];
    serverConnection=[[NSURLConnection alloc] initWithRequest:request delegate:self];
    if (serverConnection) {
        serverResponse = [[NSMutableData data] retain];
    } else {
        [self submitFailed];
    }        
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error{
    [self submitFailed];
    [connection release];

}

- (void)submitFailed{
    UIActivityIndicatorView *currentIndicator = (UIActivityIndicatorView *)[self.view viewWithTag:1];
    [currentIndicator removeFromSuperview];
    self.navigationItem.title=@"Sorry";
    if(fromContact){
       labelCallNumberText.text=@"Your contact could not be sent"; 
    }else{
       labelCallNumberText.text=@"The problem could not be reported";
    }
    labelSlaDateText.text=@"Please try again";
    [retryButton setHidden:FALSE]; 
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    [serverResponse setLength:0];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [serverResponse appendData:data];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    [self parseThis:[[[NSString alloc] initWithData:serverResponse encoding:NSUTF8StringEncoding]autorelease]];
    UIActivityIndicatorView *currentIndicator = (UIActivityIndicatorView *)[self.view viewWithTag:1];
    [currentIndicator removeFromSuperview];
     [connection release];
}


- (void)viewDidUnload
{
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)parseThis:(NSString *)xml 
{
    xmlParser = [[NSXMLParser alloc] initWithData:[xml dataUsingEncoding:NSUTF8StringEncoding]];
    [xmlParser setDelegate:self];
    [xmlParser setShouldProcessNamespaces:NO];
    [xmlParser setShouldReportNamespacePrefixes:NO];
    [xmlParser setShouldResolveExternalEntities:NO];
    [xmlParser parse];
    
}

#pragma mark NSXMLParserDelegate methods

- (void)parserDidStartDocument:(NSXMLParser *)parser 
{
    currentElement = nil;
}

- (void)parser:(NSXMLParser *)parser parseErrorOccurred:(NSError *)parseError 
{
    [self submitFailed];
}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName 
  namespaceURI:(NSString *)namespaceURI 
 qualifiedName:(NSString *)qName 
    attributes:(NSDictionary *)attributeDict
{
    [currentElement release];
    currentElement = [elementName copy];
    
    if ([currentElement isEqualToString:@"result"])
    {
        [result release];
        result = [[NSMutableString alloc] init];
    }
    else if ([currentElement isEqualToString:@"callNumber"])
    {
        [callNumber release];
        callNumber = [[NSMutableString alloc] init];
    }
    else if ([currentElement isEqualToString:@"slaDate"])
    {
        [slaDate release];
        slaDate = [[NSMutableString alloc] init];
    }
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
    if ([currentElement isEqualToString:@"result"]) 
    {
        [result appendString:string];
    } 
    else if ([currentElement isEqualToString:@"callNumber"]) 
    {
        [callNumber appendString:string];
    } 
    else if ([currentElement isEqualToString:@"slaDate"]) 
    {
        [slaDate appendString:string];
    } 
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName 
  namespaceURI:(NSString *)namespaceURI 
 qualifiedName:(NSString *)qName
{
    
    if ([elementName isEqualToString:@"slaDate"]) 
    {
        self.navigationItem.title=@"Thank You";
        labelCallNumberText.text=@"Your call number is";
        labelCallNumber.text=callNumber;
        if(fromContact){
            if([slaDate isEqualToString:@"asap"]){
                labelSlaDateText.text=@"And will be responded to";
            }else{
                labelSlaDateText.text=@"And will be responded to by";
            }
        }else{
            if([slaDate isEqualToString:@"asap"]){
                labelSlaDateText.text=@"And will be resolved";
            }else{
                labelSlaDateText.text=@"And will be resolved by";
            }
        }
        labelSlaDate.text=slaDate;  
    }    
} 

- (NSString *)cleanseString:(NSMutableString *)inputString{
    NSString *cleansedString = [inputString stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    cleansedString = [cleansedString stringByReplacingOccurrencesOfString:@"  " withString:@""];
    return cleansedString; 
}

- (IBAction)retrySubmit{
    SystemSoundID klick;
    AudioServicesCreateSystemSoundID((CFURLRef)[NSURL fileURLWithPath:[[NSBundle mainBundle]pathForResource:@"button-20" ofType:@"wav"]isDirectory:NO],&klick);
    AudioServicesPlaySystemSound(klick);
    labelSlaDateText.text=@"";
    labelCallNumberText.text=@"";
    [self submit];
}

@end
