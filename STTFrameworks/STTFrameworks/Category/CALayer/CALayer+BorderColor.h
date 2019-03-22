//
//  CALayer+BorderColor.h
//  AiXiaoPing
//
//  Created by ZSY on 2018/1/3.
//  Copyright © 2018年 ZSY. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import <UIKit/UIKit.h>

@interface CALayer (BorderColor)
/*
 *  摇动
 */
-(void)shake;
///  设置边框线颜色
- (void)setBorderUIColor:(UIColor *)borderColor;
///  设置视图阴影
-(void)showderRedius:(CGFloat)redius offset:(CGSize)size opacity:(CGFloat)opacity color:(UIColor *)color ;

@end
