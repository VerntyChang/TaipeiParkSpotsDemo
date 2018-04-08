//
//  TaipeiParkSpotViewController.m
//  TaipeiParks
//
//  Created by Vernty on 2018/4/5.
//  Copyright © 2018年 VerntyChang. All rights reserved.
//

#import "TaipeiParkSpotViewController.h"
#import "SpotTableViewCell.h"

#import "UIImageView+WebCache.h"

#import "AFNManager.h"
#import "TaipeiParkSpotDataManager.h"
#import "TaipeiParkSpots.h"

@interface TaipeiParkSpotViewController ()
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic,strong) AFNManager *afnManager;
@property (strong, nonatomic) TaipeiParkSpotDataManager *dataManager;
@end

@implementation TaipeiParkSpotViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.tableView.estimatedRowHeight = 160;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    
    [self.afnManager getAllParkSpotsData];

}

#pragma mark - getter
-(AFNManager *)afnManager{
    
     if(_afnManager == nil){
      
         _afnManager = [AFNManager sharedInstance];
         
         __weak typeof(self) weakSelf = self;
         _afnManager.connectionSuccessBlock = ^(id responseObject){
             
             [weakSelf.dataManager parseJSON:responseObject];
             [weakSelf.tableView reloadData];
         };
     }
    
    return _afnManager;
}

-(TaipeiParkSpotDataManager *)dataManager{
    
    if(_dataManager == nil){
        _dataManager = [[TaipeiParkSpotDataManager alloc] init];
    }
    
    return _dataManager;
}


#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return self.dataManager.parkCount;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return [self.dataManager spotCountAtParkIndex:(int)section];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SpotTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SpotCell" forIndexPath:indexPath];
    
     Spot* spotDetial = [self.dataManager fetchSpotAtSpotIndex:(int)indexPath.row atParkIndex:(int)indexPath.section];
    
    cell.spotName.text = spotDetial.Name;
    cell.parkName.text = spotDetial.ParkName;
    cell.spotIntroduction.text = spotDetial.Introduction;
    
    [cell.spotImage sd_setImageWithPreviousCachedImageWithURL:[NSURL URLWithString: spotDetial.Image ] placeholderImage:[UIImage imageNamed:@"taiwan-default.jpg"] options:SDWebImageCacheMemoryOnly progress:^(NSInteger receivedSize, NSInteger expectedSize) {
    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {    } ];
    
    return cell;
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
   
    Spot* spotDetial = [self.dataManager fetchSpotAtSpotIndex:0 atParkIndex:(int)section];
    return spotDetial.ParkName;
}


#pragma mark - storyboard
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
     
    id taipeiParkSpotDetailViewController = segue.destinationViewController;
 
    NSIndexPath *indexPath = [self.tableView indexPathForCell:sender];
    
    [taipeiParkSpotDetailViewController setValue:@(indexPath.section) forKey:@"parkIndex"];
    [taipeiParkSpotDetailViewController setValue:@(indexPath.row) forKey:@"spotIndex"];
    [taipeiParkSpotDetailViewController setValue:self.dataManager forKey:@"dataManager"];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
