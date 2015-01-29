//
//  SDArticle.h
//  ReKOMend
//
//  Created by Shwetha Gopalan on 10/24/13.
//  Copyright (c) 2013 ShweDiv. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SDArticle : NSObject

@property (nonatomic, strong) NSString* articleTitle;
@property (nonatomic, strong) NSString* articleDescription;
@property (nonatomic, strong) UIImage* articleImage;
@property (nonatomic, strong) NSArray* keywords;
@property (nonatomic, strong) NSURL* articleURL;

- (id)initWithTitle:(NSString*)title
		description:(NSString*)description
				URL:(NSURL*)url
			  Image:(UIImage*)image
		   keywords:(NSArray*)keywords;

@end
