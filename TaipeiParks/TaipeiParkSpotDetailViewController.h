//
//  TaipeiParkSpotDetailViewController.h
//  TaipeiParks
//
//  Created by Vernty on 2018/4/7.
//  Copyright © 2018年 VerntyChang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TaipeiParkSpotDataManager.h"

@interface TaipeiParkSpotDetailViewController : UIViewController

@property (nonatomic,assign) int parkIndex;
@property (nonatomic,assign) int spotIndex;
@property (strong, nonatomic) TaipeiParkSpotDataManager* dataManager;

@end
