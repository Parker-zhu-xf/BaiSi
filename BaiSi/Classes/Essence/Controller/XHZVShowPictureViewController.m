//
//  XHZVShowPictureViewController.m
//  BaiSi
//
//  Created by 朱晓峰 on 2016/11/27.
//  Copyright © 2016年 朱晓峰. All rights reserved.
//

#import "XHZVShowPictureViewController.h"
#import "XHZTopic.h"
#import "SVProgressHUD.h"
#import "UIImageView+WebCache.h"
#import "DALabeledCircularProgressView.h"
@interface XHZVShowPictureViewController ()
@property (weak, nonatomic) IBOutlet DACircularProgressView *progress;
@property(nonatomic,strong)UIImageView *imageView ;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@end

@implementation XHZVShowPictureViewController
- (IBAction)back:(id)sender {
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}
- (IBAction)share:(id)sender {
}
- (IBAction)save:(id)sender {
    if (self.imageView.image==nil) {
        [SVProgressHUD showErrorWithStatus:@"客官别急，正在下载"];
        return;
    }
    UIImageWriteToSavedPhotosAlbum(self.imageView.image, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
}
- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo{
    if (error) {
        [SVProgressHUD showErrorWithStatus:@"保存失败"];    }
    else{
    [SVProgressHUD showSuccessWithStatus:@"保存成功"];
        
    }
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    CGFloat screenH=[UIScreen mainScreen].bounds.size.height;
    CGFloat screenW=[UIScreen mainScreen].bounds.size.width;
    
    UIImageView *imageView=[[UIImageView alloc]init];
    imageView.userInteractionEnabled=YES;
//    imageView.contentMode=UIViewContentModeScaleAspectFit;
    [imageView addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(back:)]];
    [self.scrollView addSubview:imageView];
    CGFloat pictureW=screenW;
    CGFloat pictureH=pictureW *self.topic.height/self.topic.width;
    if (pictureH>screenH) {
        imageView.frame=CGRectMake(0, 0, pictureW, pictureH);
        self.scrollView.contentSize=CGSizeMake(0, pictureH);
    }else{
        imageView.size=CGSizeMake(pictureW, pictureH);
        imageView.centerY=screenH*0.5;
        self.scrollView.contentSize=CGSizeMake(0, screenH);
    }
    [self.progress setProgress:self.topic.pictureProgress animated:NO];
    [imageView sd_setImageWithURL:[NSURL URLWithString:self.topic.large_image]placeholderImage:nil options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        CGFloat progress=1.0*receivedSize/expectedSize;
        [self.progress setProgress:progress animated:YES];
    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        self.progress.hidden=YES;
    }];
    
    self.imageView=imageView;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
