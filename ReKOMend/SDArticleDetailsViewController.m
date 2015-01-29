//
//  SDArticleDetailsViewController.m
//  ReKOMend
//
//  Created by Shwetha Gopalan on 10/24/13.
//  Copyright (c) 2013 ShweDiv. All rights reserved.
//

#import "SDArticleDetailsViewController.h"

@interface SDArticleDetailsViewController ()

@end

@implementation SDArticleDetailsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
	[self.webView loadRequest:[NSURLRequest requestWithURL:self.articleURL]];
	[self.view addSubview:self.webView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
