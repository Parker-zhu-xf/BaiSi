//
//  XHZTopicCell.m
//  BaiSi
//
//  Created by 朱晓峰 on 2016/11/26.
//  Copyright © 2016年 朱晓峰. All rights reserved.
//

#import "XHZTopicCell.h"
#import "XHZTopic.h"
#import "UIImageView+WebCache.h"
#import "XHZTopicPictureView.h"
@interface XHZTopicCell ()
@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;
@property (weak, nonatomic) IBOutlet UIImageView *sinaVView;
@property (weak, nonatomic) IBOutlet UILabel *text_lable;

@property (weak, nonatomic) IBOutlet UILabel *nameLable;
@property (weak, nonatomic) IBOutlet UILabel *createTimeLable;
@property (weak, nonatomic) IBOutlet UIButton *dingButton;
@property (weak, nonatomic) IBOutlet UIButton *caiButton;
@property (weak, nonatomic) IBOutlet UIButton *shareButton;
@property (weak, nonatomic) IBOutlet UIButton *commentButton;

@property(nonatomic,strong)XHZTopicPictureView *pictureView;

@end

@implementation XHZTopicCell
-(XHZTopicPictureView *)pictureView{
    if (!_pictureView) {
        XHZTopicPictureView *pictureView=[XHZTopicPictureView pictureView];
        [self.contentView addSubview:pictureView];
        _pictureView = pictureView;
    }
    return _pictureView;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    UIImageView *bgView=[[UIImageView alloc]init];
    bgView.image=[UIImage imageNamed:@"mainCellBackground"];
    self.backgroundView=bgView;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)setTopic:(XHZTopic *)topic{
    _topic =topic;
    self.sinaVView.hidden=!topic.sina_v;
    [self.profileImageView sd_setImageWithURL:[NSURL URLWithString:topic.profile_image] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"]];
    self.nameLable.text=topic.name;
    self.createTimeLable.text=topic.create_time;
    
    
    
    
    [self setupButtonTitle:self.dingButton count:topic.ding];
    
    [self setupButtonTitle:self.caiButton count:topic.cai];
    
    [self setupButtonTitle:self.shareButton count:topic.repost];
    
    [self setupButtonTitle:self.commentButton count:topic.comment];
    self.text_lable.text=topic.text;
    
    if (topic.type==XHZTopicTypePicture) {
        self.pictureView.topic=topic;
        self.pictureView.frame=topic.pictureF;
    }
}
-(void)setupButtonTitle:(UIButton *)button count:(NSInteger)count{
    NSString *title=nil;
    if (count>10000) {
        title=[NSString stringWithFormat:@"%.1ld万",count/1000];
    }
    else{
        title=[NSString stringWithFormat:@"%zd",count];
        
    }
    [button setTitle:title forState:UIControlStateNormal];
}
-(void)setFrame:(CGRect)frame{
    frame.origin.x=10;
    frame.size.width-=2*frame.origin.x;
    frame.size.height-=10;
    frame.origin.y+=10;
    self.layer.cornerRadius=5;
    self.layer.masksToBounds=YES;
    [super setFrame:frame];
}

@end
