//
//  XHZMeViewController.m
//  BaiSi
//
//  Created by 朱晓峰 on 2016/11/23.
//  Copyright © 2016年 朱晓峰. All rights reserved.
//

#import "XHZMeViewController.h"

@interface XHZMeViewController ()

@end

@implementation XHZMeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor=XHZBGColor;
    self.navigationItem.title=@"我的";    
    
    self.navigationItem.rightBarButtonItems=@[
                                            [UIBarButtonItem itemWithImage:@"mine-setting-icon" hightImage:@"mine-setting-icon-click" action:@selector(settingClick) target:self],
                                            [UIBarButtonItem itemWithImage:@"mine-moon-icon" hightImage:@"mine-moon-icon-click" action:@selector(nightModeClick) target:self]
                                            
                                              ];
}
-(void)settingClick{
    XHZFUNC;
}
-(void)nightModeClick{
    XHZFUNC;
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
