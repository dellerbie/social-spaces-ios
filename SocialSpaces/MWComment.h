//
//  MWComment.h
//  SocialSpaces
//
//  Created by Derrick Ellerbie on 10/3/13.
//  Copyright (c) 2013 Derrick Ellerbie. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MWComment : NSObject

@property (nonatomic, strong) NSString *comment;
@property (nonatomic, strong) NSString *profileImage;
@property (nonatomic, strong) NSString *username;
@property (nonatomic, strong) NSString *via;
@property (nonatomic, strong) NSString *attachedImage;

@end
