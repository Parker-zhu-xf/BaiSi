//
//  XHZPushiGuideView.m
//  BaiSi
//
//  Created by 朱晓峰 on 2016/11/25.
//  Copyright © 2016年 朱晓峰. All rights reserved.
//

#import "XHZPushiGuideView.h"

@implementation XHZPushiGuideView
- (IBAction)btnClick:(id)sender {
    [self removeFromSuperview];
}
+(instancetype)puideView{
    
    return [[[NSBundle mainBundle]loadNibNamed:NSStringFromClass([XHZPushiGuideView class]) owner:nil options:nil]lastObject];
}
+(void)show{
    UIWindow *window=[UIApplication sharedApplication].keyWindow;
    NSString *key=@"CFBundleShortVersionString";
    NSString *currentVersion=[NSBundle mainBundle].infoDictionary[key];
    NSString *sanboxVersion=[[NSUserDefaults standardUserDefaults] stringForKey:key];
    if (![currentVersion isEqualToString:sanboxVersion]) {
        XHZPushiGuideView *guideView=[XHZPushiGuideView puideView];
        guideView.frame=window.bounds;
        [window addSubview:guideView];
        [[NSUserDefaults standardUserDefaults]setObject:currentVersion forKey:key];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }

}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
