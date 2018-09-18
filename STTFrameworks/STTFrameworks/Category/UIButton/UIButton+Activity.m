//
//  UIButton+Activity.m
//  Common
//
//  Created by alete on 2018/7/13.
//  Copyright © 2018年 Lyra. All rights reserved.
//

#import "UIButton+Activity.h"
#import <objc/runtime.h>
#import <Masonry/Masonry.h>

@implementation UIButton (Activity)

-(UIActivityIndicatorView *)activityIndicatorView{
    
    UIActivityIndicatorView *activityView = objc_getAssociatedObject(self, @"activityIndicatorView");
    if (activityView) {
        return activityView ;
    }
    activityView = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    [self willChangeValueForKey:@"activityIndicatorView"];
    objc_setAssociatedObject(self, @"activityIndicatorView", activityView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self didChangeValueForKey:@"activityIndicatorView"];
    return activityView ;
}
-(void)setActivitStyle:(UIActivityIndicatorViewStyle)style{
    [[self activityIndicatorView]setActivityIndicatorViewStyle:style];
}
-(NSString *)getString{
    return objc_getAssociatedObject(self, @"string");
}
-(void)setString:(NSString *)string{
    
    [self willChangeValueForKey:@"string"];
    objc_setAssociatedObject(self, @"string", string, OBJC_ASSOCIATION_COPY_NONATOMIC);
    [self didChangeValueForKey:@"string"];
}

-(UIImage *)getImage{
    return objc_getAssociatedObject(self, @"getImage");
}
-(void)setImage:(UIImage *)image{
    
    [self willChangeValueForKey:@"getImage"];
    objc_setAssociatedObject(self, @"getImage", image, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self didChangeValueForKey:@"getImage"];
}

//-(NSString *)getString{
//    return objc_getAssociatedObject(self, @"string");
//}
//-(void)setString:(NSString *)string{
//    
//    [self willChangeValueForKey:@"string"];
//    objc_setAssociatedObject(self, @"string", string, OBJC_ASSOCIATION_COPY_NONATOMIC);
//    [self didChangeValueForKey:@"string"];
//}


-(void)show{
    
    if ([self activityIndicatorView].isAnimating) {
        return ;
    }
    [self setString:self.currentTitle];
    [self setImage:self.currentBackgroundImage];
//    [self setBackgroundImage:UIImage.new forState:UIControlStateNormal];
//    [self setTitle:@"" forState:UIControlStateNormal];
//    [self setImage:UIImage.new forState:UIControlStateNormal];
    self.hidden = YES ;
//    [self activityIndicatorView].frame = CGRectMake((self.frame.origin.x+self.frame.size.width-20)/2.0,(self.frame.origin.y+self.frame.size.height-20)/2.0,20, 20);
    [self.superview addSubview: [self activityIndicatorView]];
    [[self activityIndicatorView]startAnimating];
    [[self activityIndicatorView]mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self);
    }];

}

-(void)hide{
    
    self.hidden = NO ;
//    [self setBackgroundImage:self.getImage forState:UIControlStateNormal];
//    [self setTitle:self.getString forState:UIControlStateNormal];
//    [self setImage:UIImage.new forState:UIControlStateNormal];
    [[self activityIndicatorView]stopAnimating];
    
}


@end
