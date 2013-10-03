//
//  MWCommentCell.h
//  SocialSpaces
//
//  Created by Derrick Ellerbie on 10/3/13.
//  Copyright (c) 2013 Derrick Ellerbie. All rights reserved.
//

#import <UIKit/UIKit.h>
@class WMATweetView;

@interface MWCommentCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;
@property (weak, nonatomic) IBOutlet UILabel *usernameLabel;
@property (weak, nonatomic) IBOutlet WMATweetView *tweetView;
@property (weak, nonatomic) IBOutlet UIImageView *attachedImageView;

@end
