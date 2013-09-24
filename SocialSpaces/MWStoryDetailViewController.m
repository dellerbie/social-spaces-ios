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
static NSString *kPhotosViewCell = @"PhotosViewCell";

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
        cell.textLabel.font = [UIFont boldSystemFontOfSize:10.0f];
        cell.textLabel.text = @"Related News Stories";
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
      }
    }
    else if(indexPath.section == 1)
    {
      if(indexPath.row < 3)
      {
        NSLog(@"Section %d, Row %d", indexPath.section, indexPath.row);
        cell = [tableView dequeueReusableCellWithIdentifier: kCommentViewCell];
      }
      else
      {
        cell = [tableView dequeueReusableCellWithIdentifier:normalCellIdentifier];
        if(!cell)
        {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:normalCellIdentifier];
        }
        cell.textLabel.font = [UIFont boldSystemFontOfSize:10.0f];
        cell.textLabel.text = @"View More Comments";
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
      }
    }
    else if(indexPath.section == 2)
    {
      if(indexPath.row == 0)
      {
        cell = [tableView dequeueReusableCellWithIdentifier:kPhotosViewCell];
        if(!cell)
        {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kPhotosViewCell];
        }
        
        int originX = 0;
        static int margin = 3;
        static int imageWidth = 64;
        static int nImages = 10;
        
        CGRect scrollFrame = CGRectMake(0, 5, tableView.frame.size.width, tableView.frame.size.height);
        UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame: scrollFrame];
        scrollView.contentSize = CGSizeMake((imageWidth + margin) * nImages, 100);
        
        for(int i = 0; i < nImages; i++)
        {
          UIImage *image = [UIImage imageNamed:@"breakingbad.jpeg"];
          UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
          imageView.contentMode = UIViewContentModeScaleAspectFill;
          CGRect imageRect = imageView.frame;
          imageRect.size.width = imageWidth;
          imageRect.size.height = imageWidth;
          imageRect.origin.x = originX;
          imageView.frame = imageRect;
          [scrollView addSubview:imageView];
          originX += imageWidth + margin;
        }
        [[cell contentView] addSubview:scrollView];
      }
      else
      {
        cell = [tableView dequeueReusableCellWithIdentifier:normalCellIdentifier];
        if(!cell)
        {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:normalCellIdentifier];
        }
        cell.textLabel.font = [UIFont boldSystemFontOfSize:10.0f];
        cell.textLabel.text = @"View More Photos & Videos";
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
    height = 76.0f;
  }
  else if(indexPath.section == 1 && indexPath.row < 3)
  {
    //height = 36.0 + 11.0;
      NSString *text = @"This fucking cancer Tony - I tell you. Don't you fuck me over Tony, I need that house for my wife. She's got nothing without me Tone.";
      UIFont *mainFont = [UIFont systemFontOfSize:10.0f];
      UIColor *color = [UIColor blackColor];
      NSDictionary *attributes = @{ NSFontAttributeName : mainFont, NSForegroundColorAttributeName : color };
      float textHeight = [text sizeWithAttributes:attributes].height;
      float usernameLabelHeight = 21.0;
      NSLog(@"text height: %f, text + label height: %f", textHeight, textHeight + usernameLabelHeight);
      
      float imageHeight = 36.0;
      
      //height = textHeight + usernameLabelHeight + margin;
      height = 70.0;
  }
  else if(indexPath.section == 2 && indexPath.row == 0)
  {
    height = 64.0 + 10;
  }
  
  return height;
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
  NSString *title = @"";
  
  switch (section)
  {
    case 0:
      title = @"The Scoop";
      break;
    case 1:
      title = @"What They Are Saying";
      break;
    case 2:
      title = @"Photos & Videos";
      break;
    default:
      break;
  }
  
  return title;
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
