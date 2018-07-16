//
//  TaipeiParkSpotDetailViewModel.m
//  TaipeiParks
//
//  Created by Vernty on 2018/7/11.
//  Copyright © 2018年 VerntyChang. All rights reserved.
//


#import "TaipeiParkSpotDetailViewModel.h"
#import "TaipeiParkSpotDetailCoordinator.h"
#import "TaipeiParkSpotInteractor.h"


@interface TaipeiParkSpotDetailViewModel()
@property (nonatomic, strong) TaipeiParkSpotInteractor *interactor;
@property (nonatomic, strong) TaipeiParkSpotDetailCoordinator *coordinator;
@property (nonatomic, assign) NSUInteger currentSection;
@property (nonatomic, assign) NSUInteger currentRow;
@end

@implementation TaipeiParkSpotDetailViewModel
- (instancetype)initWithInteractor:(TaipeiParkSpotInteractor *)interactor coordinator:(TaipeiParkSpotDetailCoordinator *)coordinator{
    
    if (!interactor || !coordinator) return nil;
    _interactor = interactor;
    _coordinator= coordinator;
    
    self = [super init];
    return self;
}

- (void)setCurrentSpotDetail:(NSUInteger)row index:(NSUInteger)section{
    _currentSection = section;
    _currentRow = row;
}

- (SpotTableCellViewModel *)fetchMainSpot{
    Spot *model = [self.interactor fetchSpotAtSpotIndex:self.currentRow atParkIndex:self.currentSection];
    return [[SpotTableCellViewModel alloc] initWithSpotModel:model];
}

- (void)fetchOtherSpotData{
     [self.interactor fetchParkSpotData];
}


- (NSUInteger)numberOfCollectionCells{
    //    int otherSpotsCount = (int)[self.dataManager spotCountAtParkIndex:self.parkIndex] -1;
    //    if(otherSpotsCount == 0) self.otherSpotsLabel.hidden = true;
    
    return [self.interactor spotCountAtParkIndex:self.currentSection] - 1;
}

- (SpotTableCellViewModel*)getCellViewModelForRowAt:(NSUInteger)row index:(NSUInteger)section{
    
//    int shiftedSpotIndex = (indexPath.row >= self.spotIndex) ? ((int)indexPath.row+1):(int)indexPath.row;
    
//    Spot* spotDetial = [self.dataManager fetchSpotAtSpotIndex:shiftedSpotIndex atParkIndex:self.parkIndex] ;
    
    NSUInteger shiftedRow = (row >= self.currentRow) ?  row+1: row;
    Spot *model = [self.interactor fetchSpotAtSpotIndex:shiftedRow atParkIndex:section];
    return [[SpotTableCellViewModel alloc] initWithSpotModel:model];
    
}

- (void)backToPreviousPage{
    [self.coordinator dismiss];
}
//use  SpotDetialViewModel and Map model(spot) to it //- (instancetype)initWithSpotModel:(Spot *)model;
//use  OtherSpotCollectionCellViewModel and Map model(spotCollection) to it


@end
