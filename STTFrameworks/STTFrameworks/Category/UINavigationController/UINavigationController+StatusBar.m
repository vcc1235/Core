//
//  UINavigationController+StatusBar.m
//  STTFrameworks
//
//  Created by alete on 2018/8/20.
//  Copyright © 2018年 aletevcc. All rights reserved.
//

#import "UINavigationController+StatusBar.h"

@implementation UINavigationController (StatusBar)
-(UIViewController *)childViewControllerForStatusBarStyle{
    return self.visibleViewController ;
}
@end
