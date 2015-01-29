//
//  ViewController.m
//  ReKOMend
//
//  Created by Shwetha Gopalan on 10/24/13.
//  Copyright (c) 2013 ShweDiv. All rights reserved.
//

#import "SDLoginViewController.h"
#import "NSMutableDictionary+SDUserData.h"
#import "SDSearchViewController.h"

@interface SDLoginViewController ()

@end

@implementation SDLoginViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
								   initWithTarget:self
								   action:@selector(dismissKeyboard)];
	
	[self.view addGestureRecognizer:tap];
	self.titleLabel.textColor = [UIColor whiteColor];
	[self.titleLabel setFont:[UIFont fontWithName:@"GodOfWar" size:30.0]];
	
	self.startButton.titleLabel.textColor = [UIColor whiteColor];
	[self.startButton.titleLabel setFont:[UIFont fontWithName:@"GodOfWar" size:20.0]];
	
	self.expansionLabel.textColor = [UIColor whiteColor];
	[self.expansionLabel setFont:[UIFont fontWithName:@"GodOfWar" size:12.0]];
	
	self.userID = self.userIDField.text;
	
}

-(void)dismissKeyboard {
	[self.userIDField resignFirstResponder];
	self.userID = self.userIDField.text;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
	NSMutableArray* vector = [NSMutableArray array];
	NSMutableDictionary* userDataDictionary = [[NSMutableDictionary alloc] initWithUserID:self.userID vector:vector];
	[segue.destinationViewController vectorWithUserDictionary:userDataDictionary userID:self.userID];	
	
}

@end
