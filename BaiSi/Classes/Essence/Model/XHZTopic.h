//
//  XHZTopic.h
//  BaiSi
//
//  Created by 朱晓峰 on 2016/11/26.
//  Copyright © 2016年 朱晓峰. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface XHZTopic : NSObject
@property(nonatomic,copy)NSString * name;
@property(nonatomic,copy)NSString * profile_image;
@property(nonatomic,copy)NSString * create_time;
@property(nonatomic,copy)NSString * text;
@property(nonatomic,assign)NSInteger  ding;
@property(nonatomic,assign)NSInteger cai;
@property(nonatomic,assign)NSInteger repost;
@property(nonatomic,assign)NSInteger comment;
@property(nonatomic,assign,getter=isSina)BOOL sina_v;
@property(nonatomic,assign)CGFloat width;
@property(nonatomic,assign)CGFloat height;
@property(nonatomic,copy)NSString * small_image;

@property(nonatomic,copy)NSString * middle_image;

@property(nonatomic,copy)NSString * large_image;

@property(nonatomic,assign)CGFloat cellHeight;

@property(nonatomic,assign)XHZTopicType type;

@property(nonatomic,assign,readonly)CGRect pictureF;

@property(nonatomic,assign,getter=isBigPicture)BOOL bigPicture;

@property(nonatomic,assign)CGFloat pictureProgress;

@end
