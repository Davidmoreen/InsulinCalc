//
//  InsulinAppDelegate.h
//  Insulin
//
//  Created by David Moreen on 10/3/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface InsulinAppDelegate : UIResponder <UIApplicationDelegate>
{
	UIWindow *window;
	UIViewController *viewController;
}

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic, retain) UIViewController *viewController;

@end
