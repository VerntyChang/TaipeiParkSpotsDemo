//
//  TaipeiParkSpotCoordinator.h
//  TaipeiParks
//
//  Created by Vernty on 2018/7/11.
//  Copyright © 2018年 VerntyChang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class TaipeiParkSpotInteractor;

@protocol TaipeiParkSpotCoordinatorProtocol <NSObject>

@required
- (void)presentForRowAt:(NSUInteger)row index:(NSUInteger)section interactor:(TaipeiParkSpotInteractor*)interactor;
- (void)dismiss;
@optional

@end


@interface TaipeiParkSpotCoordinator:NSObject<TaipeiParkSpotCoordinatorProtocol>
- (instancetype)initWithNavigationController:(UINavigationController *)navigationController;

- (void)presentForRowAt:(NSUInteger)row index:(NSUInteger)section interactor:(TaipeiParkSpotInteractor*)interactor;
- (void)dismiss;
@end
