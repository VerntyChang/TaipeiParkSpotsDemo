//
//  SpotTableViewCell.m
//  TaipeiParks
//
//  Created by Vernty on 2018/4/5.
//  Copyright © 2018年 VerntyChang. All rights reserved.
//

#import "SpotTableViewCell.h"
#import "UIImageView+WebCache.h"
#import "SpotTableCellViewModel.h"

@implementation SpotTableViewCell

- (void)configure:(SpotTableCellViewModel *)viewModel{
//    Spot* spotDetial = [self.dataManager fetchSpotAtSpotIndex:(int)indexPath.row atParkIndex:(int)indexPath.section];
    
    self.spotName.text = viewModel.spotName;
    self.parkName.text = viewModel.parkName;
    self.spotIntroduction.text = viewModel.spotIntroduction;
    
    [self.spotImage sd_setImageWithPreviousCachedImageWithURL:[NSURL URLWithString: viewModel.spotImage ] placeholderImage:[UIImage imageNamed:@"taiwan-default.jpg"] options:SDWebImageCacheMemoryOnly progress:^(NSInteger receivedSize, NSInteger expectedSize) {
    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {    } ];
}

@end


