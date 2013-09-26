//
//  MWArticlesViewController.m
//  SocialSpaces
//
//  Created by Derrick Ellerbie on 9/26/13.
//  Copyright (c) 2013 Derrick Ellerbie. All rights reserved.
//

#import "MWArticlesViewController.h"

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
  return @"Breaking Bad";
}

/*
#pragma mark - Table view delegate

// In a xib-based application, navigation from a table can be handled in -tableView:didSelectRowAtIndexPath:
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here, for example:
    // Create the next view controller.
    <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];

    // Pass the selected object to the new view controller.
    
    // Push the view controller.
    [self.navigationController pushViewController:detailViewController animated:YES];
}
 
 */

@end
