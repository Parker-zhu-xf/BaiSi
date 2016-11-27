//
//  XHZTopicPictureView.m
//  BaiSi
//
//  Created by 朱晓峰 on 2016/11/27.
//  Copyright © 2016年 朱晓峰. All rights reserved.
//

#import "XHZTopicPictureView.h"
#import "UIImageView+WebCache.h"
#import "DALabeledCircularProgressView.h"
#import "XHZVShowPictureViewController.h"
@interface XHZTopicPictureView ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIImageView *gifView;
@property (weak, nonatomic) IBOutlet UIButton *seeBigButton;
@property (weak, nonatomic) IBOutlet DALabeledCircularProgressView *progressView;

@end

@implementation XHZTopicPictureView
-(void)awakeFromNib{
    [super awakeFromNib];
    self.autoresizingMask=UIViewAutoresizingNone;
    self.progressView.roundedCorners=2;
    
    self.imageView.userInteractionEnabled=YES;
    [self.imageView addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(showPicture)]];
}
-(void)showPicture{
    XHZVShowPictureViewController *showPicture=[[XHZVShowPictureViewController alloc]init];
    showPicture.topic=self.topic;
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:showPicture animated:YES completion:^{
        
    }];
}
+(instancetype)pictureView{
    return [[NSBundle mainBundle]loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil].lastObject;
}
-(void)setTopic:(XHZTopic *)topic{
    _topic=topic;
    [self.progressView setProgress:topic.pictureProgress animated:NO];
//    [self.imageView sd_setImageWithURL:[NSURL URLWithString:topic.large_image] placeholderImage:[UIImage imageNamed:@""]];
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:topic.large_image] placeholderImage:nil options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        self.progressView.hidden=NO;
        topic.pictureProgress=1.0*receivedSize/expectedSize;
//        progress=progress<0?0:progress;
        [self.progressView setProgress:topic.pictureProgress];
//        self.progressView.progressLabel.text=[NSString stringWithFormat:@"%0.f%%",progress];
    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        self.progressView.hidden=YES;
        if (!topic.bigPicture) {
            return ;
        }
        UIGraphicsBeginImageContextWithOptions(topic.pictureF.size, YES, 0.0);
        
        CGFloat width=topic.pictureF.size.width;
        CGFloat height=width*image.size.height/image.size.width;
        [image drawInRect:CGRectMake(0, 0, width, height)];
        self.imageView.image=UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
    }];
    NSString *extension=topic.large_image.pathExtension;
    
    self.gifView.hidden=![extension.lowercaseString isEqualToString:@"gif"];
    if (topic.bigPicture) {
        self.seeBigButton.hidden=NO;
        self.imageView.contentMode=UIViewContentModeScaleAspectFill;
        
    }else{
        self.seeBigButton.hidden=YES;
        self.imageView.contentMode=UIViewContentModeScaleToFill;
    }
}
- (IBAction)showFullPictureButton:(id)sender {
    
}
@end
