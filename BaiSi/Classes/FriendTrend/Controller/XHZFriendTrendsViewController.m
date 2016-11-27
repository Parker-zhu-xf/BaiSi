//
//  XHZFriendTrendsViewController.m
//  BaiSi
//
//  Created by 朱晓峰 on 2016/11/23.
//  Copyright © 2016年 朱晓峰. All rights reserved.
//

#import "XHZFriendTrendsViewController.h"
#import "XHZRecommendViewController.h"
#import "XHZLoginRegisterViewController.h"
@interface XHZFriendTrendsViewController ()

@end

@implementation XHZFriendTrendsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor=XHZBGColor;
    self.navigationItem.title=@"我的关注";
    
    self.navigationItem.leftBarButtonItem=[UIBarButtonItem itemWithImage:@"friendsRecommentIcon" hightImage:@"friendsRecommentIcon-click" action:@selector(friendClick) target:self];
}
-(void)friendClick{
    XHZRecommendViewController *vc=[[XHZRecommendViewController alloc]init];
    
    [self.navigationController pushViewController:vc animated:YES];
    
}
- (IBAction)loginRegister:(id)sender {
    XHZLoginRegisterViewController *vc=[[XHZLoginRegisterViewController alloc]init];
    [self presentViewController:vc animated:YES completion:^{
        
    }];
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
