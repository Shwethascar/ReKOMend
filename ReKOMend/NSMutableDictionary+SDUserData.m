//
//  NSMutableDictionary+SDUserData.m
//  ReKOMend
//
//  Created by Shwetha Gopalan on 10/24/13.
//  Copyright (c) 2013 ShweDiv. All rights reserved.
//

#import "NSMutableDictionary+SDUserData.h"

@implementation NSMutableDictionary (SDUserData)

- (id)initWithUserID:(NSString*)userID vector:(NSMutableArray*)vector {
	self = [NSMutableDictionary dictionary];
	[self setObject:vector forKey:userID];
	return self;
}

@end

