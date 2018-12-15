//
//  UIView+Extension.m
//  STTFrameworks
//
//  Created by alete on 2018/8/20.
//  Copyright © 2018年 aletevcc. All rights reserved.
//

#import "UIView+Extension.h"

@implementation UIView (Extension)

-(CGSize)size{
    return self.frame.size ;
}
-(void)setSize:(CGSize)size{
    CGRect rect = self.frame ;
    rect.size = size ;
    self.frame = rect ;
}
-(CGFloat)width{
    return self.frame.size.width ;
}
-(void)setWidth:(CGFloat)width{
    CGRect rect = self.frame ;
    rect.size.width = width ;
    self.frame = rect ;
}
-(CGFloat)height{
    return self.frame.size.height ;
}

-(void)setHeight:(CGFloat)height{
    CGRect frame = self.frame ;
    frame.size.height = height ;
    self.frame = frame ;
}

-(CGFloat)x{
    return self.frame.origin.x ;
}

-(void)setX:(CGFloat)x{
    
    CGRect frame = self.frame ;
    frame.origin.x = x ;
    self.frame = frame ;
    
}

-(CGFloat)y{
    return self.frame.origin.y ;
}

-(void)setY:(CGFloat)y{
    CGRect frame = self.frame ;
    frame.origin.y = y ;
    self.frame = frame ;
}

-(CGFloat)centerX{
    return self.center.x ;
}

-(void)setCenterX:(CGFloat)centerX{
    
    CGPoint center = self.center;
    center.x = centerX;
    self.center = center;
    
}


-(CGFloat)centerY{
    return self.center.y ;
}

-(void)setCenterY:(CGFloat)centerY{
    
    CGPoint center = self.center;
    center.y = centerY ;
    self.center = center;
    
}


-(CGFloat)right{
    
    return self.centerX+self.width ;
    
}

-(void)setRight:(CGFloat)right{
    
    CGRect frame = self.frame;
    frame.origin.x = right - frame.size.width;
    self.frame = frame;
    
}

- (CGFloat)bottom {
    return self.frame.origin.y + self.frame.size.height;
}

- (void)setBottom:(CGFloat)bottom {
    CGRect frame = self.frame;
    frame.origin.y = bottom - frame.size.height;
    self.frame = frame;
}



-(UIViewController *)viewController{
    for (UIView* next = [self superview]; next; next = next.superview) {
        UIResponder *nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)nextResponder;
        }
    }
    return nil;
}
@end
