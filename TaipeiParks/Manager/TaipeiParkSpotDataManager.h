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

-(void) parseJSON:(id)responseObject;

-(int) parkCount;
-(int) spotCountAtParkIndex:(int) parkIndex;

-(Spot*) fetchSpotAtSpotIndex:(int)spotIndex atParkIndex:(int)parkIndex;

@end
