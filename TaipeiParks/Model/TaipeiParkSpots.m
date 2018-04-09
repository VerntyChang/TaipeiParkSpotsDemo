//
//  TaipeiParkSpots.m
//  TaipeiParks
//
//  Created by Vernty on 2018/4/6.
//  Copyright © 2018年 VerntyChang. All rights reserved.
//

#import "TaipeiParkSpots.h"


@implementation TaipeiParkSpots

@end



@implementation Result

+ (NSDictionary *)modelCustomPropertyMapper {
   
    return @{@"allParkSpots": @"results"};
    
}

+ (NSDictionary *)modelContainerPropertyGenericClass {
    
    return @{@"allParkSpots" : @"Spot"};
    
}

@end



@implementation Spot

#pragma mark - NSCopying
- (instancetype)copyWithZone:(NSZone *)zone {

    Spot *copy = [[self class] allocWithZone:zone];
    copy._id = __id;
    copy.ParkName = _ParkName;
    copy.Name = _Name;
    copy.OpenTime = _OpenTime;
    copy.Introduction = _Introduction;
    copy.Image = _Image;
    copy.YearBuilt = _YearBuilt;

    return copy;
}

@end
