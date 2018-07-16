//
//  TaipeiParkSpotViewModel.h
//  TaipeiParks
//
//  Created by Vernty on 2018/7/11.
//  Copyright © 2018年 VerntyChang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SpotTableCellViewModel.h"

@class TaipeiParkSpotInteractor;
@class TaipeiParkSpotCoordinator;

@interface TaipeiParkSpotViewModel : NSObject

- (instancetype)initWithInteractor:(TaipeiParkSpotInteractor *)interactor coordinator:(TaipeiParkSpotCoordinator *)coordinator;
- (void)fetchData;
- (SpotTableCellViewModel*)getCellViewModelForRowAt:(NSUInteger)row index:(NSUInteger)section;
- (NSUInteger)numberOfCellsForIndexAt:(NSUInteger)section;
- (NSUInteger)numberOfSection;

- (void)showDetailForRowAt:(NSUInteger)row index:(NSUInteger)section;

@end





