//
//  SDNewsTableViewController.h
//  ReKOMend
//
//  Created by Shwetha Gopalan on 10/24/13.
//  Copyright (c) 2013 ShweDiv. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SDArticleCell.h"

@interface SDNewsTableViewController : UITableViewController<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) NSArray* newsArticlesArray;
@property (nonatomic, strong) NSURL* articleURL;
@property (nonatomic, strong) NSString* userID;
@property (nonatomic, strong) NSMutableDictionary* userDictionary;

- (void)initNewsArticlesArray:(NSArray *)newsArticlesArray andUserID:(NSString*)userID userDict:(NSMutableDictionary*)userDict;

@end
