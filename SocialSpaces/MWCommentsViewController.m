//
//  MWCommentsViewController.m
//  SocialSpaces
//
//  Created by Derrick Ellerbie on 9/26/13.
//  Copyright (c) 2013 Derrick Ellerbie. All rights reserved.
//

#import "MWCommentsViewController.h"
#import "MWCommentCell.h"
#import "MWComment.h"
#import "WMATweetView.h"
#import "MWWebViewController.h"

static NSString *kCommentCell = @"CommentCell";

@implementation MWCommentsViewController

- (void)viewDidLoad
{
  [super viewDidLoad];
  [self.tableView registerNib:[UINib nibWithNibName:@"MWCommentCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier: kCommentCell];
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
  MWCommentCell *cell = [tableView dequeueReusableCellWithIdentifier:kCommentCell forIndexPath:indexPath];
  
  MWComment *comment = [[MWComment alloc] init];
  comment.profileImage = [NSString stringWithFormat:@"breakingbad%d.jpg", (arc4random()%4) + 1];
  comment.attachedImage = [NSString stringWithFormat:@"breakingbad%d.jpg", (arc4random()%4) + 1];
  comment.username = @"@JohnnySacks";
  comment.via = @"Twitter";
  comment.comment = @"Tweet with a link http://t.co/dQ06Fbx3, screen name @wemakeapps, #hashtag, more text, another link http://t.co/9GQa6ycA @ZarroBoogs #ios moo";
  cell.comment = comment;
  
  cell.tweetView.urlTapped = ^(WMATweetURLEntity *entity, NSUInteger numberOfTouches)
  {
    MWWebViewController *vc = [[MWWebViewController alloc] init];
    NSURLRequest *request = [NSURLRequest requestWithURL:[entity URL]];
    [vc.webView loadRequest: request];
    [self.navigationController pushViewController:vc animated:YES];
  };
  
  cell.selectionStyle = UITableViewCellSelectionStyleNone;
  
  return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
  return 325.0;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
  return @"Breaking Bad Finale";
}

@end
