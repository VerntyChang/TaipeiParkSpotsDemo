//
//  TaipeiParkSpotInteractor.m
//  TaipeiParks
//
//  Created by Vernty on 2018/7/11.
//  Copyright © 2018年 VerntyChang. All rights reserved.
//

#import "TaipeiParkSpotInteractor.h"

#import "AFNManager.h"
//#import "TaipeiParkSpotDataManager.h"
#import "TaipeiParkSpots.h"
#import "NSObject+YYModel.h"

@interface TaipeiParkSpotInteractor()
@property (nonatomic,strong) AFNManager *afnManager; //dataProvider

//@property (strong, nonatomic) TaipeiParkSpotDataManager *dataManager;
@property (strong, nonatomic) TaipeiParkSpots *taipeiParkSpots; //yyModel //ModelList

@property (strong, nonatomic) NSMutableArray *spotgroupOfDifferentPark; //logicData
@property (assign, nonatomic) int oldParkIndex;
@property (assign, nonatomic) int oldSpotIndex;
@property (strong, nonatomic) NSArray* spotsInSamePark;
@property (strong, nonatomic) Spot* spot;
@end




@implementation TaipeiParkSpotInteractor

- (instancetype)init{
    
    self = [super init];
    if (self) {
        _spotgroupOfDifferentPark = [NSMutableArray array];
        _oldParkIndex = -1;
        _oldSpotIndex = -1;
        
        
        _afnManager = [AFNManager sharedInstance];
        __weak typeof(self) weakSelf = self;
        _afnManager.connectionSuccessBlock = ^(id responseObject){
            
            //[weakSelf.dataManager parseJSON:responseObject];
            [weakSelf parseJSON:responseObject];
            //[weakSelf.tableView reloadData];
            [weakSelf ParkSpotDataDidChange];
        };
        
        //_dataManager = [[TaipeiParkSpotDataManager alloc] init];
    }
    return self;
    
   
    
}

- (void)fetchParkSpotData{
    [self.afnManager getAllParkSpotsData];
}

- (void)ParkSpotDataDidChange{
    self.parkSpotDataDidChange();
}

-(NSUInteger) parkCount{
    return (int)[self.spotgroupOfDifferentPark count];
}

- (NSUInteger) spotCountAtParkIndex:(NSUInteger) parkIndex{
    
    self.spotsInSamePark = [self.spotgroupOfDifferentPark objectAtIndex:parkIndex];
    return (int)[self.spotsInSamePark count];
}

-(Spot*)fetchSpotAtSpotIndex:(NSUInteger)spotIndex atParkIndex:(NSUInteger)parkIndex{
    
    if(_oldParkIndex == parkIndex && _oldSpotIndex == spotIndex)
        return self.spot;
    
    self.spotsInSamePark = [self.spotgroupOfDifferentPark objectAtIndex:parkIndex];
    self.spot = [self.spotsInSamePark objectAtIndex:spotIndex];
    
    return [self.spot copy];
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

