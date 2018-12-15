//
//  UIColor+Extension.m
//  VCRBrowerImageView
//
//  Created by alete on 2017/7/9.
//  Copyright © 2017年 aletevcc. All rights reserved.
//

#import "UIColor+Extension.h"






@implementation UIColor (Extension)

UIColor *VCRColorMake(NSInteger red , NSInteger green , NSInteger blue ,CGFloat alpha){
    return [UIColor colorWithRed:red/255.0 green:green/255.0 blue:blue/255.0 alpha:alpha];
}



// 颜色转为16进制
-(NSString *)hexFromUIColor {
    
    UIColor *color = self ;
    if (CGColorGetNumberOfComponents(self.CGColor) < 4) {
        const CGFloat *components = CGColorGetComponents(self.CGColor);
        color = [UIColor colorWithRed:components[0] green:components[0] blue:components[0]alpha:components[1]];
    }
    if (CGColorSpaceGetModel(CGColorGetColorSpace(color.CGColor)) != kCGColorSpaceModelRGB) {
        return [NSString stringWithFormat:@"#FFFFFF"];
    }
    return [NSString stringWithFormat:@"%X%X%X", (int)((CGColorGetComponents(color.CGColor))[0]*255.0),
            (int)((CGColorGetComponents(color.CGColor))[1]*255.0),
            (int)((CGColorGetComponents(color.CGColor))[2]*255.0)];
    
}


+(UIColor *)colorWithHexString:(NSString *)hexString
{
    NSString *cString = [[hexString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];//字符串处理
    if ([cString hasPrefix:@"#"])
            cString = [cString substringFromIndex:1];//去掉头
    //例子，stringToConvert #ffffff
    if ([cString length] < 4)
        return [UIColor whiteColor];//如果非十六进制，返回白色
    //分别取RGB的值
    NSRange range;
    range.location = 0;
    range.length = 2;
    NSString *rString = [cString substringWithRange:range];
    
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    
    range.location = 4;
    NSString *bString ;
    if(cString.length>=6)
        bString = [cString substringWithRange:range];
    else
        bString = [cString substringFromIndex:range.location];
    unsigned int r, g, b;
    //NSScanner把扫描出的制定的字符串转换成Int类型
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    //转换为UIColor
    return [UIColor colorWithRed:((float) r / 255.0f)
                           green:((float) g / 255.0f)
                            blue:((float) b / 255.0f)
                           alpha:1.0f];
    
}





@end
