//
//  OtherSpotCollectionViewCell.h
//  TaipeiParks
//
//  Created by Vernty on 2018/4/8.
//  Copyright © 2018年 VerntyChang. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SpotTableCellViewModel;
@interface OtherSpotCollectionViewCell : UICollectionViewCell

@property (strong, nonatomic) IBOutlet UIImageView *otherSpotImage;
@property (strong, nonatomic) IBOutlet UILabel *otherSpotName;

- (void)configure:(SpotTableCellViewModel *)viewModel;
@end
