//
//  XHZLoginTextField.m
//  BaiSi
//
//  Created by 朱晓峰 on 2016/11/25.
//  Copyright © 2016年 朱晓峰. All rights reserved.
//

#import "XHZLoginTextField.h"

@implementation XHZLoginTextField
-(void)awakeFromNib{
//    self.tintColor光标颜色
    

    [super awakeFromNib];
    [self resignFirstResponder];
}
-(BOOL)becomeFirstResponder{
    [self setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
    self.tintColor=[UIColor whiteColor];
    return [super becomeFirstResponder];
}
-(BOOL)resignFirstResponder{
    [self setValue:[UIColor grayColor] forKeyPath:@"_placeholderLabel.textColor"];
    return  [super resignFirstResponder];
}

@end
