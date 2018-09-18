//
//  UIView+Extension.m
//  STTFrameworks
//
//  Created by alete on 2018/8/20.
//  Copyright © 2018年 aletevcc. All rights reserved.
//

#import "UIView+Extension.h"

@implementation UIView (Extension)
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
