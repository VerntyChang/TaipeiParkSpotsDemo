//
//  SpotTableCellViewModel.m
//  TaipeiParks
//
//  Created by Vernty on 2018/7/11.
//  Copyright © 2018年 VerntyChang. All rights reserved.
//

#import "SpotTableCellViewModel.h"
#import "TaipeiParkSpots.h"

@implementation SpotTableCellViewModel 

//- (instancetype)initWithSpotImage:(UIImage *)spotImage
//                         parkName:(NSString *)parkName
//                         spotName:(NSString *)spotName
//                 spotIntroduction:(NSString *)spotIntroduction

- (instancetype)initWithSpotModel:(Spot *)model{
    
    //if (!interactor || !coordinator) return nil;
    _spotImage = model.Image;
    _parkName = model.ParkName;
    _spotName = model.Name;
    _spotIntroduction = model.Introduction;
    _spotOpenTime = model.OpenTime;
    
    self = [super init];
    return self;
}

@end
