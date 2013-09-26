//
//  MWCommentsViewController.m
//  SocialSpaces
//
//  Created by Derrick Ellerbie on 9/26/13.
//  Copyright (c) 2013 Derrick Ellerbie. All rights reserved.
//

#import "MWCommentsViewController.h"
#import "MWCommentViewCell.h"
#import "MWCommentView.h"

static NSString *kCommentViewCell = @"CommentViewCell";

@implementation MWCommentsViewController

- (void)viewDidLoad
{
  [super viewDidLoad];
  [self.tableView registerClass:[MWCommentViewCell class] forCellReuseIdentifier:kCommentViewCell];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
  return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
  return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCommentViewCell forIndexPath:indexPath];
  MWCommentViewCell *cv = (MWCommentViewCell *)cell;
  [cv resizeCommentView];
  return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
  return [MWCommentView heightForComment];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
  return @"Breaking Bad Finale";
}

@end
