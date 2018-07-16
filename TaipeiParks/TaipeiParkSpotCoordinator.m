//
//  TaipeiParkSpotCoordinator.m
//  TaipeiParks
//
//  Created by Vernty on 2018/7/11.
//  Copyright © 2018年 VerntyChang. All rights reserved.
//

#import "TaipeiParkSpotCoordinator.h"

#import "TaipeiParkSpotDetailViewController.h"
#import "TaipeiParkSpotDetailViewModel.h"
#import "TaipeiParkSpotDetailCoordinator.h"
#import "TaipeiParkSpotInteractor.h"

@interface TaipeiParkSpotCoordinator()
@property (nonatomic, strong) UINavigationController *navigationController;
@end

@implementation TaipeiParkSpotCoordinator

- (instancetype)initWithNavigationController:(UINavigationController *)navigationController{
    if (!navigationController) return nil;
    _navigationController = navigationController;
    
    self = [super init];
    
    return self;
}

- (void)presentForRowAt:(NSUInteger)row index:(NSUInteger)section interactor:(TaipeiParkSpotInteractor*)interactor {
 
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    TaipeiParkSpotDetailViewController *vc = [sb instantiateViewControllerWithIdentifier:@"TaipeiParkSpotDetailViewController"];
    
    TaipeiParkSpotDetailCoordinator *coordinator = [[TaipeiParkSpotDetailCoordinator alloc] initWithNavigationController:self.navigationController];
    
//    TaipeiParkSpotInteractor *interactor = [[TaipeiParkSpotInteractor alloc] init];
//    interactor.parkSpotDataDidChange = ^(){
//        [vc updateUI];
//    };
    
    TaipeiParkSpotDetailViewModel *vm = [[TaipeiParkSpotDetailViewModel alloc] initWithInteractor:interactor coordinator:coordinator ];
    [vm setCurrentSpotDetail:row index:section];
    
    vc.viewModel = vm;
    
    //remember DELETE UIStoryboardSegue!
    [self.navigationController pushViewController:vc animated:NO];
}

- (void)dismiss{ //???
    [self.navigationController popViewControllerAnimated:NO];
}
 

@end

