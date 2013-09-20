//
//  MWStoryDetailViewController.m
//  SocialSpaces
//
//  Created by Derrick Ellerbie on 9/20/13.
//  Copyright (c) 2013 Derrick Ellerbie. All rights reserved.
//

#import "MWStoryDetailViewController.h"
#import "MWStoryViewCell.h"
#import "MWCommentViewCell.h"

@interface MWStoryDetailViewController ()

@end

static NSString *kStoryViewCell = @"StoryViewCell";
static NSString *kCommentViewCell = @"CommentViewCell";

@implementation MWStoryDetailViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if(self)
    {
      
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.tableView registerNib:[UINib nibWithNibName:@"MWStoryViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier: kStoryViewCell];
    [self.tableView registerNib:[UINib nibWithNibName:@"MWCommentViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier: kCommentViewCell];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger nRows = 0;
  
    switch (section)
    {
      case 0:
        nRows = 2;
        break;
      case 1:
        nRows = 4;
        break;
      case 2:
        nRows = 2;
        break;
      default:
        break;
    }
    // Return the number of rows in the section.
    return nRows;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *normalCellIdentifier = @"NormalCell";
    UITableViewCell *cell = nil;
  
    // Configure the cell...
    if(indexPath.section == 0)
    {
      if(indexPath.row == 0)
      {
        cell = [tableView dequeueReusableCellWithIdentifier:kStoryViewCell];
      }
      else
      {
        cell = [tableView dequeueReusableCellWithIdentifier:normalCellIdentifier];
        if(!cell)
        {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:normalCellIdentifier];
        }
        cell.textLabel.text = @"Related News Stories";
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
      }
    }
    else if(indexPath.section == 1)
    {
      if(indexPath.row < 3)
      {
        NSLog(@"Section %d, Row %d", indexPath.section, indexPath.row);
        cell = [tableView dequeueReusableCellWithIdentifier:kCommentViewCell];
      }
      else
      {
        cell = [tableView dequeueReusableCellWithIdentifier:normalCellIdentifier];
        if(!cell)
        {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:normalCellIdentifier];
        }
        cell.textLabel.text = @"View More Comments";
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
      }
    }
  
    if(!cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:normalCellIdentifier];
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
  CGFloat height = 44.0f;
  
  if(indexPath.section == 0 && indexPath.row == 0)
  {
    height = 84.0f;
  }
  else if(indexPath.section == 1 && indexPath.row < 3)
  {
    NSString *text = @"This fucking cancer Tony - I tell you. Don't you fuck me over Tony, I need that house for my wife. She's got nothing without me Tone.";
    UIFont *mainFont = [UIFont systemFontOfSize: 12.0];
    NSDictionary *mainTextAttributes = @{ NSFontAttributeName : mainFont };
    CGSize size = [text sizeWithAttributes:mainTextAttributes];
    NSLog(@"Text height %f", size.height);
    height = 36.0 + 16.0;
  }
  
  return height;
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
