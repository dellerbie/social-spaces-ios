//
//  MWCommentView.m
//  SocialSpaces
//
//  Created by Derrick Ellerbie on 9/23/13.
//  Copyright (c) 2013 Derrick Ellerbie. All rights reserved.
//

#import "MWCommentView.h"
#import "UIImage+ResizeAdditions.h"

@implementation MWCommentView

const CGFloat PROFILE_IMAGE_WIDTH = 36.0;
const CGFloat PROFILE_IMAGE_HEIGHT = 36.0;
const CGFloat FONT_SIZE = 10.0;
const CGFloat MIDDLE_COLUMN_LEFT_MARGIN = 14.0;
const CGFloat USERNAME_COMMENT_TOP_MARGIN = 8.0;
const CGFloat CELL_MARGIN_LEFT_RIGHT = 8.0;
const CGFloat CELL_MARGIN_TOP_BOTTOM = 5.0;

+(CGFloat)heightForComment
{
  NSAttributedString *commentString = [MWCommentView commentString];
  float commentRectWidth = 320 - PROFILE_IMAGE_WIDTH - MIDDLE_COLUMN_LEFT_MARGIN - CELL_MARGIN_LEFT_RIGHT;
  CGSize commentSize = [commentString boundingRectWithSize:CGSizeMake(commentRectWidth, 1000) options:NSStringDrawingUsesLineFragmentOrigin context:nil].size;
  CGFloat height = CELL_MARGIN_TOP_BOTTOM + USERNAME_COMMENT_TOP_MARGIN + FONT_SIZE + commentSize.height;
  return height;
}

// dummy data
+(NSAttributedString *)commentString
{
  UIColor *mainTextColor = [UIColor blackColor];
  UIFont *mainFont = [UIFont systemFontOfSize:FONT_SIZE];
  NSDictionary *mainTextAttributes = @{ NSFontAttributeName : mainFont, NSForegroundColorAttributeName : mainTextColor };

  NSString *comment = @"This fucking cancer Tony - I tell you. Don't you fuck me over Tony, I need that house for my wife. She's got nothing without me Tone.";
  NSAttributedString *commentString = [[NSAttributedString alloc] initWithString:comment attributes:mainTextAttributes];
  return commentString;
}

- (void)drawRect:(CGRect)rect
{
  [self drawProfileImage];
  [self drawUsernameAndCommentSource];
  [self drawComment];
}

- (void)drawProfileImage
{
  CGRect rect = CGRectMake(0, 0, PROFILE_IMAGE_WIDTH, PROFILE_IMAGE_HEIGHT);
  UIGraphicsBeginImageContextWithOptions(rect.size, NO, 0.0);
  UIImage *image = [[UIImage imageNamed:@"sopranos.jpg"] fillSize:rect.size];
  [[UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:5.0] addClip];
  [image drawInRect:rect];
  UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
  UIGraphicsEndImageContext();
  [newImage drawAtPoint:CGPointMake(CELL_MARGIN_LEFT_RIGHT, CELL_MARGIN_TOP_BOTTOM)];
}

-(void)drawUsernameAndCommentSource
{
  UIColor *mainTextColor = [UIColor blackColor];
  UIFont *boldFont = [UIFont boldSystemFontOfSize:FONT_SIZE];

  NSDictionary *attributesForUsername = @{ NSFontAttributeName : boldFont, NSForegroundColorAttributeName : mainTextColor };
  NSDictionary *attributesForVia = @{NSFontAttributeName : [UIFont systemFontOfSize:10.0], NSForegroundColorAttributeName: [UIColor lightGrayColor] };

  NSString *username = @"@JohnnySacks";
  NSString *via = @"via Twitter";
  NSString *strings = [@[username, via] componentsJoinedByString:@" "];

  NSMutableAttributedString *usernameAndSource = [[NSMutableAttributedString alloc] initWithString:strings];
  [usernameAndSource setAttributes:attributesForUsername range:[strings rangeOfString:username]];
  [usernameAndSource setAttributes:attributesForVia range:[strings rangeOfString:via]];
  CGPoint point = CGPointMake(PROFILE_IMAGE_WIDTH + MIDDLE_COLUMN_LEFT_MARGIN, CELL_MARGIN_TOP_BOTTOM - 3);
  [usernameAndSource drawAtPoint:point];
}

-(void)drawComment
{
  UIColor *mainTextColor = [UIColor blackColor];
  UIFont *mainFont = [UIFont systemFontOfSize:FONT_SIZE];
  NSDictionary *mainTextAttributes = @{ NSFontAttributeName : mainFont, NSForegroundColorAttributeName : mainTextColor };

  NSString *comment = @"This fucking cancer Tony - I tell you. Don't you fuck me over Tony, I need that house for my wife. She's got nothing without me Tone.";
  NSAttributedString *commentString = [[NSAttributedString alloc] initWithString:comment attributes:mainTextAttributes];

  float commentRectWidth = self.bounds.size.width - PROFILE_IMAGE_WIDTH - MIDDLE_COLUMN_LEFT_MARGIN - CELL_MARGIN_LEFT_RIGHT;
  CGSize commentSize = [commentString boundingRectWithSize:CGSizeMake(commentRectWidth, 1000) options:NSStringDrawingUsesLineFragmentOrigin context:nil].size;
  CGRect commentRect = CGRectMake(PROFILE_IMAGE_WIDTH + MIDDLE_COLUMN_LEFT_MARGIN, FONT_SIZE + 8.0, commentSize.width, 100);

  [commentString drawInRect:commentRect];
}

@end
