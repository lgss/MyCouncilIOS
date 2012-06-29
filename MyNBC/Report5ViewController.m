//
//  Report5ViewController.m
//  MyNBC
//
//  Created by Kevin White on 04/05/2012.
//  Copyright 2012 Northampton Borough Council. All rights reserved.
//

#import "Report5ViewController.h"
#import "Report2ViewController.h"

@implementation Report5ViewController
@synthesize mapView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        locationSet=false;
    }
    return self;
}

- (void)dealloc
{
    [locationManager stopUpdatingLocation];
    [locationManager setDelegate:nil];
    [locationManager release];
    [mapView setDelegate:nil];
    [mapView release];
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
    
    [[button layer] setCornerRadius:8.0f];
    [[button layer] setMasksToBounds:YES];
    [[button layer] setBorderWidth:1.0f];
    [[button layer] setBackgroundColor:[[UIColor colorWithRed:75/255.0
                                                        green:172/255.0
                                                         blue:198/255.0
                                                        alpha:1.0] CGColor]];
    
    showNormalMap=true;
    
    self.navigationItem.title=@"Put the pin at the problem";
    problemLocation.latitude=52.23717;
    problemLocation.longitude=-0.894828;
    
    span.latitudeDelta=0.05;  
    span.longitudeDelta=0.05;
    
    region.span=span;
    region.center=problemLocation;
    
    [mapView setRegion:region animated:TRUE];
    [mapView regionThatFits:region];
     
    locationManager = [[CLLocationManager alloc] init];
    locationManager.delegate = self;
    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    [locationManager startUpdatingLocation];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction)setLocation {
    SystemSoundID klick;
	AudioServicesCreateSystemSoundID((CFURLRef)[NSURL fileURLWithPath:[[NSBundle mainBundle]pathForResource:@"button-20" ofType:@"wav"]isDirectory:NO],&klick);
	AudioServicesPlaySystemSound(klick);
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *latitude = [[[NSString alloc] initWithFormat:@"%g", problemLocation.latitude]autorelease];
    NSString *longitude = [[[NSString alloc] initWithFormat:@"%g", problemLocation.longitude]autorelease];
    [defaults setObject:latitude forKey:@"ProblemLatitude"];
    [defaults setObject:longitude forKey:@"ProblemLongitude"];
    [defaults synchronize]; 
    Report2ViewController *vcReport2 = [[Report2ViewController alloc] initWithNibName:@"Report2ViewController" bundle:nil];
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationItem.backBarButtonItem = backButton;
    [backButton release];
    [self.navigationController pushViewController:vcReport2 animated:YES];
    [vcReport2 release];
}

-(MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation{
    MKPinAnnotationView *pin = [[[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"currentloc"]autorelease];
    pin.animatesDrop = YES;
    pin.draggable = YES;
    [pin setSelected:YES];
    return pin;
}

- (void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)annotationView didChangeDragState:(MKAnnotationViewDragState)newState fromOldState:(MKAnnotationViewDragState)oldState{
    if (newState == MKAnnotationViewDragStateNone && oldState == MKAnnotationViewDragStateEnding) {
        problemLocation.latitude=annotationView.annotation.coordinate.latitude;
        problemLocation.longitude=annotationView.annotation.coordinate.longitude;
    }
}

- (void)locationManager:(CLLocationManager *)manager
    didUpdateToLocation:(CLLocation *)newLocation
           fromLocation:(CLLocation *)oldLocation
{
    if(!locationSet){
        locationSet=true;
        problemLocation=newLocation.coordinate;
        region.span.latitudeDelta=0.005;
        region.span.longitudeDelta=0.005;
        region.center=problemLocation;
        [mapView setRegion:region animated:TRUE];
        [mapView regionThatFits:region];
        MKPointAnnotation *annotation = [[[MKPointAnnotation alloc] init]autorelease];
        [annotation setCoordinate:problemLocation];
        [self.mapView addAnnotation:annotation];
    }
}

- (void)locationManager:(CLLocationManager *)manager
       didFailWithError:(NSError *)error
{
    problemLocation.latitude=52.23717;
    problemLocation.longitude=-0.894828;
    region.span.latitudeDelta=0.005;
    region.span.longitudeDelta=0.005;
    region.center=problemLocation;
    [mapView setRegion:region animated:TRUE];
    [mapView regionThatFits:region];
    MKPointAnnotation *annotation = [[[MKPointAnnotation alloc] init]autorelease];
    [annotation setCoordinate:problemLocation];
    [self.mapView addAnnotation:annotation];
}

-(IBAction) segmentedControlIndexChanged{
    if(showNormalMap){
        [mapView setMapType:MKMapTypeSatellite];
        showNormalMap=false;
    }else{
        [mapView setMapType:MKMapTypeStandard];
        showNormalMap=true;
    }
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

@end
