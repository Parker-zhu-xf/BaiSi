//
//  XHZRecommendCategory.m
//  BaiSi
//
//  Created by 朱晓峰 on 2016/11/24.
//  Copyright © 2016年 朱晓峰. All rights reserved.
//

#import "XHZRecommendCategory.h"

@implementation XHZRecommendCategory
-(NSMutableArray *)usersl{
    if (!_usersl) {
        _usersl=[NSMutableArray array];
        
    }
    return _usersl;
}
@end
