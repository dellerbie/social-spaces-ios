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
#import "MWCommentView.h"
#import "MWArticlesViewController.h"
#import "MWCommentsViewController.h"
#import "MWImagesViewController.h"

static NSString *kStoryViewCell = @"StoryViewCell";
static NSString *kCommentViewCell = @"CommentViewCell";
static NSString *kPhotosViewCell = @"PhotosViewCell";

@implementation MWStoryDetailViewController

- (void)viewDidLoad
{
  [super viewDidLoad];
  [self.tableView registerNib:[UINib nibWithNibName:@"MWStoryViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier: kStoryViewCell];
  [self.tableView registerClass:[MWCommentViewCell class] forCellReuseIdentifier:kCommentViewCell];
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
      nRows = 6;
      break;
    case 2:
      nRows = 2;
      break;
    default:
      break;
  }
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
    if(indexPath.row < 5)
    {
      cell = [tableView dequeueReusableCellWithIdentifier: kCommentViewCell];
      MWCommentViewCell *cv = (MWCommentViewCell *)cell;
      [cv resizeCommentView];
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
      cell.textLabel.text = @"View More Photos";
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
  else if(indexPath.section == 1 && indexPath.row < 5)
  {
      height = [MWCommentView heightForComment];
  }
  else if(indexPath.section == 2 && indexPath.row == 0)
  {
    height = 64.0 + 10;
  }
  
  return height;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
  id viewController = nil;
  BOOL validSelection = YES;
  
  if(indexPath.section == 0 && indexPath.row == 1)
  {
    viewController = [[MWArticlesViewController alloc] initWithStyle:UITableViewStylePlain];
    [viewController setTitle:@"Articles"];
  }
  else if(indexPath.section == 1 && indexPath.row == 5)
  {
    viewController = [[MWCommentsViewController alloc] initWithStyle:UITableViewStylePlain];
    [viewController setTitle:@"Comments"];
  }
  else if(indexPath.section == 2 && indexPath.row == 1)
  {
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    viewController = [[MWImagesViewController alloc] initWithCollectionViewLayout:layout];
    [viewController setTitle:@"Photos"];
  }
  else
  {
    validSelection = NO;
  }

  if(validSelection)
  {
    [self.navigationController pushViewController:viewController animated:YES];
  }
}

@end
