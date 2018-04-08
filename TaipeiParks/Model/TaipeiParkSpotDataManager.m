//
//  TaipeiParkSpotDataManager.m
//  TaipeiParks
//
//  Created by Vernty on 2018/4/8.
//  Copyright © 2018年 VerntyChang. All rights reserved.
//

#import "TaipeiParkSpotDataManager.h"
#import "TaipeiParkSpots.h"
#import "NSObject+YYModel.h"

@interface TaipeiParkSpotDataManager()
@property (strong, nonatomic) TaipeiParkSpots *taipeiParkSpots; //yyModel

@property (strong, nonatomic) NSMutableArray *spotgroupOfDifferentPark;

@property (assign, nonatomic) int oldParkIndex;
@property (assign, nonatomic) int oldSpotIndex;
@property (strong, nonatomic) NSArray* spotsInSamePark;
@property (strong, nonatomic) Spot* spot;
@end

@implementation TaipeiParkSpotDataManager

- (instancetype)init {
    self = [super init];
    
    if (self) {
        _spotgroupOfDifferentPark = [NSMutableArray array];
        _oldParkIndex = -1;
        _oldSpotIndex = -1;
    }
    return self;
}

-(int)parkCount{
    return (int)[self.spotgroupOfDifferentPark count];
}

- (int) spotCountAtParkIndex:(int) parkIndex{

    self.spotsInSamePark = [self.spotgroupOfDifferentPark objectAtIndex:parkIndex];
    return (int)[self.spotsInSamePark count];
}

-(Spot*)fetchSpotAtSpotIndex:(int)spotIndex atParkIndex:(int)parkIndex{
    
    if(_oldParkIndex == parkIndex && _oldSpotIndex == spotIndex)
        return self.spot;
    
    self.spotsInSamePark = [self.spotgroupOfDifferentPark objectAtIndex:parkIndex];
    self.spot = [self.spotsInSamePark objectAtIndex:spotIndex];
    return self.spot;
  
}

#pragma mark - parser
-(void)parseJSON:(id)responseObject{
     self.taipeiParkSpots = [TaipeiParkSpots yy_modelWithJSON:responseObject];
    
     [self splitIntoSpotGroupsByParkname];
    
}

-(void)splitIntoSpotGroupsByParkname{
    
    NSArray *allParkSpots = self.taipeiParkSpots.result.allParkSpots;
    NSSortDescriptor *sortByNumber = [NSSortDescriptor sortDescriptorWithKey:@"_id" ascending:YES];
    NSArray *allParkSpotsInOrder = [allParkSpots sortedArrayUsingDescriptors:[NSArray arrayWithObjects:sortByNumber, nil]];
    
    
    NSUInteger itemsRemaining = allParkSpots.count;
    while(itemsRemaining) {
        
        Spot* spot = [allParkSpotsInOrder objectAtIndex:(allParkSpotsInOrder.count - itemsRemaining)];
        
        NSPredicate *parkNamePredicate = [NSPredicate predicateWithFormat:@"ParkName = %@", spot.ParkName];
        
        NSArray *spotsOfSamePark = [allParkSpotsInOrder filteredArrayUsingPredicate:parkNamePredicate];
        
        [self.spotgroupOfDifferentPark addObject:spotsOfSamePark];
        
        itemsRemaining-= [spotsOfSamePark count];
        
    }
}


@end
