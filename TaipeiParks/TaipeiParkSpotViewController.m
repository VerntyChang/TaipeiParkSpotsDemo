//
//  TaipeiParkSpotViewController.m
//  TaipeiParks
//
//  Created by Vernty on 2018/4/7.
//  Copyright © 2018年 VerntyChang. All rights reserved.
//

#import "TaipeiParkSpotViewController.h"
#import "TaipeiParkSpots.h"
#import "UIImageView+WebCache.h"
#import "OtherSpotCollectionViewCell.h"

@interface TaipeiParkSpotViewController()
@property (strong, nonatomic) IBOutlet UILabel *parkName;
@property (strong, nonatomic) IBOutlet UILabel *spotName;
@property (strong, nonatomic) IBOutlet UILabel *openTime;
@property (strong, nonatomic) IBOutlet UILabel *introduction;
@property (strong, nonatomic) IBOutlet UIImageView *imageView;
@property (strong, nonatomic) IBOutlet UICollectionView *otherSpotsCollectionView;
@property (strong, nonatomic) IBOutlet UILabel *otherSpotsLabel;

@property (strong, nonatomic) NSArray* spotsOfPark; 
@end

@implementation TaipeiParkSpotViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
     self.spotsOfPark = [self.arrayOfArrays objectAtIndex: self.parkIndex];
     Results* spotDetial = [ self.spotsOfPark objectAtIndex:self.spotIndex];
    
    self.parkName.text = spotDetial.ParkName;
    self.spotName.text = spotDetial.Name;
    self.openTime.text = [NSString stringWithFormat:@"開放時間：%@",spotDetial.OpenTime];
    self.introduction.text = spotDetial.Introduction;
     
    [self.imageView sd_setImageWithPreviousCachedImageWithURL:[NSURL URLWithString:spotDetial.Image] placeholderImage:[UIImage imageNamed:@"taiwan-default.jpg"] options:SDWebImageCacheMemoryOnly progress:^(NSInteger receivedSize, NSInteger expectedSize) {
    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {  } ];
    
    [self.otherSpotsCollectionView reloadData];
}

#pragma mark - UICollectionViewDataSource
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    int otherSpotsCount = (int)[self.spotsOfPark count] -1;
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
    
    int shiftedIndex = (indexPath.row >= self.spotIndex) ? ((int)indexPath.row+1):(int)indexPath.row;
    Results* spotDetial = self.spotsOfPark[shiftedIndex];
    
    cell.otherSpotName.text = spotDetial.Name;

    [cell.otherSpotImage sd_setImageWithPreviousCachedImageWithURL:[NSURL URLWithString:spotDetial.Image] placeholderImage:[UIImage imageNamed:@"taiwan-default.jpg"] options:SDWebImageCacheMemoryOnly progress:^(NSInteger receivedSize, NSInteger expectedSize) {  
    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) { } ];
    
    return cell;
}

@end
