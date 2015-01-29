//
//  SDSearchViewController.m
//  ReKOMend
//
//  Created by Shwetha Gopalan on 10/24/13.
//  Copyright (c) 2013 ShweDiv. All rights reserved.
//

#import "SDSearchViewController.h"
#import "SDNewsTableViewController.h"

#define kOFFSET_FOR_KEYBOARD 80.0

@interface SDSearchViewController ()

@end

@implementation SDSearchViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}



- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
	[self.categoryLabel setFont:[UIFont fontWithName:@"GodOfWar" size:30.0]];
	self.categoryLabel.textColor = [UIColor whiteColor];
	
	[self.searchButton.titleLabel setFont:[UIFont fontWithName:@"GodOfWar" size:20.0]];
	self.searchButton.titleLabel.textColor = [UIColor whiteColor];
	
	[self.userLabel setFont:[UIFont fontWithName:@"GodOfWar" size:10.0]];
	self.userLabel.textColor = [UIColor whiteColor];
	[self.userLabel sizeToFit];
	self.userLabel.text = [NSString stringWithFormat:@"Howdy, %@", self.localUserID];

	
	self.categoryArray = [NSArray arrayWithObjects:@"Art", @"Business", @"Entertainment", @"Politics", @"Science", @"Sports", @"Technology", nil];
	[self.categoryPicker selectRow:1 inComponent:0 animated:YES];
	self.categoryPicker.tintColor = [UIColor whiteColor];
	self.searchButton.hidden = YES;
	
	self.tagTextField.hidden = YES;
	
	UITapGestureRecognizer* tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyboard)];
	[self.view addGestureRecognizer:tap];
}

- (void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
	if (self.localUserDictionary && self.localUserID) {
		NSArray* valuesArray = [self.localUserDictionary objectForKey:self.localUserID];
		NSMutableString* text = [NSMutableString string];
		for (NSString* value in valuesArray) {
			[text appendString:[NSString stringWithFormat:@"%@,",value]];
		}
		self.tagTextField.text = text;
	}
	[self viewDidLoad];
	// register for keyboard notifications
    [[NSNotificationCenter defaultCenter] addObserver:self
											 selector:@selector(keyboardWillShow)
												 name:UIKeyboardWillShowNotification
											   object:nil];
	
    [[NSNotificationCenter defaultCenter] addObserver:self
											 selector:@selector(keyboardWillHide)
												 name:UIKeyboardWillHideNotification
											   object:nil];
}

- (void)viewWillDisappear:(BOOL)animated
{
    // unregister for keyboard notifications while not visible.
    [[NSNotificationCenter defaultCenter] removeObserver:self
													name:UIKeyboardWillShowNotification
												  object:nil];
	
    [[NSNotificationCenter defaultCenter] removeObserver:self
													name:UIKeyboardWillHideNotification
												  object:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)vectorWithUserDictionary:(NSMutableDictionary*)userDictionary userID:(NSString*)userID {
	self.localUserDictionary = userDictionary;
	self.localUserID = userID;
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView;
{
    return 1;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    self.category = [self.categoryArray objectAtIndex:row];
	self.tagTextField.hidden = NO;
	self.searchButton.hidden = NO;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component;
{
    return [self.categoryArray count];
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component;
{
    return [self.categoryArray objectAtIndex:row];
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view
{
    UILabel *label = [[UILabel alloc] init];
	label.text = [self.categoryArray objectAtIndex:row];
    label.textColor = [UIColor whiteColor];
	[label setFont:[UIFont fontWithName:@"GodOfWar" size:20.0]];
	label.textAlignment = NSTextAlignmentCenter;
    return (UIView*)label;
}

- (void)dismissKeyboard {
	[self.tagTextField resignFirstResponder];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
	NSArray* finalArray = [self populateUserDictionaryAndFinalArray];
	[segue.destinationViewController initNewsArticlesArray:finalArray andUserID:self.localUserID userDict:self.localUserDictionary];
}

- (NSArray*)populateUserDictionaryAndFinalArray {
	
	
	NSString* textToBeParsed = self.tagTextField.text;
	NSArray* tags = [textToBeParsed componentsSeparatedByString:@","];
	
	NSMutableArray* oldVectorArray = [self.localUserDictionary objectForKey:self.localUserID];
	for (NSString* tag in tags) {
		[oldVectorArray addObject:tag];
	}
	[self.localUserDictionary setObject:oldVectorArray forKey:self.localUserID];
	NSString* urlString = [self completeRequestString:tags];
	
	NSURL* requestURL = [NSURL URLWithString:urlString];
	
	// Create a request object using the URL.
	NSURLRequest *request = [NSURLRequest requestWithURL:requestURL];
	
	// Prepare for the response back from the server
	NSHTTPURLResponse *response = nil;
	NSError *error = nil;
	
	// Send a synchronous request to the server (i.e. sit and wait for the response)
	NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
	
	NSDictionary* responseDict = [NSJSONSerialization JSONObjectWithData:responseData options:kNilOptions error:&error];
	
	return [self parseJSONDictionary:responseDict];
	
}

- (NSString*)completeRequestString:(NSArray*)tags {
	
	NSMutableString* baseURLString = [@"http://api.idolondemand.com/idol-saas/api/v1/query?apikey=34c9f72c-c3de-455a-901b-b71c42304f31&databasematch=news_eng&sort=Relevance&highlight=Off&print=All&results=&printfields=&mindate=&maxdate=&maxresults=999&minscore=&fieldtext=" mutableCopy];
	
	[baseURLString appendFormat:@"%@",[NSString stringWithFormat:@"MATCH%%7B%@%%7D%%3ACATEGORY&text=", self.category]];
	
	NSMutableString* tagString = [NSMutableString string];
	
	for (NSString* tag in tags) {
		NSString* tag1 = [tag stringByReplacingOccurrencesOfString:@" " withString:@"+"];
		[tagString appendString:[NSString stringWithFormat:@"%@+",tag1]];
	}
	
	[baseURLString appendString:tagString];
	return baseURLString;
	
}

- (NSArray*)parseJSONDictionary:(NSDictionary*)responseDict {
	
	NSArray* documents = [responseDict objectForKey:@"documents"];
	
	NSMutableArray* finalArray = [NSMutableArray array];
	
	for (NSDictionary* resultsDict in documents) {
		NSString* title = [resultsDict objectForKey:@"title"];
		NSURL* referenceURL = [NSURL URLWithString:[resultsDict objectForKey:@"reference"]];
		NSString* description = [[resultsDict objectForKey:@"content"] objectForKey:@"DRECONTENT"];
		NSString* keywords = [[resultsDict objectForKey:@"content"] objectForKey:@"KEYWORDS"];
		
		NSDictionary* interimDictionary = [NSDictionary dictionaryWithObjectsAndKeys:title, @"title", referenceURL, @"referenceURL", description, @"description", keywords, @"keywords", nil];
		[finalArray addObject:interimDictionary];
	}
	return finalArray;
}

-(void)keyboardWillShow {
    // Animate the current view out of the way
    if (self.view.frame.origin.y >= 0)
    {
        [self setViewMovedUp:YES];
    }
    else if (self.view.frame.origin.y < 0)
    {
        [self setViewMovedUp:NO];
    }
}

-(void)keyboardWillHide {
    if (self.view.frame.origin.y >= 0)
    {
        [self setViewMovedUp:YES];
    }
    else if (self.view.frame.origin.y < 0)
    {
        [self setViewMovedUp:NO];
    }
}

-(void)textFieldDidBeginEditing:(UITextField *)sender
{
    if ([sender isEqual:self.tagTextField])
    {
        //move the main view, so that the keyboard does not hide it.
        if  (self.view.frame.origin.y >= 0)
        {
            [self setViewMovedUp:YES];
        }
    }
}

//method to move the view up/down whenever the keyboard is shown/dismissed
-(void)setViewMovedUp:(BOOL)movedUp
{
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.3]; // if you want to slide up the view
	
    CGRect rect = self.view.frame;
    if (movedUp)
    {
        // 1. move the view's origin up so that the text field that will be hidden come above the keyboard
        // 2. increase the size of the view so that the area behind the keyboard is covered up.
        rect.origin.y -= kOFFSET_FOR_KEYBOARD;
        rect.size.height += kOFFSET_FOR_KEYBOARD;
    }
    else
    {
        // revert back to the normal state.
        rect.origin.y += kOFFSET_FOR_KEYBOARD;
        rect.size.height -= kOFFSET_FOR_KEYBOARD;
    }
    self.view.frame = rect;
	
    [UIView commitAnimations];
}

@end
