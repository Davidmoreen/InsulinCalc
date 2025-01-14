//
//  InfoViewController.m
//  Insulin
//
//  Created by David Moreen on 10/7/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "InfoViewController.h"
#import "InsulinViewController.h"

@implementation InfoViewController

@synthesize delegate;
@synthesize navBar;
@synthesize tableView;
@synthesize done;
@synthesize cancel;
@synthesize subtractBy;
@synthesize divideBy;
@synthesize carbDivision;
@synthesize footerText;

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

- (void)viewDidLoad
{
    [super viewDidLoad];
	
	self.title = @"Settings";
	footerText = @"App by David";
	
	tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-44) style:UITableViewStyleGrouped];
	tableView.autoresizingMask = UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth;
	tableView.dataSource = self;
	tableView.delegate = self;
	
	[tableView reloadData];
	
	self.navBar = [[UINavigationBar alloc] initWithFrame:CGRectMake(0, 0, 320, 64)];
	self.navBar.translucent = NO;
	self.cancel = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(closeModal:)];
	self.done = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(doneButtonTapped:)];
	
	UINavigationItem *navItem = [[UINavigationItem alloc] initWithTitle: self.title];
	navItem.rightBarButtonItem = done;
	navItem.leftBarButtonItem = cancel;
	[navBar setItems:[NSArray arrayWithObject: navItem]];
	
	[self.view addSubview:navBar];
	[self.view addSubview:tableView];
	
	NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
	
	subtractBy = [defaults objectForKey:@"subtractBy"];
	divideBy = [defaults objectForKey:@"divideBy"];
	carbDivision = [defaults objectForKey:@"carbDivision"];
}

- (void)viewWillAppear:(BOOL)animated
{
	[self.tableView reloadData];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}

- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section {
	return [NSString stringWithFormat:@"                         %@", footerText];
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"MyCell"];
	
	if (cell == nil) {
		cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
									  reuseIdentifier:@"MyCell"];
		cell.accessoryType = UITableViewCellAccessoryNone;
		
		if ([indexPath section] == 0) {
			UITextField *editField = [[UITextField alloc] initWithFrame:CGRectMake(140, 3, 165, 42)];
			if ([indexPath section] == 0) {
				if ([indexPath row] == 0) {
					editField.placeholder = @"What to subtract by";
					editField.keyboardType = UIKeyboardTypeNumberPad;
					[editField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
					editField.tag = 0;
					if (subtractBy != nil)
						editField.text = subtractBy;
				}
				else if ([indexPath row] == 1)
				{
					editField.placeholder = @"What to divide by";
					editField.keyboardType = UIKeyboardTypeNumberPad;
					[editField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
					editField.tag = 1;
					if (divideBy != nil)
						editField.text = divideBy;
				}
				else
				{
					editField.placeholder = @"End division";
					editField.keyboardType = UIKeyboardTypeNumberPad;
					[editField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
					editField.tag = 2;
					if (carbDivision != nil)
						editField.text = carbDivision;
				}
			}
			editField.adjustsFontSizeToFitWidth = YES;
			editField.textColor = [UIColor blackColor];
			editField.backgroundColor = [UIColor clearColor];
			editField.autocorrectionType = UITextAutocorrectionTypeNo;
			editField.autocapitalizationType = UITextAutocapitalizationTypeNone;
			editField.textAlignment = UITextAlignmentLeft;
			editField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
			editField.delegate = self;
			
			editField.clearButtonMode = UITextFieldViewModeNever;
			[editField setEnabled: YES];
			
			[cell addSubview:editField];
		}
	}
	
	if (indexPath.section == 0) {
		if ([indexPath row] == 0) {
			cell.textLabel.text = @"Subtract by";
		}
		else if ([indexPath row] == 1)
		{
			cell.textLabel.text = @"Divide by";
		}
		else {
			cell.textLabel.text = @"Carb division";
		}
	}
	return cell;
}

#pragma mark -
#pragma mark Table view delegate

- (void)tableView:(UITableView *)tv didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	[tv deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark -
#pragma mark UITextField delegate methods

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
	[textField resignFirstResponder];
	return YES;
}


#pragma mark - Actions

- (void)textFieldDidChange:(id)sender
{
	UITableViewCell *cell = (UITableViewCell *)[[sender superview] superview];
	NSIndexPath *indexPath = [tableView indexPathForCell:cell];
	UITextField *textField = (UITextField *)sender;
	
	switch (indexPath.row) {
		case 0:
			subtractBy = textField.text;
			break;
		case 1:
			divideBy = textField.text;
			break;
		case 2:
			carbDivision = textField.text;
			break;
		default:
			break;
	}
	
}

- (BOOL)validateFieldsBeforeCommit
{
	NSMutableArray *errors = [[NSMutableArray alloc] initWithCapacity:6];
	
	if ( ! [self isInt:subtractBy])
	{
		[errors addObject:@"Subtract by field must be an int"];
	}
	if ( ! [self isInt:divideBy])
	{
		[errors addObject:@"Divide by field must be an int"];
	}
	if ( ! [self isInt:carbDivision])
	{
		[errors addObject:@"Carb division field must be an int"];
	}
	
	if ([divideBy isEqualToString:@"0"])
	{
		[errors addObject:@"Divide by field must be non-zero"];
	}
	if ([carbDivision isEqualToString:@"0"])
	{
		[errors addObject:@"Carb division field must be non-zero"];
	}
	
	
	int errorNumber = [errors count];
	
	if (errorNumber != 0)
	{
		[self.delegate showErrorWithTitle:[NSString stringWithFormat:@"Errors (%d)", errorNumber] message:[NSString stringWithFormat:@"Correct the following errors:\n\n%@", [errors componentsJoinedByString:@"\n"]]];
		
		return NO;
	}
	
	return YES;
	
}

- (void)doneButtonTapped:(id)sender
{
	if ( ! [self validateFieldsBeforeCommit])
	{
		return;
	}
	
	if (self.delegate && [self.delegate respondsToSelector:@selector(updateSettingsWithSubtractBy:argDivideBy:argCarbDivision:)])
	{
		[self.delegate updateSettingsWithSubtractBy:subtractBy argDivideBy:divideBy argCarbDivision:carbDivision];
	}
	
	[self.delegate clearInsulinResultLabel];
	
	[self closeModal:sender];
}

- (void)closeModal:(id)sender
{
	[self dismissModalViewControllerAnimated:YES];
}

- (void)viewDidUnload
{
	[super viewDidUnload];
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Custom methods

- (BOOL)isInt:(NSString *)string
{
	if ([string intValue] > 0)
	{
		return YES;
	}
	else if ([string isEqualToString:@"0"])
	{
		return YES;
	}
	
	return NO;
}

@end
