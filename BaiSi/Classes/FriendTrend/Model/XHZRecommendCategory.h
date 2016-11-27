//
//  XHZRecommendCategory.h
//  BaiSi
//
//  Created by 朱晓峰 on 2016/11/24.
//  Copyright © 2016年 朱晓峰. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XHZRecommendCategory : NSObject
@property(nonatomic,copy)NSString * id;
@property(nonatomic,assign)NSInteger count;
@property(nonatomic,copy)NSString *name;

@property(nonatomic,strong)NSMutableArray * usersl;

@property(nonatomic,assign)NSInteger total_page;
@property(nonatomic,assign)NSInteger total;
@property(nonatomic,assign)NSInteger next_page;

@property(nonatomic,assign)NSInteger currentPage;
@end
