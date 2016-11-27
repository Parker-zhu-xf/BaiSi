//
//  XHZWordTableViewController.m
//  BaiSi
//
//  Created by 朱晓峰 on 2016/11/25.
//  Copyright © 2016年 朱晓峰. All rights reserved.
//

#import "XHZTopicViewController.h"
#import "AFNetworking.h"
#import "MJRefresh.h"
#import "UIImageView+WebCache.h"
#import "XHZTopic.h"
#import "MJExtension.h"
#import "XHZTopicCell.h"

@interface XHZTopicViewController ()
@property(nonatomic,strong)NSMutableArray * topcis;
@property(nonatomic,assign)NSInteger page;
@property(nonatomic,copy)NSString * maxtime;
@property(nonatomic,strong)NSMutableDictionary *params;

@property(nonatomic,strong)NSMutableArray * arr;
@end

static NSString *XHZTopicCellId=@"topic";

@implementation XHZTopicViewController
-(NSMutableArray *)arr{
    if (!_arr) {
        _arr=[[NSMutableArray alloc]init];
    }
    return _arr;
}
-(NSMutableArray *)topcis
{
    if (!_topcis) {
        _topcis=[NSMutableArray array];
    }
    return _topcis;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupTableView];
    [self setupRefresh];
    
    
}
-(void)setupTableView{
    self.tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor=[UIColor clearColor];
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([XHZTopicCell class]) bundle:nil] forCellReuseIdentifier:XHZTopicCellId];
}
-(void)setupRefresh{
    self.tableView.header=[MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewTopics)];
    self.tableView.footer=[MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreTopics)];
    self.tableView.header.automaticallyChangeAlpha=YES;
    [self.tableView.header beginRefreshing];
    self.tableView.footer.hidden=YES;
}
-(void)loadMoreTopics{
    [self.tableView.header endRefreshing];
    self.page++;
    
    NSMutableDictionary *params=[NSMutableDictionary dictionary];
    params[@"a"]=@"list";
    params[@"c"]=@"data";
    params[@"type"]=@(self.type);
    params[@"page"]=@(self.page);
    params[@"maxtime"]=self.maxtime;
    self.params=params;
    [[AFHTTPSessionManager manager]GET:@"http://api.budejie.com/api/api_open.php" parameters:params success:^(NSURLSessionDataTask *task, id responseObject) {
        if (self.params!=params) {
            return ;
        }
        
        self.maxtime=responseObject[@"info"][@"maxtime"];
        NSArray *newtopcis=[XHZTopic mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        [self.topcis addObjectsFromArray:newtopcis];
        [self.tableView reloadData];
        [self.tableView.footer endRefreshing];
        //        [responseObject writeToFile:@"/Users/zhuxiaofeng/Desktop/1.plist" atomically:YES];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [self.tableView.footer endRefreshing];
        if (self.page>0) {
            self.page--;
        }
        
    }];
    
}
-(void)loadNewTopics{
    
    [self.tableView.footer endRefreshing];
    
    NSMutableDictionary *params=[NSMutableDictionary dictionary];
    params[@"a"]=@"list";
    params[@"c"]=@"data";
    params[@"type"]=@(self.type);
    self.params=params;
    [[AFHTTPSessionManager manager]GET:@"http://api.budejie.com/api/api_open.php" parameters:params success:^(NSURLSessionDataTask *task, id responseObject) {
        if (self.params!=params) {
            return ;
        }
        
        self.topcis=[XHZTopic mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        
        
        //        NSArray *arr=self.topcis;
        //        [self.topcis addObjectsFromArray:topics];
        //        [self.topcis addObjectsFromArray:arr];
        self.page=0;
        self.maxtime=responseObject[@"info"][@"maxtime"];
        [self.tableView reloadData];
        [self.tableView.header endRefreshing];
        //        [responseObject writeToFile:@"/Users/zhuxiaofeng/Desktop/1.plist" atomically:YES];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        [self.tableView.header endRefreshing];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.topcis.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    
    XHZTopicCell *cell = [tableView dequeueReusableCellWithIdentifier:XHZTopicCellId];
    
    cell.topic=self.topcis[indexPath.row];
    //    XHZTopic *model=self.topcis[indexPath.row];
    //    cell.textLabel.text=model.name;
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    XHZFUNC;
    XHZTopic *topic=self.topcis[indexPath.row];
    
    
//    XHZTopic *topic=self.topcis[indexPath.row];
    return topic.cellHeight;
}

@end
