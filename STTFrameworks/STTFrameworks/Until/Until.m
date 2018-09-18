//
//  Until.m
//  DKLib
//
//  Created by alete on 2018/7/23.
//  Copyright © 2018年 aletevcc. All rights reserved.
//

#import "Until.h"
#import <UIKit/UIKit.h>
#import <NSDictionary+Property.h>

@interface Until ()

@property (nonatomic, strong) NSMutableDictionary *untilScheme ;

@end

@implementation Until

+(instancetype)shareInstance{
    static Until *__Instance = nil ;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        __Instance = [[Until alloc]init];
    });
    return __Instance ;
}
-(NSMutableDictionary *)untilScheme{
    if (!_untilScheme) {
        _untilScheme = [[NSMutableDictionary alloc]init];
    }
    return _untilScheme ;
}

-(void)addUntil:(Class)target ForScheme:(NSString *)scheme{
    
    NSAssert(target != nil, @"add until target is nil");
    [self.untilScheme setObject:target forKey:scheme];
    
}


-(void)getResquest:(NSURL *)url respone:(void (^)(id, NSError *))response{
    
    NSString *scheme = url.scheme ;
    Class<UntilProtocol> target = [self.untilScheme objectForKey:scheme];
    NSAssert(target != nil, @"get Request target is nil By scheme = %@",scheme);
#ifdef DEBUG
    NSLog(@"start request scheme = %@",scheme);
#endif
    [target getResquest:url respone:response];
    
}
-(void)postResquest:(NSURL *)url params:(NSDictionary *)params respone:(void (^)(id, NSError *))response{
    
    NSString *scheme = url.scheme ;
    Class<UntilProtocol> target = [self.untilScheme objectForKey:scheme];
    NSAssert(target != nil, @"get Request target is nil By scheme = %@",scheme);
#ifdef DEBUG
    NSLog(@"start request scheme = %@",scheme);
#endif
    [target postResquest:url params:params respone:response];
}


-(id)getSyncRequest:(NSURL *)url{
    
    NSString *scheme = url.scheme ;
    Class<UntilProtocol> target = [self.untilScheme objectForKey:scheme];
    NSAssert(target != nil, @"get Request target is nil By scheme = %@",scheme);
#ifdef DEBUG
    NSLog(@"start request scheme = %@",scheme);
#endif
    return [target getSyncRequest:url];
}
-(id)postSyncRequest:(NSURL *)url params:(NSDictionary *)params{
    
    NSString *scheme = url.scheme ;
    Class<UntilProtocol> target = [self.untilScheme objectForKey:scheme];
    NSAssert(target != nil, @"get Request target is nil By scheme = %@",scheme);
#ifdef DEBUG
    NSLog(@"start request scheme = %@",scheme);
#endif
    return [target postSyncRequest:url params:params];
    
}
/**
 本地组件(控制器)切换
 @param source 调用者
 @param targetName targetName
 @param params params
 @param transition transition
 @return target object
 */
+(id)transitionWithSource:(id)source Target:(NSString *)targetName Params:(NSDictionary *)params TransitionMode:(RMTransition)transition {
    
    NSObject *target;
    if (NSClassFromString(targetName)) {
        target = [[NSClassFromString(targetName) class] new];
    }else if(NSClassFromString([NSString stringWithFormat:@"CatchChain.%@",targetName])){
        target = [[NSClassFromString([NSString stringWithFormat:@"CatchChain.%@",targetName]) class]new];
    }
    
    if (target == nil) {
        // 处理无响应请求的地方之一。
        // 可以事先给一个固定的target专门用于在这个时候顶上，然后处理这种请求
        return nil;
    }
    
    if (![target isKindOfClass:[UIViewController class]]) {
        return nil;
    }
    
    UIViewController *sourceVC;
    if ([source isKindOfClass:[UIViewController class]]) {
        sourceVC = (UIViewController *)source;
    }
    else {
        sourceVC = [UIApplication sharedApplication].keyWindow.rootViewController;
    }
    UIViewController *targetVC = (UIViewController *)target;
    
    [params enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        if ([key isKindOfClass:[NSString class]]) {
            [target setObject:obj ForKey:key];
        }
    }];
    
    switch (transition) {
        case RMTransitionPush:
        {
            if (!sourceVC.navigationController) {
                return target;
            }
            if ([sourceVC.navigationController.viewControllers count]==1) {
                targetVC.hidesBottomBarWhenPushed = YES;
            }
            [sourceVC.navigationController pushViewController:targetVC animated:true];
            
        }break;
        case RMTransitionPresent:
        {
            [sourceVC presentViewController:targetVC animated:true completion:nil];
            
        }break;
        case RMTRansitionNAVPresent:
        {
            UINavigationController *navigationController = [[UINavigationController alloc]initWithRootViewController:targetVC];
            [sourceVC presentViewController:navigationController animated:YES completion:nil];
        }break ;
        case RMTransitionNone:
        {
            return target;
            break;
        }
    }
    
    return target;
}


@end
