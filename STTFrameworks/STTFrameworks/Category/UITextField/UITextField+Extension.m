//
//  UITextField+Extension.m
//  Proker
//
//  Created by alete on 2018/5/22.
//  Copyright © 2018年 aletevcc. All rights reserved.
//

#import "UITextField+Extension.h"
#import "NSString+Extension.h"

@implementation UITextField (Extension)

-(void)placeHoldTextFont:(UIFont *)font TextColor:(UIColor *)color Text:(NSString *)placeHold{
    
    if (!placeHold) {
        placeHold = self.placeholder ;
    }
    NSMutableAttributedString *mutableAttributeString = [[NSMutableAttributedString alloc]initWithString:placeHold];
    if (font) {
        [mutableAttributeString addAttribute:NSFontAttributeName value:font range:[placeHold rangeOfString:placeHold]];
    }
    if (color) {
        [mutableAttributeString addAttribute:NSForegroundColorAttributeName value:color range:[placeHold rangeOfString:placeHold]];
    }
    self.attributedPlaceholder = mutableAttributeString ;
    
}

-(NSString *)trimText{
    
    if (![self hasText]) {
        return @"" ;
    }else if (!self.text.trim.length){
        return @"";
    }else{
        return self.text.trim ;
    }
}

@end
