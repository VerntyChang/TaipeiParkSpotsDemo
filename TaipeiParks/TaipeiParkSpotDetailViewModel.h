//
//  TaipeiParkSpotDetailViewModel.h
//  TaipeiParks
//
//  Created by Vernty on 2018/7/11.
//  Copyright © 2018年 VerntyChang. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "SpotTableCellViewModel.h"

@class TaipeiParkSpotInteractor;
@class TaipeiParkSpotDetailCoordinator;

@interface TaipeiParkSpotDetailViewModel : NSObject

- (instancetype)initWithInteractor:(TaipeiParkSpotInteractor *)interactor coordinator:(TaipeiParkSpotDetailCoordinator *)coordinator;

- (void)setCurrentSpotDetail:(NSUInteger)row index:(NSUInteger)section;
- (SpotTableCellViewModel *)fetchMainSpot;
- (void)fetchOtherSpotData;

- (SpotTableCellViewModel *)getCellViewModelForRowAt:(NSUInteger)row index:(NSUInteger)section;

- (NSUInteger)numberOfCollectionCells;
- (void)backToPreviousPage;
@end
