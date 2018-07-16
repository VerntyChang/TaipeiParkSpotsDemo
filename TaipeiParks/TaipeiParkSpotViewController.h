//
//  TaipeiParkSpotViewController.h
//  TaipeiParks
//
//  Created by Vernty on 2018/4/5.
//  Copyright © 2018年 VerntyChang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TaipeiParkSpotViewModel.h"

@interface TaipeiParkSpotViewController : UIViewController
@property (nonatomic, strong) TaipeiParkSpotViewModel *viewModel;
- (void)updateUI;
@end

