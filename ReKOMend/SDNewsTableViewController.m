//
//  SDNewsTableViewController.m
//  ReKOMend
//
//  Created by Shwetha Gopalan on 10/24/13.
//  Copyright (c) 2013 ShweDiv. All rights reserved.
//

#import "SDNewsTableViewController.h"
#import "SDArticle.h"
#import "SDArticleDetailsViewController.h"
#import "SDSearchViewController.h"

@interface SDNewsTableViewController ()

@end

@implementation SDNewsTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
	self.tableView.dataSource = self;
	self.tableView.delegate = self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return [self.newsArticlesArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
	
	NSString* title = [[self.newsArticlesArray objectAtIndex:indexPath.row] objectForKey:@"title"];
	
	int random = (70 + arc4random() % (71));
	
	cell.contentView.backgroundColor = [UIColor blackColor];
	cell.textLabel.textColor = [UIColor whiteColor];
	cell.textLabel.lineBreakMode = NSLineBreakByWordWrapping;
	cell.textLabel.numberOfLines = 4;
	cell.textLabel.text = title;
	cell.imageView.contentMode = UIViewContentModeScaleAspectFill;
	
	dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
		NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://placekitten.com/%d/%d",random, random]]];
		UIImage *image = [UIImage imageWithData:data];
		dispatch_sync(dispatch_get_main_queue(), ^{
			cell.imageView.image = image;
		});
    });
	
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	self.articleURL = [[self.newsArticlesArray objectAtIndex:indexPath.row] objectForKey:@"referenceURL"];
	NSString* keywords = [[self.newsArticlesArray objectAtIndex:indexPath.row] objectForKey:@"keywords"];
	if (![keywords isEqualToString: @""]) {
		NSArray* keywordsArray = [keywords componentsSeparatedByString:@", "];
		NSMutableArray* vector = [self.userDictionary objectForKey:self.userID];
		for (NSString* keyword in keywordsArray) {
			if ([keywordsArray containsObject:keyword]) {
				[vector removeObject:keyword];
			}
		}
		[vector addObjectsFromArray:keywordsArray];
		[self.userDictionary setObject:vector forKey:self.userID];
	}
	[self performSegueWithIdentifier:@"webSegue" sender:self];
}

#pragma mark - Navigation

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
	[segue.destinationViewController setArticleURL:self.articleURL];
}


- (void)initNewsArticlesArray:(NSArray *)newsArticlesArray andUserID:(NSString*)userID userDict:(NSMutableDictionary*)userDict {
	self.newsArticlesArray = newsArticlesArray;
	self.userID = userID;
	self.userDictionary = userDict;
}

@end
