//
//  ViewController.m
//  SARateExample
//
//  Created by Andrew Romanov on 26/02/16.
//  Copyright © 2016 SA. All rights reserved.
//

#import "ViewController.h"
#import "SARate.h"


@interface ViewController ()

- (IBAction)displayRateAction:(id)sender;

@end

@implementation ViewController

- (void)viewDidLoad {
	[super viewDidLoad];

	// Do any additional setup after loading the view, typically from a nib.
}


- (void)viewDidAppear:(BOOL)animated
{
	[super viewDidAppear:animated];
	
	
}


#pragma mark Action
- (IBAction)displayRateAction:(id)sender
{
	[[SARate sharedInstance] promptForRating];
}

@end
