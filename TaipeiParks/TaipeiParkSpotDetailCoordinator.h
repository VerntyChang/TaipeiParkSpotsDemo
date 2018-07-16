//
//  TaipeiParkSpotDetailCoordinator.h
//  TaipeiParks
//
//  Created by Vernty on 2018/7/11.
//  Copyright © 2018年 VerntyChang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@protocol TaipeiParkSpotDetailCoordinatorProtocol <NSObject>

@required

- (void)dismiss;
@optional
- (void)present;
@end


@interface TaipeiParkSpotDetailCoordinator:NSObject<TaipeiParkSpotDetailCoordinatorProtocol>
- (instancetype)initWithNavigationController:(UINavigationController *)navigationController;

- (void)dismiss;
@end
