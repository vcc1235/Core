//
//  UIColor+Extension.h
//  VCRBrowerImageView
//
//  Created by alete on 2017/7/9.
//  Copyright © 2017年 aletevcc. All rights reserved.
//

#import <UIKit/UIKit.h>




@interface UIColor (Extension) 

UIColor *VCRColorMake(NSInteger red , NSInteger green , NSInteger blue ,CGFloat alpha) ;


/**
 颜色转为16进制

 @return <#return value description#>
 */
-(NSString *)hexFromUIColor ;


/**
 十六进制 转 颜色

 @param hexString <#hexString description#>
 @return <#return value description#>
 */
+(UIColor *)colorWithHexString:(NSString *)hexString ;


@end
