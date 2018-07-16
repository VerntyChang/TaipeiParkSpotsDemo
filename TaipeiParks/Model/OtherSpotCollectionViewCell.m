//
//  OtherSpotCollectionViewCell.m
//  TaipeiParks
//
//  Created by Vernty on 2018/4/8.
//  Copyright © 2018年 VerntyChang. All rights reserved.
//

#import "OtherSpotCollectionViewCell.h"
#import "UIImageView+WebCache.h"
#import "SpotTableCellViewModel.h"

@implementation OtherSpotCollectionViewCell

- (void)configure:(SpotTableCellViewModel *)viewModel{
 
    self.otherSpotName.text = viewModel.spotName;
 
    [self.otherSpotImage sd_setImageWithPreviousCachedImageWithURL:[NSURL URLWithString: viewModel.spotImage ] placeholderImage:[UIImage imageNamed:@"taiwan-default.jpg"] options:SDWebImageCacheMemoryOnly progress:^(NSInteger receivedSize, NSInteger expectedSize) {
    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {    } ];
}


@end
