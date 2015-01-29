//
//  SDSearchViewController.h
//  ReKOMend
//
//  Created by Shwetha Gopalan on 10/24/13.
//  Copyright (c) 2013 ShweDiv. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SDSearchViewController : UIViewController<UIPickerViewDataSource, UIPickerViewDelegate>
@property (weak, nonatomic) IBOutlet UILabel *categoryLabel;
@property (weak, nonatomic) IBOutlet UIPickerView *categoryPicker;
@property (weak, nonatomic) IBOutlet UITextField *tagTextField;
@property (weak, nonatomic) IBOutlet UIButton *searchButton;
@property (nonatomic, strong) NSArray* categoryArray;
@property (nonatomic, strong) NSString* category;

@property (nonatomic, strong) NSMutableDictionary* localUserDictionary;
@property (nonatomic, strong) NSString* localUserID;
@property (weak, nonatomic) IBOutlet UILabel *userLabel;

- (void)vectorWithUserDictionary:(NSMutableDictionary*)userDictionary userID:(NSString*)userID;
@end
