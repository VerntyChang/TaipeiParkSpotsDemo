//
//  SpotTableViewCell.h
//  TaipeiParks
//
//  Created by Vernty on 2018/4/5.
//  Copyright © 2018年 VerntyChang. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SpotTableCellViewModel;

@interface SpotTableViewCell : UITableViewCell

@property (nonatomic, retain) IBOutlet UIImageView *spotImage;
@property (nonatomic, retain) IBOutlet UILabel *parkName;
@property (nonatomic, retain) IBOutlet UILabel *spotName;
@property (nonatomic, retain) IBOutlet UILabel *spotIntroduction;

- (void)configure:(SpotTableCellViewModel *)viewModel;
@end

