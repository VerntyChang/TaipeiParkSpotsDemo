//
//  TaipeiParkSpotViewModel.m
//  TaipeiParks
//
//  Created by Vernty on 2018/7/11.
//  Copyright © 2018年 VerntyChang. All rights reserved.
//

#import "TaipeiParkSpotViewModel.h"
#import "TaipeiParkSpotCoordinator.h"
#import "TaipeiParkSpotInteractor.h"

#import "SpotTableCellViewModel.h"

@interface TaipeiParkSpotViewModel()
@property (nonatomic, strong) TaipeiParkSpotInteractor *interactor;
@property (nonatomic, strong) TaipeiParkSpotCoordinator *coordinator;
@end

@implementation TaipeiParkSpotViewModel
- (instancetype)initWithInteractor:(TaipeiParkSpotInteractor *)interactor coordinator:(TaipeiParkSpotCoordinator *)coordinator{
  
    if (!interactor || !coordinator) return nil;
    _interactor = interactor;
    _coordinator= coordinator;
    
    self = [super init];
    return self;
}

- (void)fetchData{

    [self.interactor fetchParkSpotData];
}

- (NSUInteger)numberOfCellsForIndexAt:(NSUInteger)section{
    
    return [self.interactor spotCountAtParkIndex:section];
}

- (NSUInteger)numberOfSection{
     return [self.interactor parkCount];
}

- (SpotTableCellViewModel*)getCellViewModelForRowAt:(NSUInteger)row index:(NSUInteger)section{
    
    Spot *model = [self.interactor fetchSpotAtSpotIndex:row atParkIndex:section];
    return [[SpotTableCellViewModel alloc] initWithSpotModel:model];
    
}


- (void)showDetailForRowAt:(NSUInteger)row index:(NSUInteger)section{
    [self.coordinator presentForRowAt:row index:section interactor:self.interactor];
}

//fileprivate func validateEmailFormat(_ email: String) -> Bool
//{
//    let REGEX: String
//    REGEX = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,32}"
//    return NSPredicate(format: "SELF MATCHES %@", REGEX).evaluate(with: email)
//}

@end

