//
//  XHZRecommendCategoryCell.m
//  BaiSi
//
//  Created by 朱晓峰 on 2016/11/24.
//  Copyright © 2016年 朱晓峰. All rights reserved.
//

#import "XHZRecommendCategoryCell.h"
#import "XHZRecommendCategory.h"

@interface XHZRecommendCategoryCell (){

}
@property (weak, nonatomic) IBOutlet UIView *selectedIndicator;

@end

@implementation XHZRecommendCategoryCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.backgroundColor=XHZRGBColor(244, 244, 244);
    self.textLabel.textColor=XHZRGBColor(70, 70, 70);
    self.textLabel.font=[UIFont systemFontOfSize:12];
    self.textLabel.highlightedTextColor=XHZRGBColor(219, 21, 26);
    self.selectedBackgroundView=[[UIView alloc]init];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    self.selectedIndicator.hidden=!selected;
    self.textLabel.textColor=selected ?  XHZRGBColor(219, 21, 26) : XHZRGBColor(70, 70, 70);
}

-(void)setCategory:(XHZRecommendCategory *)category{
    _category=category;
    self.textLabel.text=category.name;
}
-(void)layoutSubviews{
    [super layoutSubviews];
    self.textLabel.y=2;
    
    self.textLabel.height=self.contentView.height-2*self.textLabel.y;
}
@end
