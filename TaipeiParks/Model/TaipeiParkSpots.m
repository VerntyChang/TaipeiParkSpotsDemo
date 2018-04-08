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
 
// 属性和JSON数据映射
+ (NSDictionary *)modelCustomPropertyMapper {
    // ID是后面返回的值，自己的定义，映射的是id
    return @{@"allParkSpots": @"results"}; }

// 属性和类关联映射
+ (NSDictionary *)modelContainerPropertyGenericClass {
    // 同样是前一个映射后一个
    return @{@"allParkSpots" : @"Spot"};
    
}

 //www.jianshu.com/p/4446eee4ae76
@end



@implementation Spot

@end
