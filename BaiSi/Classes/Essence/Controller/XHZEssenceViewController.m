//
//  XHZEssenceViewController.m
//  BaiSi
//
//  Created by 朱晓峰 on 2016/11/23.
//  Copyright © 2016年 朱晓峰. All rights reserved.
//

#import "XHZEssenceViewController.h"
#import "XHZRecommendTagViewController.h"
#import "XHZTopicViewController.h"

@interface XHZEssenceViewController ()<UIScrollViewDelegate>
@property(nonatomic,weak)UIView * indicatorView;
@property(nonatomic,weak)UIButton * selectButton;

/** 顶部的所有标签 */
@property (nonatomic, weak) UIView *titlesView;
/** 底部的所有内容 */
@property (nonatomic, weak) UIScrollView *contentView;
@end

@implementation XHZEssenceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setupNav];
    
     [self setupChildVC];
    [self setupTitlesView];
    [self setupContentView];
    
    
    
   
    
}
-(void)setupChildVC{
    XHZTopicViewController *all=[[XHZTopicViewController alloc]init];
    all.title=@"全部";
    all.type=XHZTopicTypeAll;
    [self addChildViewController:all];
    
    XHZTopicViewController *video=[[XHZTopicViewController alloc]init];
    video.title=@"视频";
    video.type=XHZTopicTypeVideo;
    [self addChildViewController:video];
    
    XHZTopicViewController *voice=[[XHZTopicViewController alloc]init];
    voice.type=XHZTopicTypeVoice;
    voice.title=@"声音";
    [self addChildViewController:voice];
    
    XHZTopicViewController *word=[[XHZTopicViewController alloc]init];
    word.title=@"段子";
    word.type=XHZTopicTypeWord;
    [self addChildViewController:word];
    
    XHZTopicViewController *piccture=[[XHZTopicViewController alloc]init];
    piccture.title=@"图片";
    piccture.type=XHZTopicTypePicture;
    [self addChildViewController:piccture];
    
    
    
   
    
}
-(void)setupContentView{
    
    self.automaticallyAdjustsScrollViewInsets=NO;
    
    UIScrollView *contentView=[[UIScrollView alloc]initWithFrame:self.view.bounds];
    contentView.backgroundColor=[UIColor clearColor];
    contentView.contentInset=UIEdgeInsetsMake(99, 0, 49, 0);
    contentView.delegate=self;
    contentView.pagingEnabled=YES;
//    [self.view addSubview:contentView];
    [self.view insertSubview:contentView atIndex:0];
    contentView.contentSize = CGSizeMake(contentView.width * self.childViewControllers.count, 0);
    self.contentView = contentView;
//
//    // 添加第一个控制器的view
    [self scrollViewDidEndScrollingAnimation:contentView];
    
}
-(void)setupTitlesView{
    
    
    
    UIView *titlesView=[[UIView alloc]init];
    titlesView.backgroundColor=[UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:0.5];
    titlesView.width=self.view.width;
    titlesView.height=XHZtitlesViewH;
    titlesView.y=XHZtitlesViewY;
    [self.view addSubview:titlesView];
    self.titlesView = titlesView;
    
    UIView *indicatorView=[[UIView alloc]init];
    indicatorView.backgroundColor=[UIColor redColor];
    indicatorView.height=2;
    indicatorView.y=titlesView.height-indicatorView.height;
    
    indicatorView.tag = -1;
    self.indicatorView=indicatorView;
    
//    NSArray *titles=@[@"全部",@"视频",@"声音",@"图片",@"段子"];
    CGFloat width=titlesView.width/self.childViewControllers.count;
    CGFloat height=titlesView.height;
    for (NSInteger i=0; i<self.childViewControllers.count; i++) {
        UIButton *button=[[UIButton alloc]init];
        button.height=height;
        button.tag = i;
        button.width=width;
        button.x=i*width;
        UIViewController *vc=self.childViewControllers[i];
        [button setTitle:vc.title forState:UIControlStateNormal];
        [button  setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor redColor] forState:UIControlStateDisabled];
//        [button layoutIfNeeded];//强制布局
        button.titleLabel.font=[UIFont systemFontOfSize:14];
        
        [button addTarget:self action:@selector(titleClick:) forControlEvents:UIControlEventTouchUpInside];
        [titlesView addSubview:button];
        if (i==0) {
            button.enabled=NO;
            [button.titleLabel sizeToFit];
            self.selectButton=button;
            self.indicatorView.width=button.titleLabel.width;
            self.indicatorView.centerX=button.centerX;
        }
    }
    [titlesView addSubview:indicatorView];
    
}
-(void)titleClick:(UIButton *)button{
    self.selectButton.enabled=YES;
      button.enabled=NO;
    self.selectButton=button;
    [UIView animateWithDuration:0.25 animations:^{
        self.indicatorView.width=button.titleLabel.width;
        self.indicatorView.centerX=button.centerX;
    }];
    // 滚动
    CGPoint offset = self.contentView.contentOffset;
    offset.x = button.tag * self.contentView.width;
    [self.contentView setContentOffset:offset animated:YES];
    
}
-(void)setupNav{
    self.view.backgroundColor=XHZBGColor;
    self.navigationItem.titleView=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"MainTitle"]];
    
    self.navigationItem.leftBarButtonItem=[UIBarButtonItem itemWithImage:@"MainTagSubIcon" hightImage:@"MainTagSubIconClick" action:@selector(tagClick) target:self];
}
-(void)tagClick{
    XHZRecommendTagViewController *vc=[[XHZRecommendTagViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
    
}
#pragma mark - <UIScrollViewDelegate>
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    // 当前的索引
    NSInteger index = scrollView.contentOffset.x / scrollView.width;
    
    // 取出子控制器
    UITableViewController *vc = self.childViewControllers[index];
    vc.view.x = scrollView.contentOffset.x;
    vc.view.y = 0; // 设置控制器view的y值为0(默认是20)
    CGFloat bottom = self.tabBarController.tabBar.height;
    CGFloat top = CGRectGetMaxY(self.titlesView.frame);
    vc.view.height = scrollView.height-bottom-top; // 设置控制器view的height值为整个屏幕的高度(默认是比屏幕高度少个20)
    // 设置内边距
    
//    vc.tableView.contentInset = UIEdgeInsetsMake(0, 0, bottom, 0);
    // 设置滚动条的内边距
    vc.tableView.scrollIndicatorInsets = vc.tableView.contentInset;
    [scrollView addSubview:vc.view];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self scrollViewDidEndScrollingAnimation:scrollView];
    
    // 点击按钮
    NSInteger index = scrollView.contentOffset.x / scrollView.width;
    [self titleClick:self.titlesView.subviews[index]];
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
