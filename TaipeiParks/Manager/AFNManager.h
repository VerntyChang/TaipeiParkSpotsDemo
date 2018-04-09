//
//  AFNManager.h
//  TaipeiParks
//
//  Created by Vernty on 2018/4/8.
//  Copyright © 2018年 VerntyChang. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^connectionSuccess)(id responseObject);

@interface AFNManager: NSObject
+ (instancetype)sharedInstance;

-(void)getAllParkSpotsData;

@property (nonatomic,copy) connectionSuccess connectionSuccessBlock;

@end
