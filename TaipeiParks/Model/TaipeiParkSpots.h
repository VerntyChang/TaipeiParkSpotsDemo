//
//  TaipeiParkSpots.h
//  TaipeiParks
//
//  Created by Vernty on 2018/4/6.
//  Copyright © 2018年 VerntyChang. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Result;

@interface TaipeiParkSpots : NSObject
@property Result      *result;
@end


@interface Result : NSObject
@property (nonatomic, assign) int offset;
@property (nonatomic, assign) int limit;
@property (nonatomic, assign) int count;
@property NSString     *sort;

@property (nonatomic, strong)   NSArray    *results;

@end

@interface Results : NSObject
@property (nonatomic, strong) NSNumber *_id;  //NSSortDescriptor
@property (nonatomic, strong) NSString *ParkName;
@property (nonatomic, strong) NSString *Name;
@property (nonatomic, strong) NSString *YearBuilt;
@property (nonatomic, strong) NSString *OpenTime;
@property (nonatomic, strong) NSString *Image;
@property (nonatomic, strong) NSString *Introduction;
@end
