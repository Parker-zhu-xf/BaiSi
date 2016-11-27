//
//  XHZTabBar.m
//  BaiSi
//
//  Created by 朱晓峰 on 2016/11/23.
//  Copyright © 2016年 朱晓峰. All rights reserved.
//

#import "XHZTabBar.h"
#import "XHZPublishViewController.h"
@interface XHZTabBar()
@property(nonatomic,weak)UIButton *pubulishButton;
@end

@implementation XHZTabBar

-(instancetype)initWithFrame:(CGRect)frame{
    self=[super initWithFrame:frame];
    if (self) {
        
        [self setBackgroundImage:[UIImage imageNamed:@"tabbar-light"]];
        UIButton *pub=[UIButton buttonWithType:UIButtonTypeCustom];
        [pub setBackgroundImage:[UIImage imageNamed:@"tabBar_publish_icon"] forState:UIControlStateNormal];
        [pub setBackgroundImage:[UIImage imageNamed:@"tabBar_publish_click_icon"] forState:UIControlStateHighlighted];
        pub.size=pub.currentBackgroundImage.size;
        [pub addTarget:self action:@selector(publishClick) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:pub];
        self.pubulishButton=pub;
    }
    return self;
}
-(void)publishClick{
    XHZPublishViewController *vc=[[XHZPublishViewController alloc]init];
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:vc animated:NO completion:^{
        
    }];
}
-(void)layoutSubviews{
    [super layoutSubviews];
    
#pragma mark center放在width和height后面设置

    
    self.pubulishButton.center=CGPointMake(self.width*0.5, self.height*0.5);
    
    CGFloat buttonY=0;
    CGFloat buttonW=self.width/5;
    CGFloat buttonH=self.height;
    NSInteger index=0;
    for (UIView *button in self.subviews) {
        if (![button isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
            continue;
        }
        CGFloat buttonX=buttonW*((index>1)?(index+1):index);
        
        button.frame=CGRectMake(buttonX, buttonY, buttonW, buttonH);
        index++;
    }
}
@end
