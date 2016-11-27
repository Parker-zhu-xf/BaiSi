//
//  UIBarButtonItem+XHZExtension.m
//  BaiSi
//
//  Created by 朱晓峰 on 2016/11/24.
//  Copyright © 2016年 朱晓峰. All rights reserved.
//

#import "UIBarButtonItem+XHZExtension.h"

@implementation UIBarButtonItem (XHZExtension)
+(instancetype)itemWithImage:(NSString *)image hightImage:(NSString *)hightImage action:(SEL)action target:(id)target {
    UIButton *button=[UIButton buttonWithType:UIButtonTypeCustom];
    [button setBackgroundImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageNamed:hightImage] forState:UIControlStateHighlighted];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    button.size=button.currentBackgroundImage.size;
//    self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc]initWithCustomView:button];
    return [[self alloc]initWithCustomView:button];
}
@end
