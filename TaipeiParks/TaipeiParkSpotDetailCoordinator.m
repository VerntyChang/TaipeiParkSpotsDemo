//
//  TaipeiParkSpotDetailCoordinator.m
//  TaipeiParks
//
//  Created by Vernty on 2018/7/11.
//  Copyright © 2018年 VerntyChang. All rights reserved.
//


#import "TaipeiParkSpotDetailCoordinator.h"

@interface TaipeiParkSpotDetailCoordinator()
@property (nonatomic, strong) UINavigationController *navigationController;
@end

@implementation TaipeiParkSpotDetailCoordinator

- (instancetype)initWithNavigationController:(UINavigationController *)navigationController{
    if (!navigationController) return nil;
    _navigationController = navigationController;
    
    self = [super init];
    
    return self;
}


- (void)dismiss{
    [self.navigationController popViewControllerAnimated:NO];
}


@end
