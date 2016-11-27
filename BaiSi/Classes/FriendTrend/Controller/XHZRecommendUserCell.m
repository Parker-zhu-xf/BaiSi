//
//  XHZRecommendUserCell.m
//  BaiSi
//
//  Created by 朱晓峰 on 2016/11/24.
//  Copyright © 2016年 朱晓峰. All rights reserved.
//
//headerImageView头像设置成圆角
#import "XHZRecommendUserCell.h"
#import "XHZRecommendUser.h"
#import "UIImageView+WebCache.h"
@interface XHZRecommendUserCell ()
@property (weak, nonatomic) IBOutlet UILabel *fansCountLable;
@property (weak, nonatomic) IBOutlet UIImageView *headerImageView;
@property (weak, nonatomic) IBOutlet UILabel *screenNameLable;

@end

@implementation XHZRecommendUserCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.headerImageView.layer.cornerRadius=20;
    self.headerImageView.layer.masksToBounds=YES;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setUser:(XHZRecommendUser *)user{
    _user=user;
    self.screenNameLable.text=user.screen_name;
    self.fansCountLable.text=[NSString stringWithFormat:@"%ld人关注",user.fans_count];
    
    [self.headerImageView sd_setImageWithURL:[NSURL URLWithString:user.header] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"]];
}
@end
