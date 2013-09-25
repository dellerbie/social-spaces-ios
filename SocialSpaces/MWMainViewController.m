//
//  MWMainViewController.m
//  SocialSpaces
//
//  Created by Derrick Ellerbie on 9/20/13.
//  Copyright (c) 2013 Derrick Ellerbie. All rights reserved.
//

#import "MWMainViewController.h"
#import "MWStoryDetailViewController.h"

@interface MWMainViewController ()

@property (nonatomic, strong) NSArray *data;

@end

const static NSString *kStoryTitleKey = @"StoryTitle";
const static NSString *kStoryImageKey = @"Image";

@implementation MWMainViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
      self.data = @[
        @[@{kStoryTitleKey: @"Breaking Bad Finale", kStoryImageKey: @"breakingbad.jpeg"}, @{kStoryTitleKey: @"Led Zeppelin Reunion", kStoryImageKey: @"ledzeppelin.png"}],
        @[@{kStoryTitleKey: @"James Goldolfini", kStoryImageKey: @"sopranos.jpg"}, @{kStoryTitleKey: @"Fender's 70th Anniversary", kStoryImageKey: @"fender.png"}],
        @[@{kStoryTitleKey: @"Fender's 70th Anniversary", kStoryImageKey: @"fender.png"}, @{kStoryTitleKey: @"James Goldolfini", kStoryImageKey: @"sopranos.jpg"}],
        @[@{kStoryTitleKey: @"Led Zeppelin Reunion", kStoryImageKey: @"ledzeppelin.png"}, @{kStoryTitleKey: @"Breaking Bad Finale", kStoryImageKey: @"breakingbad.jpeg"}]
      ];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return [self.data count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [[[self data] objectAtIndex:section] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    // Configure the cell...
    NSDictionary *record = [[[self data] objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    cell.imageView.image = [UIImage imageNamed: [record objectForKey:kStoryImageKey]];
    cell.textLabel.text = [record objectForKey:kStoryTitleKey];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
  NSString *title = @"";
  
  switch (section)
  {
    case 0:
      title = @"Sports";
      break;
    case 1:
      title = @"Technology";
      break;
    case 2:
      title = @"Fitness";
      break;
    case 3:
      title = @"Dime Pieces";
      break;
    default:
      break;
  }
  
  return title;
}

#pragma mark - Table view delegate

// In a xib-based application, navigation from a table can be handled in -tableView:didSelectRowAtIndexPath:
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here, for example:
    // Create the next view controller.
    MWStoryDetailViewController *detailViewController = [[MWStoryDetailViewController alloc] initWithNibName:@"MWStoryDetailViewController" bundle:nil];
    [detailViewController setTitle:@"Breaking Bad Finale"];

    // Pass the selected object to the new view controller.
    
    // Push the view controller.
    [self.navigationController pushViewController:detailViewController animated:YES];
}

@end
