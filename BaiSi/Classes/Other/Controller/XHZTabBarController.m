//
//  XHZTabBarController.m
//  BaiSi
//
//  Created by 朱晓峰 on 2016/11/23.
//  Copyright © 2016年 朱晓峰. All rights reserved.
//熊孩子网络

#import "XHZTabBarController.h"
#import "XHZEssenceViewController.h"
#import "XHZNewViewController.h"
#import "XHZMeViewController.h"
#import "XHZFriendTrendsViewController.h"
#import "XHZNavigationController.h"
#import "XHZTabBar.h"
@interface XHZTabBarController ()

@end

@implementation XHZTabBarController
+(void)initialize{
    NSMutableDictionary *attrs=[NSMutableDictionary dictionary];
    attrs[NSForegroundColorAttributeName]=[UIColor lightGrayColor];
    
    NSMutableDictionary *attrsel=[NSMutableDictionary dictionary];
    attrsel[NSForegroundColorAttributeName]=[UIColor grayColor];
    
    UITabBarItem *item=[UITabBarItem appearance];
    [item setTitleTextAttributes:attrs forState:UIControlStateNormal];
    [item setTitleTextAttributes:attrsel forState:UIControlStateSelected];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    [self setupChildVc:@"精华" image:@"tabBar_essence_icon" selectImage:@"tabBar_essence_click_icon" VCType:[XHZEssenceViewController new]];
    
    [self setupChildVc:@"新帖" image:@"tabBar_new_icon" selectImage:@"tabBar_new_click_icon"VCType:[XHZNewViewController new]];
    
    [self setupChildVc:@"关注" image:@"tabBar_friendTrends_icon" selectImage:@"tabBar_friendTrends_click_icon"VCType:[XHZFriendTrendsViewController new]];
    
    [self setupChildVc:@"我" image:@"tabBar_me_icon" selectImage:@"tabBar_me_click_icon" VCType:[XHZMeViewController new]];
    
    [self setValue:[[XHZTabBar alloc]init]forKeyPath:@"tabBar"];
}
-(void)setupChildVc:(NSString *)title image:(NSString *)image selectImage:(NSString *)selectImage VCType:(UIViewController *)vc{
    vc.tabBarItem.title=title;
    vc.navigationItem.title=title;
    vc.tabBarItem.image=[UIImage imageNamed:image];
    vc.tabBarItem.selectedImage=[UIImage imageNamed:selectImage];
    XHZNavigationController *nav=[[XHZNavigationController alloc]initWithRootViewController:vc];
    
    [self addChildViewController:nav];
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
