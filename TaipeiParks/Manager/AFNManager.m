//
//  AFNManager.m
//  TaipeiParks
//
//  Created by Vernty on 2018/4/8.
//  Copyright © 2018年 VerntyChang. All rights reserved.
//

#import "AFNManager.h"
#import "AFHTTPSessionManager.h"

@interface AFNManager()
@property(nonatomic,strong)AFHTTPSessionManager *manager;
@end


@implementation AFNManager

#pragma mark - Initializing
+ (instancetype)sharedInstance {
    static AFNManager *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[AFNManager alloc]init];
    });
    return sharedInstance;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        _manager = [AFHTTPSessionManager manager];
        _manager.operationQueue.maxConcurrentOperationCount = 5;
        _manager.requestSerializer = [AFHTTPRequestSerializer serializer];
        _manager.requestSerializer.timeoutInterval = 30.0f;
        [_manager.requestSerializer setValue:@"gzip" forHTTPHeaderField:@"Content-Encoding"];
        _manager.responseSerializer.acceptableContentTypes = [[NSSet alloc] initWithObjects:@"application/xml", @"text/xml",@"text/html", @"application/json",@"text/plain",nil];
        _manager.responseSerializer = [AFJSONResponseSerializer serializer];
        _manager.responseSerializer.acceptableContentTypes=[[NSSet alloc] initWithObjects:@"application/xml", @"text/xml",@"text/html", @"application/json",@"text/plain",nil];
    }
    return self;
}

-(void)getAllParkSpotsData
{
    //Taipei Park Spots API
    NSString *url=@"http://data.taipei/opendata/datalist/apiAccess";
    NSDictionary *parameters=@{@"scope":@"resourceAquire",@"rid":@"bf073841-c734-49bf-a97f-3757a6013812"};
    
    
    [self.manager GET:url parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {
        NSLog(@"downloadProgress-->%@",downloadProgress);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        self.connectionSuccessBlock(responseObject);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error-->%@",error);
    }];
}
@end
