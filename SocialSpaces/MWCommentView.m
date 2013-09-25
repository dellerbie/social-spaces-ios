//
//  MWCommentView.m
//  SocialSpaces
//
//  Created by Derrick Ellerbie on 9/23/13.
//  Copyright (c) 2013 Derrick Ellerbie. All rights reserved.
//

#import "MWCommentView.h"

@implementation MWCommentView

const CGFloat PROFILE_IMAGE_WIDTH = 36.0;
const CGFloat PROFILE_IMAGE_HEIGHT = 36.0;
const CGFloat FONT_SIZE = 10.0;
const CGFloat MIDDLE_COLUMN_LEFT_MARGIN = 14.0;
const CGFloat USERNAME_COMMENT_TOP_MARGIN = 8.0;
const CGFloat CELL_MARGIN_LEFT_RIGHT = 8.0;
const CGFloat CELL_MARGIN_TOP_BOTTOM = 4.0;

+(CGFloat)heightForComment
{
    NSAttributedString *commentString = [MWCommentView commentString];
    float commentRectWidth = 320 - PROFILE_IMAGE_WIDTH - MIDDLE_COLUMN_LEFT_MARGIN - CELL_MARGIN_LEFT_RIGHT;
    CGSize commentSize = [commentString boundingRectWithSize:CGSizeMake(commentRectWidth, 1000) options:NSStringDrawingUsesLineFragmentOrigin context:nil].size;
    
    CGFloat height = (CELL_MARGIN_TOP_BOTTOM * 2.0) + USERNAME_COMMENT_TOP_MARGIN + FONT_SIZE + commentSize.height;
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

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    NSLog(@"drawRect");
    [self drawProfileImage];
    [self drawUsernameAndCommentSource];
    [self drawComment];
}

- (void)drawProfileImage
{
    UIImage *image = [UIImage imageNamed:@"sopranos.jpg"];
    CGSize newSize = CGSizeMake(PROFILE_IMAGE_WIDTH, PROFILE_IMAGE_HEIGHT);
    //CGRect newRect = CGRectMake(0,0,newSize.width,newSize.height);
    
    UIImage *newImage = [self fillSize:newSize withImage:image];
//    UIImage *newImage = [self centerInSize:newSize withImage:image];
    
    CGPoint point = CGPointMake(CELL_MARGIN_LEFT_RIGHT, CELL_MARGIN_TOP_BOTTOM * 2);
    [newImage drawAtPoint:point];
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
    CGPoint point = CGPointMake(PROFILE_IMAGE_WIDTH + MIDDLE_COLUMN_LEFT_MARGIN, CELL_MARGIN_TOP_BOTTOM);
    [usernameAndSource drawAtPoint:point];
}

-(void)drawComment
{
    UIColor *mainTextColor = [UIColor blackColor];
    UIFont *mainFont = [UIFont systemFontOfSize:FONT_SIZE];
    
    NSDictionary *mainTextAttributes = @{ NSFontAttributeName : mainFont, NSForegroundColorAttributeName : mainTextColor };
    
    NSString *comment = @"This fucking cancer Tony - I tell you. Don't you fuck me over Tony, I need that house for my wife. She's got nothing without me Tone.";
    
    NSAttributedString *commentString = [[NSAttributedString alloc] initWithString:comment attributes:mainTextAttributes];
    
    CGPoint point = CGPointMake(PROFILE_IMAGE_WIDTH + MIDDLE_COLUMN_LEFT_MARGIN, FONT_SIZE + 8.0);
    
    NSLog(@"cell bounds size: %f, %f", self.bounds.size.width, self.bounds.size.height);
    
    float commentRectWidth = self.bounds.size.width - PROFILE_IMAGE_WIDTH - MIDDLE_COLUMN_LEFT_MARGIN - CELL_MARGIN_LEFT_RIGHT;
    
    CGSize commentSize = [commentString boundingRectWithSize:CGSizeMake(commentRectWidth, 1000) options:NSStringDrawingUsesLineFragmentOrigin context:nil].size;
    NSLog(@"commentSize height: %f", commentSize.height);
    CGRect commentRect = CGRectMake(point.x, point.y, commentSize.width, 100);
    
    [commentString drawInRect:commentRect];
    
}

- (UIImage *)centerInSize: (CGSize)viewsize withImage:(UIImage *)image
{
    CGSize size = image.size;
    UIGraphicsBeginImageContext(viewsize);
    // Calculate the offset to ensure that the image center is set
    // to the view center
    float dwidth = (viewsize.width - size.width) / 2.0f;
    float dheight = (viewsize.height - size.height) / 2.0f;
    CGRect rect = CGRectMake(dwidth, dheight, size.width, size.height);
    [image drawInRect:rect];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

- (UIImage *)fillSize:(CGSize)viewsize withImage:(UIImage *)image
{
    CGSize size = image.size;
    // Choose the scale factor that requires the least scaling
    CGFloat scalex = viewsize.width / size.width;
    CGFloat scaley = viewsize.height / size.height;
    CGFloat scale = MAX(scalex, scaley);
    UIGraphicsBeginImageContext(viewsize);
    CGFloat width = size.width * scale;
    CGFloat height = size.height * scale;
    // Center the scaled image
    float dwidth = ((viewsize.width - width) / 2.0f);
    float dheight = ((viewsize.height - height) / 2.0f);
    
    CGRect rect = CGRectMake(dwidth, dheight, size.width * scale, size.height * scale);
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:5.0];
    [path addClip];
    
    [image drawInRect:rect];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

@end
