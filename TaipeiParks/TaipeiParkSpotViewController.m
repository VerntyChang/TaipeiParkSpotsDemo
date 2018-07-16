//
//  TaipeiParkSpotViewController.m
//  TaipeiParks
//
//  Created by Vernty on 2018/4/5.
//  Copyright © 2018年 VerntyChang. All rights reserved.
//

#import "TaipeiParkSpotViewController.h"
#import "SpotTableViewCell.h"
 
static NSString *const spotTableViewCellIdentifier = @"SpotCell";

@interface TaipeiParkSpotViewController ()
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@end

@implementation TaipeiParkSpotViewController

- (void)viewDidLoad {
    [super viewDidLoad];

//    setupUI()
//    layoutUI()
//    styleUI()
//    updateUI()
    
    [self layoutUI];
//   [self updateUI];
    [self.viewModel fetchData];
}

- (void)setupUI{
//    tableView.delegate = self
//    tableView.dataSource = self
//    tableView.register(GroupTableViewCell.self, forCellReuseIdentifier: GroupTableViewCell.cellIdentifier)
//
//    view.addSubview(tableView)
//
//    title = viewModel.groupsCategory
}

- (void)layoutUI{
    self.tableView.estimatedRowHeight = 160;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
}
- (void)styleUI{
    
}
- (void)updateUI{
    dispatch_async(dispatch_get_main_queue(), ^{
 
        [self.tableView reloadData];
    });
    
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [self.viewModel numberOfSection];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return [self.viewModel numberOfCellsForIndexAt:(int)section];
   
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SpotTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:spotTableViewCellIdentifier forIndexPath:indexPath];
    
    [cell configure: [self.viewModel getCellViewModelForRowAt:indexPath.row index:indexPath.section]];

    
    return cell;
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    
    SpotTableCellViewModel *vm= [self.viewModel getCellViewModelForRowAt:0 index:section];
    return vm.parkName;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//    NSString *className = self.classNames[indexPath.row];
//    Class class = NSClassFromString(className);
//    if (class) {
//        UIViewController *ctrl = class.new;
//        ctrl.title = _titles[indexPath.row];
//        [self.navigationController pushViewController:ctrl animated:YES];
//    }
    
    [self.viewModel showDetailForRowAt:indexPath.row index:indexPath.section];
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    
 
}

#pragma mark - storyboard
//-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
     //!!!!!!!  still in  and create a new navi  so mark this
//DELETE UIStoryboardSegue!
    //id taipeiParkSpotDetailViewController = segue.destinationViewController;
 
//    NSIndexPath *indexPath = [self.tableView indexPathForCell:sender];
//    
//    [taipeiParkSpotDetailViewController setValue:@(indexPath.section) forKey:@"parkIndex"];
//    [taipeiParkSpotDetailViewController setValue:@(indexPath.row) forKey:@"spotIndex"];
//    [taipeiParkSpotDetailViewController setValue:self.dataManager forKey:@"dataManager"];
    
//}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
