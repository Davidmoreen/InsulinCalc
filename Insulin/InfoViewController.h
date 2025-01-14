//
//  InfoViewController.h
//  Insulin
//
//  Created by David Moreen on 10/7/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface InfoViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate>
{
	id delegate;
	
	UINavigationBar *navBar;
	UITableView *tableView;
	UIBarButtonItem *done;
	UIBarButtonItem *cancel;
	
	NSString *subtractBy, *divideBy, *carbDivision, *footerText;
}

@property (nonatomic, retain) id delegate;

@property (nonatomic, retain) UINavigationBar *navBar;
@property (nonatomic, retain) UITableView *tableView;
@property (nonatomic, retain) UIBarButtonItem *done;
@property (nonatomic, retain) UIBarButtonItem *cancel;

@property (nonatomic, retain) NSString *subtractBy, *divideBy, *carbDivision, *footerText;


- (BOOL)isInt:(NSString *)string;
- (void)closeModal:(id)sender;

@end
