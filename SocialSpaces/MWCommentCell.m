//
//  MWCommentCell.m
//  SocialSpaces
//
//  Created by Derrick Ellerbie on 10/3/13.
//  Copyright (c) 2013 Derrick Ellerbie. All rights reserved.
//

#import "MWCommentCell.h"
#import "WMATweetView.h"
#import "UIImage+ResizeAdditions.h"
#import "MWComment.h"

@implementation MWCommentCell

@synthesize comment = _comment;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

-(void)setComment:(MWComment *)comment
{
  _comment = comment;
  [self refresh];
}

-(void)refresh
{
  // username and via attributes
  UIColor *mainTextColor = [UIColor blackColor];
  UIFont *boldFont = [UIFont boldSystemFontOfSize:10];
  
  NSDictionary *attributesForUsername = @{ NSFontAttributeName : boldFont, NSForegroundColorAttributeName : mainTextColor };
  NSDictionary *attributesForVia = @{NSFontAttributeName : [UIFont systemFontOfSize:8.0], NSForegroundColorAttributeName: [UIColor lightGrayColor] };
  
  NSString *username = self.comment.username;
  NSString *viaLabel = @"via";
  NSString *strings = [@[self.comment.username, viaLabel, self.comment.via] componentsJoinedByString:@" "];
  
  NSMutableAttributedString *usernameAndSource = [[NSMutableAttributedString alloc] initWithString:strings];
  [usernameAndSource setAttributes:attributesForUsername range:[strings rangeOfString:username]];
  [usernameAndSource setAttributes:attributesForVia range:[strings rangeOfString:[@[viaLabel, self.comment.via] componentsJoinedByString:@" "]]];
  
  self.usernameLabel.attributedText = usernameAndSource;
  
  self.profileImageView.image = [[UIImage imageNamed: self.comment.profileImage] fillSize:self.profileImageView.bounds.size];
  self.attachedImageView.image = [[UIImage imageNamed: self.comment.attachedImage] fillSize:self.attachedImageView.bounds.size];
  
  self.tweetView.text = self.comment.comment;
  
  NSMutableArray *entities = [NSMutableArray array];
  NSURL *url = [NSURL URLWithString:@"http://t.co/dQ06Fbx3"];
  [entities addObject:[WMATweetURLEntity entityWithURL:url expandedURL:url displayURL:@"http://t.co/dQ06Fbx3" start:18 end:38]];
  [entities addObject:[WMATweetUserMentionEntity entityWithScreenName:@"ZarroBoogs" name:@"Mark Beaton" idString:@"547490130" start:120 end:131]];
  [entities addObject:[WMATweetHashtagEntity entityWithText:@"ios" start:132 end:136]];
  self.tweetView.entities = entities;
  
  self.tweetView.backgroundColor = [UIColor clearColor];
  self.tweetView.textColor = [UIColor darkTextColor];
  self.tweetView.textFont = [UIFont systemFontOfSize:10.0];
  self.tweetView.hashtagColor = [UIColor darkTextColor];
  self.tweetView.hashtagFont = [UIFont boldSystemFontOfSize:10];
  self.tweetView.userMentionColor = [UIColor lightGrayColor];
  self.tweetView.userMentionFont = [UIFont boldSystemFontOfSize:10];
  self.tweetView.urlColor = [UIColor blueColor];
  
  [self.tweetView sizeToFit];
}

@end
