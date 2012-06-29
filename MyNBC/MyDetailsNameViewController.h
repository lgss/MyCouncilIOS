//
//  MyDetailsNameViewController.h
//  MyNBC
//
//  Created by Kevin White on 22/02/2012.
//  Copyright 2012 Northampton Borough Council. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface MyDetailsNameViewController : UIViewController<UITextFieldDelegate> {
    bool fromReport;
    bool fromContact;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil fromReport:(bool)paramFromReport fromContact:(bool)paramFromContact;

@property (nonatomic, retain) IBOutlet UITextField *textView;

@end
