//
//  InsulinViewController.h
//  Insulin
//
//  Created by David Moreen on 10/3/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIView+JMNoise.h"

@interface InsulinViewController : UIViewController
{
	UIButton *hideKeyboardBackgroundButton;
	UIImageView *logoImageView;
	UILabel *insulinResultLabel;
	NSString *viewType;
	UIView *withFoodView;
	UIView *withoutFoodView;
	UITextField *carbsTextArea;
	UITextField *withFoodBsTextArea;
	UITextField *withoutFoodBsTextArea;
	UIButton *calculateInsulinForWithFoodButton;
	UIButton *calculateInsulinForWithoutFoodButton;
	UISegmentedControl *actionSelector;
	UIButton *settingsAndInfoButton;
	
	NSMutableDictionary *settings;
}

@property (nonatomic, retain) UIButton *hideKeyboardBackgroundButton;
@property (nonatomic, retain) UIImageView *logoImageView;
@property (nonatomic, retain) UILabel *insulinResultLabel;
@property (nonatomic, retain) NSString *viewType;
@property (nonatomic, retain) UIView *withFoodView;
@property (nonatomic, retain) UIView *withoutFoodView;
@property (nonatomic, retain) UITextField *carbsTextArea;
@property (nonatomic, retain) UITextField *withFoodBsTextArea;
@property (nonatomic, retain) UITextField *withoutFoodBsTextArea;
@property (nonatomic, retain) UIButton *calculateInsulinForWithFoodButton;
@property (nonatomic, retain) UIButton *calculateInsulinForWithoutFoodButton;
@property (nonatomic, retain) UISegmentedControl *actionSelector;
@property (nonatomic, retain) UIButton *settingsAndInfoButton;

@property (nonatomic, retain) NSMutableDictionary *settings;

- (void)showErrorWithTitle:(NSString *)title message:(NSString *)message;
- (void)clearInsulinResultLabel;
- (void)updateSettingsWithSubtractBy:(NSString *)s argDivideBy:(NSString *)d argCarbDivision:(NSString *)c;

@end
