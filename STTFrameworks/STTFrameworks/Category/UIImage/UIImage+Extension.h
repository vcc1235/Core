//
//  UIImage+Extension.h
//  STTFrameworks
//
//  Created by alete on 2018/8/20.
//  Copyright © 2018年 aletevcc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Extension)

/**
 线性渐变色
 
 @param startColor <#startColor description#>
 @param endColor <#endColor description#>
 @return <#return value description#>
 */
+(UIImage *)addGradientImageStartColor:(UIColor *)startColor endColor:(UIColor *)endColor ;

@end
