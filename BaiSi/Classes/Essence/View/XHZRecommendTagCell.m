//
//  XHZRecommendTagCell.m
//  BaiSi
//
//  Created by 朱晓峰 on 2016/11/25.
//  Copyright © 2016年 朱晓峰. All rights reserved.
//

#import "XHZRecommendTagCell.h"
#import "XHZRecommendTag.h"
#import "UIImageView+WebCache.h"
@interface XHZRecommendTagCell ()
@property (weak, nonatomic) IBOutlet UIImageView *imageListImageView;
@property (weak, nonatomic) IBOutlet UILabel *themeNameLable;
@property (weak, nonatomic) IBOutlet UILabel *subNumberLable;

@end

@implementation XHZRecommendTagCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
//拦截，改变cell的大小
-(void)setFrame:(CGRect)frame{
    frame.origin.x=6;
    frame.size.width-=2*frame.origin.x;
    frame.size.height-=1;
    [super setFrame:frame];
}
-(void)setRecommendTag:(XHZRecommendTag *)recommendTag{
    _recommendTag=recommendTag;
    [self.imageListImageView sd_setImageWithURL:[NSURL URLWithString:recommendTag.image_list] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"]];
    self.themeNameLable.text=recommendTag.theme_name;
    
    if (recommendTag.sub_number>10000) {
        CGFloat num=(double)recommendTag.sub_number/10000;
        self.subNumberLable.text=[NSString stringWithFormat:@"%.2lf万人订阅",num];
    }
    else{
    self.subNumberLable.text=[NSString stringWithFormat:@"%zd人订阅",recommendTag.sub_number];
    }
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
