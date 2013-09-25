//
//  MWCommentViewCell.m
//  SocialSpaces
//
//  Created by Derrick Ellerbie on 9/20/13.
//  Copyright (c) 2013 Derrick Ellerbie. All rights reserved.
//

#import "MWCommentViewCell.h"
#import "MWCommentView.h"

const int COMMENT_VIEW = 1;

@implementation MWCommentViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self)
    {
        CGRect cvFrame = CGRectMake(0.0, 0.0, self.contentView.bounds.size.width, self.contentView.bounds.size.height);
        MWCommentView *cv = [[MWCommentView alloc] initWithFrame:cvFrame];
        [cv setBackgroundColor:[UIColor clearColor]];
        [cv setTag:COMMENT_VIEW];
        [self.contentView addSubview:cv];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)resizeCommentView
{
    MWCommentView *commentView = (MWCommentView *)[self.contentView viewWithTag: COMMENT_VIEW];
    CGRect frame = [commentView frame];
    frame.size.height = [MWCommentView heightForComment];
    commentView.frame = frame;
}


@end
