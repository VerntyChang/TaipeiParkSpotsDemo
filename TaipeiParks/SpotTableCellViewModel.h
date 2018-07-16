//
//  SpotTableCellViewModel.h
//  TaipeiParks
//
//  Created by Vernty on 2018/7/11.
//  Copyright © 2018年 VerntyChang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class Spot;
@interface SpotTableCellViewModel : NSObject

@property (nonatomic, strong, readonly) NSString *spotImage;
@property (nonatomic, strong, readonly) NSString *parkName;
@property (nonatomic, strong, readonly) NSString *spotName;
@property (nonatomic, strong, readonly) NSString *spotIntroduction;
@property (nonatomic, strong, readonly) NSString *spotOpenTime;

- (instancetype)initWithSpotModel:(Spot *)model;

@end

