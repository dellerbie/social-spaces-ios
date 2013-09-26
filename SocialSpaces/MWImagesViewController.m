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
}

- (NSInteger)collectionView:(UICollectionView *)view numberOfItemsInSection:(NSInteger)section;
{
  return 32;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)cv cellForItemAtIndexPath:(NSIndexPath *)indexPath;
{
  
  MWImagesCell *cell = [cv dequeueReusableCellWithReuseIdentifier:kImageCell forIndexPath:indexPath];
  cell.imageView.image = [[UIImage imageNamed:@"sopranos.jpg"] fillSize: CGSizeMake(100, 100)];
  
  return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
  return CGSizeMake(100, 100);
}

@end
