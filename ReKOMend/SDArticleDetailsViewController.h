//
//  SDArticleDetailsViewController.h
//  ReKOMend
//
//  Created by Shwetha Gopalan on 10/24/13.
//  Copyright (c) 2013 ShweDiv. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SDArticleDetailsViewController : UIViewController

@property (nonatomic, strong) NSURL* articleURL;
@property (strong, nonatomic) IBOutlet UIWebView *webView;

@end
