//
//  XHZVerticalButton.m
//  BaiSi
//
//  Created by 朱晓峰 on 2016/11/25.
//  Copyright © 2016年 朱晓峰. All rights reserved.
//

#import "XHZVerticalButton.h"

@implementation XHZVerticalButton
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if ( self) {
    self.titleLabel.textAlignment=NSTextAlignmentCenter;

    }
    return self;
}
-(void)awakeFromNib{
    self.titleLabel.textAlignment=NSTextAlignmentCenter;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(void)layoutSubviews{
    [super layoutSubviews];
    self.imageView.x=0 ;
    self.imageView.y=0;
    self.imageView.width=self.width;
    self.imageView.height=self.imageView.width;
    self.titleLabel.x=0;
    self.titleLabel.y=self.imageView.height;
    self.titleLabel.width=self.width;
    self.titleLabel.height=self.height-self.titleLabel.y;
}

@end
