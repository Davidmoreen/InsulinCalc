//
//  InsulinViewController.m
//  Insulin
//
//  Created by David Moreen on 10/3/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

#import "InsulinViewController.h"
#import "InfoViewController.h"

@implementation InsulinViewController

@synthesize hideKeyboardBackgroundButton;
@synthesize logoImageView;
@synthesize insulinResultLabel;
@synthesize viewType;
@synthesize withFoodView;
@synthesize withoutFoodView;
@synthesize carbsTextArea;
@synthesize withFoodBsTextArea;
@synthesize withoutFoodBsTextArea;
@synthesize calculateInsulinForWithFoodButton;
@synthesize calculateInsulinForWithoutFoodButton;
@synthesize actionSelector;
@synthesize settingsAndInfoButton;

@synthesize settings;



- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
	
	return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)loadView
{
	if (self)
	{
		CGRect appFrame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
		self.view = [[UIView alloc] initWithFrame:appFrame];
		self.view.backgroundColor = [UIColor whiteColor];
		
		[self.view applyNoise];
		
		viewType = @"withFood";
		
		[self.view addSubview:self.hideKeyboardBackgroundButton];
		[self.view addSubview:self.logoImageView];
		[self.view addSubview:self.insulinResultLabel];
		[self.view addSubview:self.withFoodView];
		[self.view addSubview:self.withoutFoodView];
		[self.view addSubview:self.actionSelector];
		[self.view addSubview:self.settingsAndInfoButton];
		
		withoutFoodView.hidden = YES;
		
		// app settings
		NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
		
		self.settings = [[NSMutableDictionary alloc] initWithDictionary: [defaults dictionaryRepresentation]];
	}
}

- (void)viewDidLoad
{
	[super viewDidLoad];
}

- (void)viewDidUnload
{
	[super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


#pragma mark - View items

- (UIButton *)hideKeyboardBackgroundButton
{
	if (hideKeyboardBackgroundButton == nil)
	{
		hideKeyboardBackgroundButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
		
		hideKeyboardBackgroundButton.backgroundColor = [UIColor clearColor];
		
		[hideKeyboardBackgroundButton addTarget:self action:@selector(hideKeyboard:) forControlEvents:UIControlEventTouchUpInside];
	}
	
	return hideKeyboardBackgroundButton;
}

- (UIImageView *)logoImageView
{
	if (logoImageView == nil)
	{
		UIImage *image = [UIImage imageNamed:@"logo.png"];
		logoImageView = [[UIImageView alloc] initWithImage:image];
		logoImageView.frame = CGRectMake(([UIScreen mainScreen].bounds.size.width-251)/2, 65, 251, 29);
	}
	
	return logoImageView;
}

- (UILabel *)insulinResultLabel
{
	if (insulinResultLabel == nil)
	{
		insulinResultLabel = [[UILabel alloc] init];
		insulinResultLabel.frame = CGRectMake(0, 103, [UIScreen mainScreen].bounds.size.width, 50);
		
		// Label format attributes
		insulinResultLabel.font = [UIFont systemFontOfSize:15];
		insulinResultLabel.backgroundColor = [UIColor clearColor];
		insulinResultLabel.textColor = [UIColor darkGrayColor];
		insulinResultLabel.shadowColor = [UIColor whiteColor];
		insulinResultLabel.shadowOffset = CGSizeMake(1, 1);
		insulinResultLabel.textAlignment = UITextAlignmentCenter;
		insulinResultLabel.adjustsFontSizeToFitWidth = TRUE;
		insulinResultLabel.text = @"";
	}
	
	return insulinResultLabel;
}

- (UIView *)withFoodView
{
	if (withFoodView == nil)
	{
		withFoodView = [[UIView alloc] initWithFrame:CGRectMake(35, 150, 250, 175)];
		
		
		UIImage *bgImage = [UIImage imageNamed:@"text_input_bg.png"];
		UIImage *background = [bgImage stretchableImageWithLeftCapWidth:12.0 topCapHeight:0];
		
		if (carbsTextArea == nil)
		{
			carbsTextArea = [[UITextField alloc] init];
			carbsTextArea.frame = CGRectMake(0, 0, 250, 40);
			carbsTextArea.borderStyle = 0; // No border
			carbsTextArea.background = background;
			carbsTextArea.keyboardType = UIKeyboardTypeNumberPad;
			carbsTextArea.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
			carbsTextArea.placeholder = @"Total carbs";
			carbsTextArea.font = [UIFont systemFontOfSize:18];
			carbsTextArea.textColor = [UIColor blackColor];
			carbsTextArea.textAlignment = UITextAlignmentCenter;
			carbsTextArea.adjustsFontSizeToFitWidth = TRUE;
		}
		
		if (withFoodBsTextArea == nil)
		{
			withFoodBsTextArea = [[UITextField alloc] init];
			withFoodBsTextArea.frame = CGRectMake(0, 50, 250, 40);
			withFoodBsTextArea.borderStyle = 0; // No border
			withFoodBsTextArea.background = background;
			withFoodBsTextArea.keyboardType = UIKeyboardTypeNumberPad;
			withFoodBsTextArea.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
			withFoodBsTextArea.placeholder = @"Blood sugar";
			withFoodBsTextArea.font = [UIFont systemFontOfSize:18];
			withFoodBsTextArea.textColor = [UIColor blackColor];
			withFoodBsTextArea.textAlignment = UITextAlignmentCenter;
			withFoodBsTextArea.adjustsFontSizeToFitWidth = TRUE;
		}
		
		if (calculateInsulinForWithFoodButton == nil)
		{
			calculateInsulinForWithFoodButton = [[UIButton alloc] initWithFrame:CGRectMake(10, 110, 230, 50)];
			
			calculateInsulinForWithFoodButton.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
			calculateInsulinForWithFoodButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
			
			calculateInsulinForWithFoodButton.titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:17];
			calculateInsulinForWithFoodButton.titleLabel.shadowOffset = CGSizeMake(1.0, 1.0);
			calculateInsulinForWithFoodButton.backgroundColor = [UIColor clearColor];
			
			[calculateInsulinForWithFoodButton setTitle:@"CALCULATE INSULIN" forState:UIControlStateNormal];	
			[calculateInsulinForWithFoodButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
			[calculateInsulinForWithFoodButton setTitleShadowColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.3] forState:UIControlStateNormal];
			
			UIImage *buttonImage = [[UIImage imageNamed:@"green_button_normal.png"] stretchableImageWithLeftCapWidth:50.0 topCapHeight:0.0];
			UIImage *buttonImageActive = [[UIImage imageNamed:@"green_button_active.png"] stretchableImageWithLeftCapWidth:50.0 topCapHeight:0.0];
			
			[calculateInsulinForWithFoodButton setBackgroundImage:buttonImage forState:UIControlStateNormal];
			[calculateInsulinForWithFoodButton setBackgroundImage:buttonImageActive forState:UIControlStateHighlighted];
			
			[calculateInsulinForWithFoodButton addTarget:self action:@selector(hideKeyboard:) forControlEvents:UIControlEventTouchUpInside];

			[calculateInsulinForWithFoodButton addTarget:self action:@selector(calculateInsulinForWithFood:) forControlEvents:UIControlEventTouchUpInside];
		}

		
		[withFoodView addSubview:carbsTextArea];
		[withFoodView addSubview:withFoodBsTextArea];
		[withFoodView addSubview:calculateInsulinForWithFoodButton];
	}
	
	return withFoodView;
}

- (UIView *)withoutFoodView
{
	if (withoutFoodView == nil)
	{
		withoutFoodView = [[UIView alloc] initWithFrame:CGRectMake(35, 150, 250, 175)];
		
		
		UIImage *bgImage = [UIImage imageNamed:@"text_input_bg.png"];
		UIImage *background = [bgImage stretchableImageWithLeftCapWidth:12.0 topCapHeight:0];
		
		if (withoutFoodBsTextArea == nil)
		{
			withoutFoodBsTextArea = [[UITextField alloc] init];
			withoutFoodBsTextArea.frame = CGRectMake(0, 0, 250, 40);
			withoutFoodBsTextArea.borderStyle = 0; // No border
			withoutFoodBsTextArea.background = background;
			withoutFoodBsTextArea.keyboardType = UIKeyboardTypeNumberPad;
			withoutFoodBsTextArea.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
			withoutFoodBsTextArea.placeholder = @"Blood sugar";
			withoutFoodBsTextArea.font = [UIFont systemFontOfSize:18];
			withoutFoodBsTextArea.textColor = [UIColor blackColor];
			withoutFoodBsTextArea.textAlignment = UITextAlignmentCenter;
			withoutFoodBsTextArea.adjustsFontSizeToFitWidth = TRUE;
		}
		
		if (calculateInsulinForWithoutFoodButton == nil)
		{
			calculateInsulinForWithoutFoodButton = [[UIButton alloc] initWithFrame:CGRectMake(10, 60, 230, 50)];
			
			calculateInsulinForWithoutFoodButton.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
			calculateInsulinForWithoutFoodButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
			
			calculateInsulinForWithoutFoodButton.titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:17];
			calculateInsulinForWithoutFoodButton.titleLabel.shadowOffset = CGSizeMake(1.0, 1.0);
			calculateInsulinForWithoutFoodButton.backgroundColor = [UIColor clearColor];
			
			[calculateInsulinForWithoutFoodButton setTitle:@"CALCULATE INSULIN" forState:UIControlStateNormal];	
			[calculateInsulinForWithoutFoodButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
			[calculateInsulinForWithoutFoodButton setTitleShadowColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.3] forState:UIControlStateNormal];
			
			UIImage *buttonImage = [[UIImage imageNamed:@"green_button_normal.png"] stretchableImageWithLeftCapWidth:50.0 topCapHeight:0.0];
			UIImage *buttonImageActive = [[UIImage imageNamed:@"green_button_active.png"] stretchableImageWithLeftCapWidth:50.0 topCapHeight:0.0];
			
			[calculateInsulinForWithoutFoodButton setBackgroundImage:buttonImage forState:UIControlStateNormal];
			[calculateInsulinForWithoutFoodButton setBackgroundImage:buttonImageActive forState:UIControlStateHighlighted];
			
			[calculateInsulinForWithoutFoodButton addTarget:self action:@selector(hideKeyboard:) forControlEvents:UIControlEventTouchUpInside];
			[calculateInsulinForWithoutFoodButton addTarget:self action:@selector(calculateInsulinForWithoutFood:) forControlEvents:UIControlEventTouchUpInside];
		}
		
		
		[withoutFoodView addSubview:withoutFoodBsTextArea];
		[withoutFoodView addSubview:calculateInsulinForWithoutFoodButton];
	}
	
	return withoutFoodView;
}

- (UISegmentedControl *)actionSelector
{
	if (actionSelector == nil) {
		NSArray *actions = [NSArray arrayWithObjects:@"with food", @"without food", nil];
		
		actionSelector = [[UISegmentedControl alloc] initWithItems:actions];
		actionSelector.frame = CGRectMake(60, 365, 200, 35);
		
		// Styling
		actionSelector.segmentedControlStyle = UISegmentedControlStyleBar;
		actionSelector.selectedSegmentIndex = 0;
		
		[actionSelector addTarget:self action:@selector(switchView:) forControlEvents:UIControlEventValueChanged];
	}
	
	return actionSelector;
}

- (UIButton *)settingsAndInfoButton
{
	if (settingsAndInfoButton == nil)
	{
		settingsAndInfoButton = [UIButton buttonWithType:UIButtonTypeInfoDark];
		settingsAndInfoButton.frame = CGRectMake([UIScreen mainScreen].bounds.size.width-35, [UIScreen mainScreen].bounds.size.height-35, 22, 22);
		
		[settingsAndInfoButton setTitle:@"View info" forState:UIControlStateNormal];
		settingsAndInfoButton.backgroundColor = [UIColor clearColor];
		
		[settingsAndInfoButton addTarget:self action:@selector(showUserSettingsModal:) forControlEvents:UIControlEventTouchUpInside];
	}
	
	return settingsAndInfoButton;
}

#pragma mark - Actions

- (void)calculateInsulinForWithFood:(id)sender
{
	int bloodSugar = [withFoodBsTextArea.text intValue];
	int carbIntake = [carbsTextArea.text intValue];
	
	if (bloodSugar == 0 || carbIntake == 0)
	{
		[self showErrorWithTitle:@"Error" message:@"Blood sugar and Carb fields are required"];
		return;
	}
	
	// Calculate
	int unitsBasedOnBloodSugar = (bloodSugar - [[settings objectForKey:@"subtractBy"] intValue]) / [[settings objectForKey:@"divideBy"] intValue];
	int unitsBasedOnCarbIntake = carbIntake / [[settings objectForKey:@"carbDivision"] intValue];
	
	// Evaluate
	int totalUnits = unitsBasedOnBloodSugar + unitsBasedOnCarbIntake;
	
	insulinResultLabel.text = [[NSString alloc] initWithFormat:@"Take %d units of insulin", totalUnits];
}

- (void)calculateInsulinForWithoutFood:(id)sender
{
	int bloodSugar = [withoutFoodBsTextArea.text intValue];
	
	if (bloodSugar == 0)
	{
		[self showErrorWithTitle:@"Error" message:@"Blood sugar field is required"];
		return;
	}
	
	// Calculate
	int unitsBasedOnBloodSugar = (bloodSugar - [[settings objectForKey:@"subtractBy"] intValue]) / [[settings objectForKey:@"divideBy"] intValue];
	
	insulinResultLabel.text = [[NSString alloc] initWithFormat:@"Take %d units of insulin", unitsBasedOnBloodSugar];
}

- (void)hideKeyboard:(id)sender
{
	[carbsTextArea resignFirstResponder];
	[withFoodBsTextArea resignFirstResponder];
	[withoutFoodBsTextArea resignFirstResponder];
}

- (void)switchView:(id)sender
{
	UISegmentedControl *switcher = (UISegmentedControl *)sender;
	
	switch (switcher.selectedSegmentIndex) {
		default:
		case 0:
			viewType = @"withFood";
			break;
			
		case 1:
			viewType = @"withoutFood";
			break;
	}
	
	if ([viewType isEqualToString:@"withFood"])
	{
		withFoodView.hidden = NO;
		withoutFoodView.hidden = YES;
	}
	else if ([viewType isEqualToString:@"withoutFood"])
	{
		withFoodView.hidden = YES;
		withoutFoodView.hidden = NO;
	}
}

- (void)showUserSettingsModal:(id)sender {
	
	InfoViewController *modal = [[InfoViewController alloc] initWithNibName:nil bundle:nil];
	modal.delegate = self;
	
	[self presentModalViewController:modal animated:YES];
}

- (void)clearInsulinResultLabel
{
	insulinResultLabel.text = @"";
}

- (void)showErrorWithTitle:(NSString *)title message:(NSString *)message
{
	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title message:message delegate:self cancelButtonTitle:@"Close" otherButtonTitles:nil];
	[alert show];
}

- (void)updateSettingsWithSubtractBy:(NSString *)s argDivideBy:(NSString *)d argCarbDivision:(NSString *)c
{
	NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
	
	[defaults setObject:s forKey:@"subtractBy"];
	[defaults setObject:d forKey:@"divideBy"];
	[defaults setObject:c forKey:@"carbDivision"];
	
	[defaults synchronize];
	[self.settings setDictionary: [defaults dictionaryRepresentation]];
}

@end
