//
//  UIView+Extension.h
//  STTFrameworks
//
//  Created by alete on 2018/8/20.
//  Copyright © 2018年 aletevcc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Extension)

@property (nonatomic, assign) CGSize size;

@property (nonatomic, assign) CGFloat width;

@property (nonatomic, assign) CGFloat height;

@property (nonatomic, assign) CGFloat x;

@property (nonatomic, assign) CGFloat y;

@property (nonatomic, assign) CGFloat centerX;

@property (nonatomic, assign) CGFloat centerY;

@property (nonatomic,assign) CGFloat right;       ///< Shortcut for frame.origin.x + frame.size.width
@property (nonatomic,assign) CGFloat bottom;      ///< Shortcut for frame.origin.y + frame.size.height

-(UIViewController *)viewController ;
@end
