//
//  AppCoordinator.m
//  TaipeiParks
//
//  Created by Vernty on 2018/7/11.
//  Copyright © 2018年 VerntyChang. All rights reserved.
//

#import "AppCoordinator.h"

#import "TaipeiParkSpotViewController.h"
#import "TaipeiParkSpotViewModel.h"
#import "TaipeiParkSpotCoordinator.h"
#import "TaipeiParkSpotInteractor.h"

@interface AppCoordinator()
@property (nonatomic, strong) UIWindow *window;
@end

@implementation AppCoordinator

- (instancetype)initWithWindow:(UIWindow *)window {
 
    if (!window) return nil;
    _window = window;
    
    self = [super init];
    
    return self;
}
    
- (void)start{
//    // Preparing the new calçot
//    let groupCoordinator = GroupCoordinator(navigationController: navigationController)
//    let groupInteractor = GroupInteractor(group: group)
//    let groupViewModel = GroupViewModel(interactor: groupInteractor, coordinator: groupCoordinator)
//    let groupViewController = GroupViewController(viewModel: groupViewModel)
//    
//    // Adding observer listening to group members change
//    groupInteractor.groupMembersDidChange.add { [weak groupViewController, weak groupInteractor] in
//        guard let interactor = groupInteractor else { return }
//        groupViewController?.viewModel = GroupViewModel(interactor: interactor, coordinator: groupCoordinator)
//    }
//    
//    // Navigate to the new screen
//    navigationController?.pushViewController(groupViewController, animated: true)
//    
//
    
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    TaipeiParkSpotViewController *vc = [sb instantiateViewControllerWithIdentifier:@"TaipeiParkSpotViewController"];
    UINavigationController *navc = [[UINavigationController alloc] initWithRootViewController:vc];
    
    TaipeiParkSpotCoordinator *coordinator = [[TaipeiParkSpotCoordinator alloc] initWithNavigationController:navc];
    TaipeiParkSpotInteractor *interactor = [[TaipeiParkSpotInteractor alloc] init];
    interactor.parkSpotDataDidChange = ^(){
        [vc updateUI];
    };
    vc.viewModel = [[TaipeiParkSpotViewModel alloc] initWithInteractor:interactor coordinator:coordinator ];
 
    self.window.rootViewController = navc;
    
    //    [self.window makeKeyAndVisible];
}

//- (void)dismiss{
//    
//    
//}
@end

