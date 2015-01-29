//
//  SDArticle.m
//  ReKOMend
//
//  Created by Shwetha Gopalan on 10/24/13.
//  Copyright (c) 2013 ShweDiv. All rights reserved.
//

#import "SDArticle.h"

@implementation SDArticle

- (id)initWithTitle:(NSString*)title
		description:(NSString*)description
				URL:(NSURL*)url
			  Image:(UIImage*)image
		   keywords:(NSArray*)keywords {
	if (self = [super init]) {
		_articleTitle = title;
		_articleDescription = description;
		_articleURL = url;
		_articleImage = image;
		_keywords = keywords;
	}
	return  self;
}
@end
