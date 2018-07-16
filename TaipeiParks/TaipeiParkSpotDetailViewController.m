//
//  TaipeiParkSpotViewController.m
//  TaipeiParks
//
//  Created by Vernty on 2018/4/7.
//  Copyright © 2018年 VerntyChang. All rights reserved.
//

#import "TaipeiParkSpotDetailViewController.h"
#import "OtherSpotCollectionViewCell.h"

#import "UIImageView+WebCache.h"
#import "SpotTableCellViewModel.h"

static NSString *const spotCollectionViewCellIdentifier = @"OtherSpotCell";

@interface TaipeiParkSpotDetailViewController()
@property (strong, nonatomic) IBOutlet UILabel *parkName;
@property (strong, nonatomic) IBOutlet UILabel *spotName;
@property (strong, nonatomic) IBOutlet UILabel *openTime;
@property (strong, nonatomic) IBOutlet UILabel *introduction;
@property (strong, nonatomic) IBOutlet UIImageView *imageView;
@property (strong, nonatomic) IBOutlet UICollectionView *otherSpotsCollectionView;
@property (strong, nonatomic) IBOutlet UILabel *otherSpotsLabel;

@end

@implementation TaipeiParkSpotDetailViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
     
    //    setupUI()
    //    layoutUI()
    //    styleUI()
    //    updateUI()
    
    [self setupUI];
    //   [self updateUI];
    [self.viewModel fetchOtherSpotData];

}


- (void)setupUI{
    
    //setupNavi
    self.navigationItem.title = (@"Main Spot");
    
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc]
                                   initWithTitle:@"Back"
                                   style:UIBarButtonItemStylePlain
                                   target:self.viewModel
                                   action:@selector(backToPreviousPage)];
    self.navigationItem.leftBarButtonItem = backButton;
 
    //
    SpotTableCellViewModel *vm = [self.viewModel fetchMainSpot];
    self.parkName.text = vm.parkName;
    self.spotName.text =  vm.spotName;
    self.openTime.text =  vm.spotOpenTime;
    self.introduction.text = vm.spotIntroduction;
    [self.imageView sd_setImageWithPreviousCachedImageWithURL:[NSURL URLWithString: vm.spotImage] placeholderImage:[UIImage imageNamed:@"taiwan-default.jpg"] options:SDWebImageCacheMemoryOnly progress:^(NSInteger receivedSize, NSInteger expectedSize) {
    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {  } ];
}

- (void)layoutUI{
    
}
- (void)styleUI{
    
}
- (void)updateUI{
    dispatch_async(dispatch_get_main_queue(), ^{
 
        [self.otherSpotsCollectionView reloadData];
        
    });
    
}
 
#pragma mark - UICollectionViewDataSource
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
 
    return [self.viewModel numberOfCollectionCells];
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
   OtherSpotCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier: spotCollectionViewCellIdentifier  forIndexPath:indexPath];
    
    
      [cell configure: [self.viewModel getCellViewModelForRowAt:indexPath.row index:indexPath.section]];
     
    
    return cell;
}

@end
