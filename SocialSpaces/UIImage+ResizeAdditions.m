//
//  UIImage+ResizeAdditions.m
//  SocialSpaces
//
//  Created by Derrick Ellerbie on 9/26/13.
//  Copyright (c) 2013 Derrick Ellerbie. All rights reserved.
//

#import "UIImage+ResizeAdditions.h"

@implementation UIImage (ResizeAdditions)

- (UIImage *)fillSize:(CGSize)newSize
{
  double ratio;
  double delta;
  CGPoint offset;

  //figure out if the picture is landscape or portrait, then
  //calculate scale factor and offset
  if (self.size.width > self.size.height) {
      ratio = newSize.width / self.size.width;
      delta = (ratio*self.size.width - ratio*self.size.height);
      offset = CGPointMake(delta/2, 0);
  } else {
      ratio = newSize.width / self.size.height;
      delta = (ratio*self.size.height - ratio*self.size.width);
      offset = CGPointMake(0, delta/2);
  }

  //make the final clipping rect based on the calculated values
  CGRect clipRect = CGRectMake(-offset.x, -offset.y,
                               (ratio * self.size.width) + delta,
                               (ratio * self.size.height) + delta);


  //start a new context, with scale factor 0.0 so retina displays get
  //high quality image
  if ([[UIScreen mainScreen] respondsToSelector:@selector(scale)]) {
      UIGraphicsBeginImageContextWithOptions(newSize, YES, 0.0);
  } else {
      UIGraphicsBeginImageContext(newSize);
  }
  UIRectClip(clipRect);
  [self drawInRect:clipRect];
  UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
  UIGraphicsEndImageContext();

  return newImage;
}

@end
