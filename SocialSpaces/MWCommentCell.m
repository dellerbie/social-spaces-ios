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

#define CELL_MARGIN           (8.0)
#define PROFILE_PHOTO_SIZE    (36.0)
#define IMAGE_ATTACHMENT_SIZE (257.0)

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

- (void)setComment:(MWComment *)comment
{
  _comment = comment;
  [self refresh];
}

- (void)refresh
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

  [self createURLEntities:entities];
  [self createHashtagEntities:entities];
  [self createMentionEntities:entities];
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
  
  CGRect attachedImageViewFrame = self.attachedImageView.frame;
  self.attachedImageView.frame = CGRectMake(attachedImageViewFrame.origin.x, CGRectGetMaxY(self.tweetView.frame) + 3.0, attachedImageViewFrame.size.width, attachedImageViewFrame.size.height);
}

- (void)createURLEntities:(NSMutableArray *)entities
{
  NSDataDetector *detector = [NSDataDetector dataDetectorWithTypes:NSTextCheckingTypeLink error:NULL];
  NSArray *matches = [detector matchesInString:self.comment.comment
                                         options:0
                                           range:NSMakeRange(0, [self.comment.comment length])];

  for(NSTextCheckingResult *match in matches)
  {
    NSRange matchRange = [match range];
    WMATweetURLEntity *entity = [WMATweetURLEntity entityWithURL:[match URL]
                                                      expandedURL:[match URL]
                                                      displayURL:[[match URL] absoluteString] start:matchRange.location end:matchRange.location + matchRange.length];
    [entities addObject:entity];
  }
}

- (void)createHashtagEntities:(NSMutableArray *)entities
{
  NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"\\B#[a-z]+\\b" options:NSRegularExpressionCaseInsensitive error:NULL];
  NSArray *matches = [regex matchesInString:self.comment.comment options:0 range:NSMakeRange(0, [self.comment.comment length])];
  
  for (NSTextCheckingResult *match in matches)
  {
    NSRange matchRange = [match range];
    NSString *name = [self.comment.comment substringWithRange:matchRange];
    [entities addObject:[WMATweetHashtagEntity entityWithText:name start:matchRange.location end:matchRange.location + matchRange.length]];
  }
}

- (void)createMentionEntities:(NSMutableArray *)entities
{
  NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"\\B@\\w+\\b" options:NSRegularExpressionCaseInsensitive error:NULL];
  NSArray *matches = [regex matchesInString:self.comment.comment options:0 range:NSMakeRange(0, [self.comment.comment length])];
  
  for (NSTextCheckingResult *match in matches)
  {
    NSRange matchRange = [match range];
    NSString *name = [self.comment.comment substringWithRange:matchRange];
    WMATweetUserMentionEntity *entity = [WMATweetUserMentionEntity entityWithScreenName:name
                                                                                    name:name
                                                                                    idString:@""
                                                                                    start:matchRange.location
                                                                                    end:matchRange.location + matchRange.length];
    [entities addObject:entity];
  }
}

+ (CGFloat)heightForComment:(MWComment *)comment
{
  NSMutableAttributedString *commentString = [[NSMutableAttributedString alloc] initWithString:comment.comment];
  NSDictionary *attributes = @{ NSFontAttributeName : [UIFont boldSystemFontOfSize:10.0], NSForegroundColorAttributeName : [UIColor darkTextColor] };
  [commentString setAttributes:attributes range:NSMakeRange(0, [comment.comment length])];
  
  CGFloat screenWidth = [[UIScreen mainScreen] bounds].size.width;
  
  CGFloat width = screenWidth - (CELL_MARGIN * 2) - PROFILE_PHOTO_SIZE;
  CGFloat height = [commentString boundingRectWithSize: CGSizeMake(width, 1000) options:NSStringDrawingUsesLineFragmentOrigin context:nil].size.height;
  height += 14.0;
  
  if(comment.attachedImage)
  {
    height += IMAGE_ATTACHMENT_SIZE + CELL_MARGIN;
  }
  
  return height;
}

@end
