//
//  TaipeiParkSpotDataManager.h
//  TaipeiParks
//
//  Created by Vernty on 2018/4/8.
//  Copyright © 2018年 VerntyChang. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Spot;

@interface TaipeiParkSpotDataManager : NSObject

@property (nonatomic, assign , readonly) int parkCount;
-(void) parseJSON:(id)responseObject;
-(int) spotCountAtParkIndex:(int) parkIndex;
-(Spot*) fetchSpotAtSpotIndex:(int)spotIndex atParkIndex:(int)parkIndex;

@end
