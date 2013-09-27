//
//  MWImageDetailViewController.h
//  SocialSpaces
//
//  Created by Derrick Ellerbie on 9/27/13.
//  Copyright (c) 2013 Derrick Ellerbie. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MWImageDetailViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (nonatomic, strong) UIImage *image;

@end
