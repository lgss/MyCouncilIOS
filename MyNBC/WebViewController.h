//
//  WebViewController.h
//  MyNBC
//
//  Created by Kevin White on 24/11/2011.
//  Copyright 2011 Northampton Borough Council. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface WebViewController : UIViewController<UIWebViewDelegate> {
    IBOutlet UIWebView  *website;
    NSString *websiteUrl;
    bool homePage;
}

@property (nonatomic, retain) IBOutlet UIWebView *website;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil url:(NSString *)paramURL homePage:(bool)paramHomePage;

@end
