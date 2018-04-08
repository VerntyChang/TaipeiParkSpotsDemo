//
//  TaipeiParkSpotViewController.m
//  TaipeiParks
//
//  Created by Vernty on 2018/4/7.
//  Copyright © 2018年 VerntyChang. All rights reserved.
//

#import "TaipeiParkSpotDetailViewController.h"
#import "TaipeiParkSpots.h"
#import "UIImageView+WebCache.h"
#import "OtherSpotCollectionViewCell.h"

@interface TaipeiParkSpotDetailViewController()
@property (strong, nonatomic) IBOutlet UILabel *parkName;
@property (strong, nonatomic) IBOutlet UILabel *spotName;
@property (strong, nonatomic) IBOutlet UILabel *openTime;
@property (strong, nonatomic) IBOutlet UILabel *introduction;
@property (strong, nonatomic) IBOutlet UIImageView *imageView;
@property (strong, nonatomic) IBOutlet UICollectionView *otherSpotsCollectionView;
@property (strong, nonatomic) IBOutlet UILabel *otherSpotsLabel;

@end

@implementation TaipeiParkSpotDetailViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    Spot* spotDetial = [self.dataManager fetchSpotAtSpotIndex:self.spotIndex atParkIndex:self.parkIndex];
    
    self.parkName.text = spotDetial.ParkName;
    self.spotName.text =  spotDetial.Name;
    self.openTime.text =  spotDetial.OpenTime;
    self.introduction.text = spotDetial.Introduction;
     
    [self.imageView sd_setImageWithPreviousCachedImageWithURL:[NSURL URLWithString: spotDetial.Image] placeholderImage:[UIImage imageNamed:@"taiwan-default.jpg"] options:SDWebImageCacheMemoryOnly progress:^(NSInteger receivedSize, NSInteger expectedSize) {
    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {  } ];
    
    [self.otherSpotsCollectionView reloadData];
}

#pragma mark - UICollectionViewDataSource
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    int otherSpotsCount = (int)[self.dataManager spotCountAtParkIndex:self.parkIndex] -1;
    if(otherSpotsCount == 0) self.otherSpotsLabel.hidden = true;
    
    return otherSpotsCount;
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
   OtherSpotCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"OtherSpotCell" forIndexPath:indexPath];
    
    int shiftedSpotIndex = (indexPath.row >= self.spotIndex) ? ((int)indexPath.row+1):(int)indexPath.row;
    
    Spot* spotDetial = [self.dataManager fetchSpotAtSpotIndex:shiftedSpotIndex atParkIndex:self.parkIndex] ;
    
    cell.otherSpotName.text = spotDetial.Name;
    [cell.otherSpotImage sd_setImageWithPreviousCachedImageWithURL:[NSURL URLWithString:spotDetial.Image] placeholderImage:[UIImage imageNamed:@"taiwan-default.jpg"] options:SDWebImageCacheMemoryOnly progress:^(NSInteger receivedSize, NSInteger expectedSize) {
    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) { } ];
    
    return cell;
}

@end
