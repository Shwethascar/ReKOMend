//
//  SDArticleCell.m
//  ReKOMend
//
//  Created by Shwetha Gopalan on 10/24/13.
//  Copyright (c) 2013 ShweDiv. All rights reserved.
//

#import "SDArticleCell.h"

@implementation SDArticleCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
		self.articleDescription = [[UILabel alloc] init];
		[self.contentView addSubview:self.articleDescription];
		self.articleTitle = [[UILabel alloc] init];
		[self.contentView addSubview:self.articleTitle];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
