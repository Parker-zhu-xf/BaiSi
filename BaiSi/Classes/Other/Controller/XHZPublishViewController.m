//
//  XHZPublishViewController.m
//  BaiSi
//
//  Created by 朱晓峰 on 2016/11/27.
//  Copyright © 2016年 朱晓峰. All rights reserved.
//

#import "XHZPublishViewController.h"
#import "XHZVerticalButton.h"
@interface XHZPublishViewController ()

@end

@implementation XHZPublishViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    UIImageView *sloganView=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"app_slogan"]];
    sloganView.y=XHZScreenH*0.2;
    sloganView.centerX=XHZScreenW * 0.5;
    [self.view addSubview:sloganView];
    
    NSArray *images=@[@"publish-video",@"publish-picture",@"publish-text",@"publish-audio",@"publish-review",@"publish-offline"];
    NSArray *titles=@[@"发视频",@"发图片",@"发段子",@"发声音",@"审帖",@"离线下载"];
    CGFloat buttonW=72;
    CGFloat buttonH=buttonW+30;
    int maxCols=3;
    CGFloat buttonStarY=(XHZScreenH-2*buttonH)*0.5;
    CGFloat buttonStartX=20;
    CGFloat xMargin=(XHZScreenW-2*buttonStartX-maxCols*buttonW)/(maxCols-1);
    for (int i=0; i<images.count; i++) {
        XHZVerticalButton *button=[[XHZVerticalButton alloc]init];
        [button setTitle:titles[i] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:images[i]] forState:UIControlStateNormal];
        [button setTitleColor:[[UIColor blackColor]colorWithAlphaComponent:0.8] forState:UIControlStateNormal];
        
        button.width=buttonW;
        button.height=buttonH;
        CGFloat row=i/maxCols;
        CGFloat col=i%maxCols;
        button.x=buttonStartX+col*(xMargin +buttonW);
        button.y=buttonStarY+row*buttonH;
        [self.view addSubview:button];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)cancle:(id)sender {
    [self dismissViewControllerAnimated:NO completion:nil];
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
