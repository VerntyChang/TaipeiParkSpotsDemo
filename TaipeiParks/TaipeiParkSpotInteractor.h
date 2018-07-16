//
//  TaipeiParkSpotInteractor.h
//  TaipeiParks
//
//  Created by Vernty on 2018/7/11.
//  Copyright © 2018年 VerntyChang. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol TaipeiParkSpotInteractorProtocol <NSObject>

@required
- (void)fetchParkSpotData;
//- (void)ParkSpotDataDidChange;

@optional
//- (void)dismiss;

@end

@class Spot; //model
//It's the TaipeiParkSpotDataManager which controls model and API
@interface TaipeiParkSpotInteractor : NSObject<TaipeiParkSpotInteractorProtocol>
- (instancetype)init;

- (void)fetchParkSpotData;
- (void)parseJSON:(id)responseObject;

-(NSUInteger) parkCount;
-(NSUInteger) spotCountAtParkIndex:(NSUInteger) parkIndex;

-(Spot*) fetchSpotAtSpotIndex:(NSUInteger)spotIndex atParkIndex:(NSUInteger)parkIndex;

//- (void)ParkSpotDataDidChange;
@property (nullable, nonatomic, copy) void (^parkSpotDataDidChange)(void);
@end


