//
//  UIBarButtonItem+XHZExtension.h
//  BaiSi
//
//  Created by 朱晓峰 on 2016/11/24.
//  Copyright © 2016年 朱晓峰. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (XHZExtension)
+(instancetype)itemWithImage:(NSString *)image hightImage:(NSString *)hightImage action:(SEL)action target:(id)target;
@end
