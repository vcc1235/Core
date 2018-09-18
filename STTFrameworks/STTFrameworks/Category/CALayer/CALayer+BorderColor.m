//
//  CALayer+BorderColor.m
//  AiXiaoPing
//
//  Created by ZSY on 2018/1/3.
//  Copyright © 2018年 ZSY. All rights reserved.
//

#import "CALayer+BorderColor.h"

@implementation CALayer (BorderColor)

- (void)setBorderUIColor:(UIColor *)borderColor {
    
    [self setBorderColor:borderColor.CGColor];
}

-(void)showderRedius:(CGFloat)redius offset:(CGSize)size opacity:(CGFloat)opacity color:(UIColor *)color{
    
    self.shadowRadius = redius ;
    self.shadowOffset = size ;
    self.shadowOpacity = opacity ;
    self.shadowColor = color.CGColor ;
}

/*
 *  摇动
 */
-(void)shake{
    
    CAKeyframeAnimation *kfa = [CAKeyframeAnimation animationWithKeyPath:@"transform.translation.x"];
    
    CGFloat s = 5;
    
    kfa.values = @[@(-s),@(0),@(s),@(0),@(-s),@(0),@(s),@(0)];
    
    //时长
    kfa.duration = 0.3f;
    
    //重复
    kfa.repeatCount = 2;
    
    //移除
    kfa.removedOnCompletion = YES;
    
    [self addAnimation:kfa forKey:@"shake"];
}
@end
