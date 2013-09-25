//
//  MWCommentView.m
//  SocialSpaces
//
//  Created by Derrick Ellerbie on 9/23/13.
//  Copyright (c) 2013 Derrick Ellerbie. All rights reserved.
//

#import "MWCommentView.h"

@implementation MWCommentView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    UIImage *image = [UIImage imageNamed:@"sopranos.jpg"];
    CGSize newSize = CGSizeMake(36.0, 36.0);
    CGRect newRect = CGRectMake(0,0,newSize.width,newSize.height);
    UIGraphicsBeginImageContext( newSize );
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:newRect cornerRadius:5.0];
    [path addClip];
    [image drawInRect:newRect];
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();

    CGFloat imageY = (self.bounds.size.height - 36.0f) / 2;
    CGPoint point = CGPointMake(8.0, imageY);
    [newImage drawAtPoint:point];
    
    UIColor *mainTextColor = [UIColor blackColor];
    UIFont *mainFont = [UIFont systemFontOfSize:10.0f];
    UIFont *boldFont = [UIFont boldSystemFontOfSize:10.0f];
  
    NSDictionary *mainTextAttributes = @{ NSFontAttributeName : mainFont, NSForegroundColorAttributeName : mainTextColor };
    NSDictionary *usernameTextAttributes = @{ NSFontAttributeName : boldFont, NSForegroundColorAttributeName : mainTextColor };
  
    NSString *username = @"@JohnnySacks";
    NSAttributedString *usernameString = [[NSAttributedString alloc] initWithString:username attributes:usernameTextAttributes];
    point = CGPointMake(36.0f + 14.0f, 4.0f);
    [usernameString drawAtPoint:point];
    
    NSString *comment = @"This fucking cancer Tony - I tell you. Don't you fuck me over Tony, I need that house for my wife. She's got nothing without me Tone.";
    
    NSAttributedString *commentString = [[NSAttributedString alloc] initWithString:comment attributes:mainTextAttributes];
    CGSize usernameSize = [username sizeWithAttributes:mainTextAttributes];
    point = CGPointMake(36.0f + 14.0f, 4.0f + usernameSize.height + 4.0f);
  
    NSLog(@"cell bounds size: %f, %f", self.bounds.size.width, self.bounds.size.height);
  
    float commentRectWidth = self.bounds.size.width - 36.0 - 14.0 - 10.0;
  
    CGSize commentSize = [commentString boundingRectWithSize:CGSizeMake(commentRectWidth, 1000) options:NSStringDrawingUsesLineFragmentOrigin context:nil].size;
    CGRect commentRect = CGRectMake(point.x, point.y, commentSize.width, commentSize.height);
    [commentString drawInRect:commentRect];
}

@end
