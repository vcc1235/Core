//
//  UITextField+Extension.h
//  Proker
//
//  Created by alete on 2018/5/22.
//  Copyright © 2018年 aletevcc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITextField (Extension)
/** 设置placeHold字体属性 **/
-(void)placeHoldTextFont:(UIFont *)font TextColor:(UIColor *)color Text:(NSString *)placeHold ;
/** 获取输入内容 **/
-(NSString *)trimText ;
@end
