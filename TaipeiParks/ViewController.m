//
//  ViewController.m
//  TaipeiParks
//
//  Created by Vernty on 2018/4/5.
//  Copyright © 2018年 VerntyChang. All rights reserved.
//

#import "ViewController.h"
#import "SpotTableViewCell.h"
#import "TaipeiParkSpots.h"
#import "NSObject+YYModel.h"
#import "UIImageView+WebCache.h"

@interface ViewController ()
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) TaipeiParkSpots *taipeiParkSpots;
@property (strong, nonatomic) NSMutableArray *arrayOfArrays;
@property (strong, nonatomic) NSArray* results;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
      [self doGetRequest];
    
    //https://stackoverflow.com/questions/36526480/uitableview-cell-dynamic-height
    self.tableView.estimatedRowHeight = 160;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
}


/*
 <key>NSAppTransportSecurity</key>
 <dict>
 <key>NSAllowsArbitraryLoads</key>
 <true/>
 </dict>
 //https://juejin.im/entry/589d1aa161ff4b006b37408e
 */
-(AFHTTPSessionManager *)shareAFNManager
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    //最大请求并发任务数
    manager.operationQueue.maxConcurrentOperationCount = 5;
    
    // 请求格式
    // AFHTTPRequestSerializer            二进制格式
    // AFJSONRequestSerializer            JSON
    // AFPropertyListRequestSerializer    PList(是一种特殊的XML,解析起来相对容易)
    
    manager.requestSerializer = [AFHTTPRequestSerializer serializer]; // 上传普通格式
    
    // 超时时间
    manager.requestSerializer.timeoutInterval = 30.0f;
    // 设置请求头
    [manager.requestSerializer setValue:@"gzip" forHTTPHeaderField:@"Content-Encoding"];
    // 设置接收的Content-Type
    manager.responseSerializer.acceptableContentTypes = [[NSSet alloc] initWithObjects:@"application/xml", @"text/xml",@"text/html", @"application/json",@"text/plain",nil];
    
    // 返回格式
    // AFHTTPResponseSerializer           二进制格式
    // AFJSONResponseSerializer           JSON
    // AFXMLParserResponseSerializer      XML,只能返回XMLParser,还需要自己通过代理方法解析
    // AFXMLDocumentResponseSerializer (Mac OS X)
    // AFPropertyListResponseSerializer   PList
    // AFImageResponseSerializer          Image
    // AFCompoundResponseSerializer       组合
    
    manager.responseSerializer = [AFJSONResponseSerializer serializer];//返回格式 JSON
    //设置返回C的ontent-type
    manager.responseSerializer.acceptableContentTypes=[[NSSet alloc] initWithObjects:@"application/xml", @"text/xml",@"text/html", @"application/json",@"text/plain",nil];
    
    return manager;
}
-(void)doGetRequest
{
    //创建请求地址
    NSString *url=@"http://data.taipei/opendata/datalist/apiAccess";
    //构造参数
    NSDictionary *parameters=@{@"scope":@"resourceAquire",@"rid":@"bf073841-c734-49bf-a97f-3757a6013812"};
    //AFN管理者调用get请求方法
    [[self shareAFNManager] GET:url parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {
        //返回请求返回进度
        NSLog(@"downloadProgress-->%@",downloadProgress);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //请求成功返回数据 根据responseSerializer 返回不同的数据格式
        // NSLog(@"responseObject-->%@",responseObject);
        
       self.taipeiParkSpots = [TaipeiParkSpots yy_modelWithJSON:responseObject];
        
        
       NSArray *parkSpots = self.taipeiParkSpots.result.results;
       NSSortDescriptor *sortByNumber = [NSSortDescriptor sortDescriptorWithKey:@"_id" ascending:YES];
       NSArray *resultArray = [parkSpots sortedArrayUsingDescriptors:[NSArray arrayWithObjects:sortByNumber, nil]];
        
        
        self.arrayOfArrays = [NSMutableArray array];
        NSUInteger itemsRemaining = parkSpots.count;
        while(itemsRemaining) {
            
            Results* r = [resultArray objectAtIndex:(resultArray.count - itemsRemaining)];
            
            NSPredicate *parkNamePredicate = [NSPredicate predicateWithFormat:@"ParkName = %@", r.ParkName];
            NSArray *spotsOfSamePark;
            spotsOfSamePark = [resultArray filteredArrayUsingPredicate:parkNamePredicate];
            
            [self.arrayOfArrays addObject:spotsOfSamePark];
           
            itemsRemaining-= [spotsOfSamePark count];
           
        }
       //www.jianshu.com/p/11b958862b75
        
        [self.tableView reloadData];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
     
        NSLog(@"error-->%@",error);
    }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
   
    if(self.arrayOfArrays == nil)
        return 0;
    
    return [self.arrayOfArrays count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if(self.arrayOfArrays == nil)
        return 0;
    
   
   return [self.results count]; //2
   //self.taipeiParkSpots.result.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SpotTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SpotCell" forIndexPath:indexPath];
    
    //Results* r = [self.taipeiParkSpots.result.results objectAtIndex:indexPath.row];
    self.results = [self.arrayOfArrays objectAtIndex:indexPath.section];
    Results* r = [self.results objectAtIndex:indexPath.row];
    
    cell.spotName.text = r.Name;
    cell.parkName.text = r.ParkName;
    cell.spotIntroduction.text = r.Introduction;
    
    //sd_setImageWithPreviousCachedImageWithURL //itw01.com/IUNEFJF.html
    [cell.spotImage sd_setImageWithPreviousCachedImageWithURL:[NSURL URLWithString:r.Image] placeholderImage:[UIImage imageNamed:@"taiwan-default.jpg"] options:SDWebImageCacheMemoryOnly progress:^(NSInteger receivedSize, NSInteger expectedSize) {  //这里是图片的下载进度
    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                        //这里可以做图片下载完后要做的事情
     } ];
    
    return cell;
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
  
    self.results = [self.arrayOfArrays objectAtIndex:section]; //1
    Results* r = [self.results objectAtIndex:0];
    
    return r.ParkName;
}


#pragma mark -  storyboard
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    
    id taipeiParkSpotViewController = segue.destinationViewController;
 
    NSIndexPath *indexPath = [self.tableView indexPathForCell:sender];
    
    [taipeiParkSpotViewController setValue:@(indexPath.section) forKey:@"parkIndex"];
    [taipeiParkSpotViewController setValue:@(indexPath.row) forKey:@"spotIndex"];
    [taipeiParkSpotViewController setValue:[self.arrayOfArrays copy] forKey:@"arrayOfArrays"];
   
    //www.jianshu.com/p/c5114958fec2 
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
