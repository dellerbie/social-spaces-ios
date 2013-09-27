//
//  MWImagesViewController.m
//  SocialSpaces
//
//  Created by Derrick Ellerbie on 9/26/13.
//  Copyright (c) 2013 Derrick Ellerbie. All rights reserved.
//

#import "MWImagesViewController.h"
#import "MWImagesCell.h"
#import "UIImage+ResizeAdditions.h"

static NSString *kImageCell = @"ImageCell";

@implementation MWImagesViewController

- (void)viewDidLoad
{
  [super viewDidLoad];
  [[self collectionView] registerNib:[UINib nibWithNibName:@"MWImagesCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:kImageCell];
  
  self.collectionView.backgroundColor = [UIColor lightTextColor];
}

- (NSInteger)collectionView:(UICollectionView *)view numberOfItemsInSection:(NSInteger)section;
{
  return 32;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)cv cellForItemAtIndexPath:(NSIndexPath *)indexPath;
{
  
  MWImagesCell *cell = [cv dequeueReusableCellWithReuseIdentifier:kImageCell forIndexPath:indexPath];
  NSString *imageName = [NSString stringWithFormat:@"breakingbad%d.jpg", (indexPath.row % 4) + 1];
  cell.imageView.image = [[UIImage imageNamed:imageName] fillSize:CGSizeMake(100, 100)];
  
  return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
  return CGSizeMake(100, 100);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
  return 5.0;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
  return 5.0;
}

@end
