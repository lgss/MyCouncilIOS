//
//  SocialViewController.m
//
//  Created by Kevin White on 18/11/2011.
//  Copyright 2011 Northampton Borough Council. All rights reserved.
//

#import "SocialViewController.h"
#import "SocialEntry.h"
#import "rssParser.h"
#import "WebViewController.h"
#import "xmlContactsParser.h"
#import "xmlProblemsParser.h"
#import "Reachability.h"

@implementation SocialViewController

@synthesize socialEntries = _socialEntries;
@synthesize nbcRSSData = _nbcRSSData;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
    }
    return self;
}

- (void)dealloc
{
    [super dealloc];
    [_socialEntries release];
    _socialEntries = nil;

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    Reachability *connectionMonitor = [Reachability reachabilityForInternetConnection];
    [[NSNotificationCenter defaultCenter]
     addObserver: self
     selector: @selector(inetAvailabilityChanged:)
     name:  kReachabilityChangedNotification
     object: connectionMonitor];
    
    networkConnection = [connectionMonitor currentReachabilityStatus] != NotReachable;
    
    if(!networkConnection){
        UIAlertView  *alert = [[UIAlertView alloc] initWithTitle:@""
                                                         message:@"MyNBC requires network connectivity. Please try again later."
                                                        delegate:self cancelButtonTitle:@"OK" 
                                               otherButtonTitles:nil];
        
        [alert show];
        [alert release];
    }else{
        onScreen=true;
        UIActivityIndicatorView  *indicator = [[[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge] autorelease];
        indicator.frame=CGRectMake(132, 160, 50, 50);
        indicator.tag  = 1;
        [self.view addSubview:indicator];
        [indicator startAnimating];
        self.socialEntries = [NSMutableArray array];
        NSURLRequest *nbcRSS=[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://selfserve.northampton.gov.uk/mynbc/socialFeed.xml"]
                                           cachePolicy:NSURLRequestUseProtocolCachePolicy
                                           timeoutInterval:30.0];
        nbcConnection=[[NSURLConnection alloc] initWithRequest:nbcRSS delegate:self];
        [nbcConnection retain];
        if (nbcConnection) {
            _nbcRSSData = [[NSMutableData data] retain];
        } else {
            [self requestFailed];
        }
    }
}

- (void)viewDidUnload
{
    [super viewDidUnload];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    onScreen=false;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_socialEntries count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
       cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease]; 
    }
        
    SocialEntry *entry = [_socialEntries objectAtIndex:indexPath.row];
    
    NSCalendar *sysCalendar = [NSCalendar currentCalendar];
    unsigned int unitFlags = NSHourCalendarUnit | NSMinuteCalendarUnit | NSDayCalendarUnit | NSMonthCalendarUnit;
    NSDateComponents *dateDifferenceDetails = [sysCalendar components:unitFlags fromDate:entry.entryDate  toDate:[NSDate date ]  options:0];
        
    NSString *dateDescription1=@"";
    NSString *dateDescription2=@"";
    if([dateDifferenceDetails month]==0){
        switch([dateDifferenceDetails day]){
            case 0:
                if([dateDifferenceDetails hour]>0){
                    if([dateDifferenceDetails hour]==1){
                        dateDescription1 = [NSString stringWithFormat:@"%d", [dateDifferenceDetails hour]];
                        dateDescription2 = [dateDescription1 stringByAppendingString:@" hour ago, via "];
                    }else{
                        dateDescription1 = [NSString stringWithFormat:@"%d", [dateDifferenceDetails hour]];
                        dateDescription2 = [dateDescription1 stringByAppendingString:@" hours ago, via "];
                    }                   
                }else if([dateDifferenceDetails minute]>0){
                    if([dateDifferenceDetails minute]==1){
                        dateDescription1 = [NSString stringWithFormat:@"%d", [dateDifferenceDetails minute]];
                        dateDescription2 = [dateDescription1 stringByAppendingString:@" minute ago, via "];
                    }else{
                        dateDescription1 = [NSString stringWithFormat:@"%d", [dateDifferenceDetails minute]];
                        dateDescription2 = [dateDescription1 stringByAppendingString:@" minutes ago, via "];
                    }
                }else{
                   dateDescription2 = @"Just now, via ";  
                }
                break;  
            case 1:
                dateDescription1 = [NSString stringWithFormat:@"%d", [dateDifferenceDetails day]];
                dateDescription2 = [dateDescription1 stringByAppendingString:@" day ago, via "];
                break;            
            default:
                dateDescription1 = [NSString stringWithFormat:@"%d", [dateDifferenceDetails day]];
                dateDescription2 = [dateDescription1 stringByAppendingString:@" days ago, via "];               
                break;
        }
    }else{
        dateDescription2 = @"Over a month ago, via ";
    }
    NSString *dateDescription3=@"";
    if([entry.entryType isEqualToString:@"nbc"]){
       dateDescription3=[dateDescription2 stringByAppendingString:@"Website"];  
    }
    if([entry.entryType isEqualToString:@"tweet"]){
        dateDescription3=[dateDescription2 stringByAppendingString:@"Twitter"]; 
    }
    if([entry.entryType isEqualToString:@"facebook"]){
        dateDescription3=[dateDescription2 stringByAppendingString:@"Facebook"];  
    }
    
    cell.textLabel.text = entry.entryTitle; 
    
    cell.textLabel.numberOfLines = 4;
    NSString *imageName=@"57x57_rounded.png";
    if([entry.entryTypeDesc isEqualToString:@"NorthamptonBC"]){
        imageName=@"57x57_rounded.png";
    }
    if([entry.entryTypeDesc isEqualToString:@"davidmackintosh"]){
        imageName=@"57x57_DM.png";
    }
    if([entry.entryTypeDesc isEqualToString:@"DavidKennedyNBC"]){
        imageName=@"57x57_DK.png";
    }
    if([entry.entryTypeDesc isEqualToString:@"LoveNorthampton"]){
        imageName=@"57x57_love.png";
    }
    cell.imageView.image = [UIImage imageNamed:imageName];
    if([entry.entryType isEqualToString:@"nbc"]){
        cell.detailTextLabel.text = dateDescription3;
    }else{
        cell.detailTextLabel.text = dateDescription3;
    }
    cell.accessoryType=UITableViewCellAccessoryDetailDisclosureButton;
    
    return cell;
}

- (CGFloat) tableView:(UITableView *)aTableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return  (44.0 + (5 - 1) * 19.0);
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    [_nbcRSSData setLength:0];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [_nbcRSSData appendData:data];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    UIActivityIndicatorView *currentIndicator = (UIActivityIndicatorView *)[self.view viewWithTag:1];
    [currentIndicator removeFromSuperview];
    rssParser *nbcParser = [[[rssParser alloc]init]autorelease];
    [nbcParser parseThis:[[[NSString alloc] initWithData:_nbcRSSData encoding:NSUTF8StringEncoding]autorelease]];
    [connection release];
    [_nbcRSSData release];
    [_socialEntries addObjectsFromArray:[nbcParser rssEntries]];
    UITableView *socialTable = [[UITableView alloc] init];
    socialTable.indicatorStyle = UIScrollViewIndicatorStyleWhite;
    [socialTable setDelegate:self];
    [socialTable setDataSource:self];
    [socialTable setBackgroundColor:[UIColor blackColor]];
    [socialTable setSeparatorColor:[UIColor grayColor]];
    [self setView:socialTable];
    [socialTable release];
    if([_socialEntries count]==0){
        [self requestFailed];
    }
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    cell.textLabel.textColor = [UIColor whiteColor];
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self entrySelected:indexPath];
}

- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath{
    [self entrySelected:indexPath];
}

-(void)entrySelected:(NSIndexPath *)indexPath{
    SocialEntry *selectedEntry = (SocialEntry *)[self.socialEntries objectAtIndex:indexPath.row];
    WebViewController *webViewController = [[[WebViewController alloc] initWithNibName:@"WebViewController" bundle:nil url:[selectedEntry entryUrl] homePage:false]autorelease];
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationItem.backBarButtonItem = backButton;
    [backButton release];
    [self.navigationController  pushViewController:webViewController animated:YES]; 
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error{
    [self requestFailed];
    [connection release];
}

- (void)requestFailed{
    if(onScreen){
       UIActivityIndicatorView *currentIndicator = (UIActivityIndicatorView *)[self.view viewWithTag:1];
       [currentIndicator removeFromSuperview];
       UIAlertView  *alert = [[UIAlertView alloc] initWithTitle:@""
                                                         message:@"The social feed is currently unavailable. Please try again later."
                                                        delegate:self cancelButtonTitle:@"OK" 
                                               otherButtonTitles:nil];
        
       [alert show];
       [alert release];
    }
}
@end
