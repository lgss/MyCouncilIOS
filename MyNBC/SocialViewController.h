//
//  SocialViewController.h
//  TabNavDemo
//
//  Created by Kevin White on 18/11/2011.
//  Copyright 2011 Northampton Borough Council. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <SystemConfiguration/SystemConfiguration.h>

@interface SocialViewController : UITableViewController<UIAlertViewDelegate> {
    bool onScreen;
    NSURLConnection *nbcConnection;
    bool networkConnection;
}

@property (retain) NSMutableArray *socialEntries;
@property (retain) NSMutableData *nbcRSSData;

- (void)requestFailed;

@end
