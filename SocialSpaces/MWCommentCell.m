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
  /*NSURL *url = [NSURL URLWithString:@"http://t.co/dQ06Fbx3"];
  [entities addObject:[WMATweetURLEntity entityWithURL:url expandedURL:url displayURL:@"http://t.co/dQ06Fbx3" start:18 end:38]];
  [entities addObject:[WMATweetUserMentionEntity entityWithScreenName:@"ZarroBoogs" name:@"Mark Beaton" idString:@"547490130" start:120 end:131]];
  [entities addObject:[WMATweetHashtagEntity entityWithText:@"ios" start:132 end:136]];*/

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

@end
