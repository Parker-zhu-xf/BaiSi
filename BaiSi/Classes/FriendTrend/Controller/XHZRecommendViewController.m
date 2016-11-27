//
//  XHZRecommendViewController.m
//  BaiSi
//
//  Created by 朱晓峰 on 2016/11/24.
//  Copyright © 2016年 朱晓峰. All rights reserved.
//熊孩子网络

#import "XHZRecommendViewController.h"
#import "AFNetworking.h"
#import "SVProgressHUD.h"
#import "MJExtension.h"
#import "XHZRecommendCategoryCell.h"
#import "XHZRecommendCategory.h"
#import "XHZRecommendUserCell.h"
#import "XHZRecommendUser.h"
#import "MJRefresh.h"

#define XHZSelectedCategory self.categories[self.categoryTableView.indexPathForSelectedRow.row]
//网络数据没有返回时再请求另一组数据时产生的问题
@interface XHZRecommendViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *userTableView;
@property(nonatomic,strong)NSArray * categories;
@property (weak, nonatomic) IBOutlet UITableView *categoryTableView;
@property(nonatomic,strong)NSMutableDictionary * params;
@property(nonatomic,strong)AFHTTPSessionManager *manager;
@end
static NSString *categoryID=@"category";
static NSString *userID=@"user";
@implementation XHZRecommendViewController
-(AFHTTPSessionManager *)manager{
    if (!_manager) {
        _manager=[AFHTTPSessionManager manager];
    }
    return _manager;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self setupTableView];
    [self setupRefresh];
}


-(void)setupTableView{
    //设置背景
    self.view.backgroundColor=XHZBGColor;
//    设置标题
    self.navigationItem.title=@"推荐关注";
//    把左侧多余cell隐藏
    self.categoryTableView.tableFooterView=[[UIView alloc]init];
//    调整tableView的位置，不被遮挡
    self.automaticallyAdjustsScrollViewInsets=NO;
    self.categoryTableView.contentInset=UIEdgeInsetsMake(64, 0, 0, 0);
    self.userTableView.contentInset=UIEdgeInsetsMake(64, 0, 0, 0);
//    设置右侧cell行高
    self.userTableView.rowHeight=60;
//    提前注册
    [self.categoryTableView registerNib:[UINib nibWithNibName:NSStringFromClass([XHZRecommendCategoryCell class]) bundle:nil] forCellReuseIdentifier:categoryID];
    [self.userTableView registerNib:[UINib nibWithNibName:NSStringFromClass([XHZRecommendUserCell class]) bundle:nil] forCellReuseIdentifier:userID];
//    加载显示
    [SVProgressHUD show];
//    请求数据
    
    NSMutableDictionary *params=[NSMutableDictionary dictionary];
    params[@"a"]=@"category";
    params[@"c"]=@"subscribe";
    [self.manager GET:@"http://api.budejie.com/api/api_open.php" parameters:params success:^(NSURLSessionDataTask *task, id responseObject) {
//        拿到数据
        self.categories=[XHZRecommendCategory mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        
        [SVProgressHUD dismiss];
//        刷新右侧表格
        [self.categoryTableView reloadData];
//        设置默认选中行
        [self.categoryTableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:NO scrollPosition:UITableViewScrollPositionTop];
        
        [self tableView:self.categoryTableView didSelectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        [SVProgressHUD showErrorWithStatus:@"加载失败！请稍后再试。。。"];
    }];

}
-(void)setupRefresh{
    
    self.userTableView.header=[MJRefreshNormalHeader  headerWithRefreshingTarget:self refreshingAction:@selector(loadNewUsers)];
    
    self.userTableView.footer=[MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreUsers)];
    self.userTableView.footer.hidden=YES;
}
//上拉刷新
-(void)loadNewUsers{
    XHZRecommendCategory *category=XHZSelectedCategory;
    category.currentPage=1;
    NSMutableDictionary *params=[NSMutableDictionary dictionary];
//    [category.usersl removeAllObjects];
    params[@"a"]=@"list";
    params[@"c"]=@"subscribe";
    params[@"category_id"]=category.id;
    params[@"page"]=@(category.currentPage);
    self.params=params;
    [self.manager GET:@"http://api.budejie.com/api/api_open.php" parameters:params success:^(NSURLSessionDataTask *task, id responseObject) {
        NSArray *users=[XHZRecommendUser mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        [category.usersl removeAllObjects];
        [category.usersl addObjectsFromArray:users];
        category.total=[responseObject[@"total"] integerValue];
        
        if (self.params!=params) {
            return ;
        }
        
        [self.userTableView reloadData];
        if (category.usersl.count==category.total) {
            self.userTableView.footer.hidden=YES;            }
        
        [self.userTableView.header endRefreshing];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        [self.userTableView.header endRefreshing];
    }];
}
//加载更多数据，下拉刷新
-(void)loadMoreUsers{
    XHZRecommendCategory *category=XHZSelectedCategory;
    NSMutableDictionary *params=[NSMutableDictionary dictionary];
    
    params[@"a"]=@"list";
    params[@"c"]=@"subscribe";
    params[@"category_id"]=category.id;
    params[@"page"]=@(++category.currentPage);
    self.params=params;
    [self.manager GET:@"http://api.budejie.com/api/api_open.php" parameters:params success:^(NSURLSessionDataTask *task, id responseObject) {
        
        NSArray *users=[XHZRecommendUser mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        [category.usersl addObjectsFromArray:users];
        if (self.params!=params) {
            return ;
        }
        [self.userTableView reloadData];
        
        if (category.usersl.count==category.total) {
            self.userTableView.footer.hidden=YES;
        }else{
            [self.userTableView.footer endRefreshing];
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        
    }];
    
    
}
-(void)checkFooterState{
     XHZRecommendCategory *category=XHZSelectedCategory;
#pragma mark 这行代码崩溃
//   self.userTableView.footer.hidden=(category.usersl.count==0);

    if (category.usersl.count==category.total) {
        self.userTableView.footer.hidden=YES;
    }
    else{
        [self.userTableView.footer endRefreshing];
    }
    }
#pragma mark -----datasource----
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (tableView==self.categoryTableView) {
        return self.categories.count;
    }
    else{
        
        [self checkFooterState];
        return [XHZSelectedCategory usersl].count;
    }
    
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView==self.categoryTableView) {
        XHZRecommendCategoryCell *cell=[tableView dequeueReusableCellWithIdentifier:categoryID];
        cell.category=self.categories[indexPath.row];
        return cell;
    }
    else{
        XHZRecommendUserCell *cell=[tableView dequeueReusableCellWithIdentifier:userID];
        XHZRecommendCategory *category=XHZSelectedCategory;
        cell.user=category.usersl[indexPath.row];
        return cell;
    }
    
}
#pragma mark -------delegate------
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self.userTableView.footer endRefreshing];
    [self.userTableView.footer endRefreshing];
//    判断选中的是左侧tableView
    if (tableView==self.categoryTableView) {
        
        XHZRecommendCategory *category=self.categories[indexPath.row];
        
        [self.userTableView reloadData];
        if (category.usersl.count) {
            if (category.usersl.count==category.total) {
                self.userTableView.footer.hidden=YES;            }
        }
        else{
        
            [self.userTableView.header beginRefreshing];
        }
    }
    
    
}
-(void)dealloc{
    //停止返回数据,防止控制器死之后产生的问题
    [self.manager.operationQueue cancelAllOperations];
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [SVProgressHUD dismiss];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
