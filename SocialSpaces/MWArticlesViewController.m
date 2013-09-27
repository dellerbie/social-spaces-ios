//
//  MWArticlesViewController.m
//  SocialSpaces
//
//  Created by Derrick Ellerbie on 9/26/13.
//  Copyright (c) 2013 Derrick Ellerbie. All rights reserved.
//

#import "MWArticlesViewController.h"
#import "MWWebViewController.h"

static NSString *kStoryViewCell = @"StoryViewCell";

@implementation MWArticlesViewController

- (void)viewDidLoad
{
  [super viewDidLoad];
  [self.tableView registerNib:[UINib nibWithNibName:@"MWStoryViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier: kStoryViewCell];
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
  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kStoryViewCell];
  
  return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
  return 76.0f;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
  return @"Breaking Bad Finale";
}


#pragma mark - Table view delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
  MWWebViewController *vc = [[MWWebViewController alloc] init];
  NSURL *url = [NSURL URLWithString:@"http://www.google.com"];
  NSURLRequest *request = [NSURLRequest requestWithURL:url];
  [vc.webView loadRequest: request];
  [self.navigationController pushViewController:vc animated:YES];
}

@end
