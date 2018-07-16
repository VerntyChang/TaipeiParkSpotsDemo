//
//  AppCoordinator.h
//  TaipeiParks
//
//  Created by Vernty on 2018/7/11.
//  Copyright © 2018年 VerntyChang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@protocol AppCoordinatorProtocol <NSObject>

@required
- (void)start;
@optional
//- (void)dismiss;

@end


@interface AppCoordinator:NSObject<AppCoordinatorProtocol>
- (instancetype)initWithWindow:(UIWindow *)window;
- (void)start;
@end
