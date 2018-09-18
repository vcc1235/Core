//
//  UIImage+Extension.m
//  STTFrameworks
//
//  Created by alete on 2018/8/20.
//  Copyright © 2018年 aletevcc. All rights reserved.
//

#import "UIImage+Extension.h"

@implementation UIImage (Extension)
+ (void)drawGradient:(CGContextRef)context startColor:(UIColor *)startColor endColor:(UIColor *)endColor
{
    //步骤：
    /*
     一  创建颜色空间
     二  创建渐变
     三  设置裁剪区域
     四  绘制渐变
     五  释放对象
     */
    
    //绘制渐变
    
    //在计算机设置中，直接选择rgb即可，其他颜色空间暂时不用考虑。
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    
    //1.创建渐变
    /*
     1.<#CGColorSpaceRef space#> : 颜色空间 rgb
     2.<#const CGFloat *components#> ： 数组 每四个一组 表示一个颜色 ｛r,g,b,a ,r,g,b,a｝
     3.<#const CGFloat *locations#>:表示渐变的开始位置
     
     */
    
    CGFloat sr,sg,sb,sa;
    CGFloat er,eg,eb,ea;
    [startColor getRed:&sr green:&sg blue:&sb alpha:&sa];
    [endColor getRed:&er green:&eg blue:&eb alpha:&ea];
    
    CGFloat components[8] = {sr,sg,sb,sa,er,eg,eb,ea};
    CGFloat locations[2] = {0.0,1.0};
    
    CGGradientRef gradient=CGGradientCreateWithColorComponents(colorSpace, components, locations, 2);
    //     NSArray *colors = @[(__bridge id) startColor, (__bridge id) endColor];
    //    CGGradientRef gradient = CGGradientCreateWithColors(colorSpace, (__bridge CFArrayRef) colors, locations);
    //渐变区域裁剪
    //    CGContextClipToRect(context, CGRectMake(0, 360, 200, 100));
    //    CGRect rect[5] = {CGRectMake(0, 0, 100, 100),CGRectMake(100, 100, 100, 100),CGRectMake(200, 0, 100, 100),CGRectMake(0, 200, 100, 100),CGRectMake(200, 200, 100, 100)};
    //    CGContextClipToRects(context, rect, 5);
    //绘制渐变
    CGContextDrawLinearGradient(context, gradient, CGPointMake(0.0, 0.0), CGPointMake(370, 0.0), kCGGradientDrawsAfterEndLocation);
    //释放对象
    CGColorSpaceRelease(colorSpace);
    CGGradientRelease(gradient);
}
/**
 颜色渐变型
 @param startColor <#startColor description#>
 @param endColor <#endColor description#>
 @return <#return value description#>
 */
+(UIImage *)addGradientImageStartColor:(UIColor *)startColor endColor:(UIColor *)endColor{
    
    //创建CGContextRef
    UIGraphicsBeginImageContext([UIScreen mainScreen].bounds.size);
    CGContextRef gc = UIGraphicsGetCurrentContext();
    
    //创建CGMutablePathRef
    CGMutablePathRef path = CGPathCreateMutable();
    
    //绘制Path
    CGRect rect = CGRectMake(0,0, 300, 200);
    CGPathCloseSubpath(path);
    CGContextSetFillColorWithColor(gc, [startColor CGColor]);
    
    CGContextFillRect(gc, rect);
    //绘制渐变
    //    [self.class drawLinearGradient:gc path:path startColor:startColor.CGColor endColor:endColor.CGColor];
    [self.class drawGradient:gc startColor:startColor endColor:endColor];
    
    //注意释放CGMutablePathRef
    CGPathRelease(path);
    
    //从Context中获取图像，并显示在界面上
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img ;
    
}
@end
