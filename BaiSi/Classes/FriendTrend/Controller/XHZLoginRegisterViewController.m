//
//  XHZLoginRegisterViewController.m
//  BaiSi
//
//  Created by 朱晓峰 on 2016/11/25.
//  Copyright © 2016年 朱晓峰. All rights reserved.
//

#import "XHZLoginRegisterViewController.h"
@interface XHZLoginRegisterViewController ()
@property (weak, nonatomic) IBOutlet UIButton *cancelButton;
@property (weak, nonatomic) IBOutlet UITextField *iphoneFiled;
@property (weak, nonatomic) IBOutlet UIButton *loginButton;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *loginViewLeftMargin;

@end

@implementation XHZLoginRegisterViewController
- (IBAction)cancelBtnClick:(id)sender {
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.loginButton.layer.cornerRadius=5;
    self.loginButton.layer.masksToBounds=YES;
    
}
//ios7之后，状态栏由控制器控制
-(UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}
- (IBAction)showLoginOrRegister:(UIButton *)button {
    if (self.loginViewLeftMargin.constant==0) {
        self.loginViewLeftMargin.constant= -self.view.width;
        [button setTitle:@"已有账号？" forState:UIControlStateNormal];
        [UIView animateWithDuration:0.25 animations:^{
            [self.view layoutSubviews];
        }];
    }
    else{
        self.loginViewLeftMargin.constant=0;
        [button setTitle:@"注册账号" forState:UIControlStateNormal];
        [UIView animateWithDuration:0.25 animations:^{
            [self.view layoutSubviews];
        }];
        
    }
    
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
