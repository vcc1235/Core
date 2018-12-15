//
//  NSObject+Extension.m
//  秀VV
//
//  Created by vcc on 17/5/11.
//  Copyright © 2017年 vcc. All rights reserved.
//

#import "NSObject+Extension.h"
#import <objc/runtime.h>

@implementation NSObject (Extension)

-(void)getMainFunc:(void(^)())block
{
    dispatch_async(dispatch_get_main_queue(), ^{
        block() ;
    });
}


-(void)setExtraCellLineHidden: (UITableView *)tableView
{
    
    UIView *view = [UIView new];
    
    view.backgroundColor = [UIColor clearColor];
    
    [tableView setTableFooterView:view];
    
}




-(NSString *)stringAppend:(NSString *)string, ...{
    
    NSMutableString *mutableString = [[NSMutableString alloc]initWithString:string];
    
    va_list argument ;
    
    va_start(argument, string);
    
    NSString *arg ;
    
    while ((arg = va_arg(argument, NSString *))) {
        [mutableString appendString:arg];
    }
    
    va_end(argument);
    
    return mutableString ;
    
}




-(void)dispatchTimer:(NSInteger)time andSuccess:(void (^)(NSInteger))block andProgress:(void (^)(NSInteger))progress
{
    [self dispatchTimer:time second:1.0 andSuccess:block andProgress:progress];
}

-(void)dispatchTimer:(NSInteger)time second:(CGFloat)second andSuccess:(void (^)(NSInteger))block andProgress:(void (^)(NSInteger))progress {
    
    __block NSInteger timeint = time ;
    dispatch_queue_t queue = dispatch_queue_create(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _time = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    dispatch_source_set_timer(_time, dispatch_walltime(NULL, 0), second*NSEC_PER_SEC, 0);
    dispatch_source_set_event_handler(_time, ^{
        
        if (timeint<=0) {
            dispatch_source_cancel(_time);
            block(timeint);
        }else
        {
            progress(timeint);
            timeint-- ;
        }
        
    });
    dispatch_resume(_time);
    
}

+(UIViewController *)perforTarget:(NSString *)targetName WithObject:(NSDictionary *)params{
    
    Class targetClass = NSClassFromString(targetName);
    id target = [[targetClass alloc]init];
    
    if(target == nil)
        return nil ;
    
    if(!params || ![params isKindOfClass:[NSDictionary class]] || ![params count])
        return target ;
    
    for (NSString *key in [params allKeys]) {
        
        id value = [params valueForKey:key];
        
        objc_setAssociatedObject(target, (__bridge const void * _Nonnull)(key), value,OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        
    }
    
    return target ;
    
}


//URL vcc://target/action?u=1&n=2
+(UIViewController *)perforUrl:(NSURL *)url completion:(void(^)(NSDictionary *dic))completion{
    
    if(![url.scheme isEqualToString:@"VCR"]){
        return nil ;
    }
    NSMutableDictionary *dictionary = [[NSMutableDictionary alloc]init];
    NSString *urlString = [url query];
    
    NSString *actionName = [NSString stringWithFormat:@"%@",[url.path stringByReplacingOccurrencesOfString:@"/" withString:@""]];
    NSString *targetName = url.host ;
    
    Class targetClass = NSClassFromString(targetName);
    
    id target = [[targetClass alloc]init];
    SEL action = NSSelectorFromString(actionName);
    
    if(!target) return nil ;
    
    if(!urlString){
        if([target respondsToSelector:action]){
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
            [target performSelector:action withObject:nil];
#pragma clang diagnostic pop
        }
    }else{
        
        actionName = [NSString stringWithFormat:@"%@:",actionName];
        action = NSSelectorFromString(actionName);
        NSAssert(actionName, @"urlString is nil");
        NSArray *array = [urlString componentsSeparatedByString:@"&"];
        for (NSString *params in array) {
            
            NSArray *pargm = [params componentsSeparatedByString:@"="];
            if(pargm.count!=2){
                return nil ;
            }
            [dictionary setObject:pargm.lastObject forKey:pargm.firstObject];
            
        }
    }
    
    
    if([target respondsToSelector:action]){
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
        [target performSelector:action withObject:dictionary];
#pragma clang diagnostic pop
    }
    
    return target ;
    
}





@end
