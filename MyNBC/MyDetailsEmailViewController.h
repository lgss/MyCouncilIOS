//
//  MyDetailsEmailViewController.h
//  MyNBC
//
//  Created by Kevin White on 23/02/2012.
//  Copyright 2012 Northampton Borough Council. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyDetailsEmailViewController : UIViewController<UITextFieldDelegate> {
    bool fromReport;
    bool fromContact;
}

@property (nonatomic, retain) IBOutlet UITextField *textView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil fromReport:(bool)paramFromReport fromContact:(bool)paramFromContact;

@end
