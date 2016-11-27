//
//  XHZTopic.m
//  BaiSi
//
//  Created by 朱晓峰 on 2016/11/26.
//  Copyright © 2016年 朱晓峰. All rights reserved.
//

#import "XHZTopic.h"
#import "MJExtension.h"
@implementation XHZTopic
{
    CGRect _pictureF;
}
+(NSDictionary *)mj_replacedKeyFromPropertyName{
    return @{
             @"small_image":@"image0",
             @"middle_image":@"image1",
             @"large_image":@"image2"
             };
}
-(CGFloat)cellHeight{
    if (!_cellHeight) {
        CGSize maxSize= CGSizeMake([UIScreen mainScreen].bounds.size.width-4*XHZTopicCellMargin, MAXFLOAT);
        XHZLog(@"%@----%@----%@",self.small_image,self.middle_image,self.large_image);
        //    CGFloat textH=[topic.text sizeWithFont:[UIFont systemFontOfSize:14] constrainedToSize:maxSize].height;
        CGFloat textH=[self.text boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil].size.height;
        
        _cellHeight=XHZTopicCellMargin*2+textH +XHZTopicCellBottomBarH+XHZTopicCellTextY;
        
        if (self.type==XHZTopicTypePicture) {
            CGFloat pictureW=maxSize.width;
            CGFloat pictureH=pictureW*self.height/self.width;
            if (pictureH>=XHZTopicCellPictureMaxH) {
                pictureH=XHZTopicPictureBreakH;
                self.bigPicture=YES;
            }
            CGFloat pictureX=XHZTopicCellMargin;
            CGFloat pictureY=XHZTopicCellTextY+textH+XHZTopicCellMargin;
            _pictureF=CGRectMake(pictureX, pictureY, pictureW, pictureH);
            _cellHeight+=pictureH;
            
        }
    }
    
    return _cellHeight;

}
@end
