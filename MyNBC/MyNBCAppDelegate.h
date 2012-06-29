//
//  MyNBCAppDelegate.h
//  MyNBC
//
//  Created by Kevin White on 21/11/2011.
//  Copyright 2011 Northampton Borough Council. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface MyNBCAppDelegate : NSObject <UIApplicationDelegate, UITabBarControllerDelegate> {
    
    IBOutlet UINavigationController *navigation1Controller;
    IBOutlet UINavigationController *navigation2Controller;
    IBOutlet UINavigationController *navigation3Controller;
    IBOutlet UINavigationController *navigation4Controller;
    IBOutlet UINavigationController *navigation5Controller;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;

@property (nonatomic, retain) IBOutlet UITabBarController *tabBarController;

@end
