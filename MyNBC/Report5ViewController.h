//
//  Report5ViewController.h
//  MyNBC
//
//  Created by Kevin White on 04/05/2012.
//  Copyright 2012 Northampton Borough Council. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <QuartzCore/QuartzCore.h>
#import <AudioToolbox/AudioToolbox.h>

@interface Report5ViewController : UIViewController<MKMapViewDelegate,CLLocationManagerDelegate> {
    MKMapView *mapView;
    CLLocationCoordinate2D problemLocation;
    MKCoordinateRegion region;
    MKCoordinateSpan span;
    CLLocationManager *locationManager;
    bool locationSet;
    bool showNormalMap;
    IBOutlet UIButton *button;
}
@property (nonatomic, retain) IBOutlet MKMapView *mapView;

-(IBAction)setLocation;
-(IBAction) segmentedControlIndexChanged;

@end
