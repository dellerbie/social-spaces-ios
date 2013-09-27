//
//  MWImageDetailViewController.m
//  SocialSpaces
//
//  Created by Derrick Ellerbie on 9/27/13.
//  Copyright (c) 2013 Derrick Ellerbie. All rights reserved.
//

#import "MWImageDetailViewController.h"

@implementation MWImageDetailViewController

- (void)viewWillAppear:(BOOL)animated
{
  [super viewWillAppear:animated];
  self.imageView.image = self.image;
}

@end
