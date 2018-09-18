//
//  UntilProtocol.m
//  DKLib
//
//  Created by alete on 2018/7/31.
//  Copyright © 2018年 aletevcc. All rights reserved.
//

#import "UntilProtocol.h"
#import <UIKit/UIKit.h>
#import "NSDictionary+Property.h"

@implementation NSObject (UntilProtocol)
+(NSString *)isScheme{
    return @"until";
}
+(void)getResquest:(NSURL *)url respone:(void (^)(id, NSError *))response{
    
    NSString *scheme = url.scheme ;
    if (![scheme isEqualToString:[self isScheme]]) {
//        NSAssert([scheme isEqualToString:@"game"],@"scheme is not game by %@",scheme);
        return ;
    }
    NSString *host = url.host ;
    NSString *path = url.path ;
    NSString *query = url.query ;
    if (host && host.length != 0) {
        Class target = NSClassFromString(host);
        NSObject *object = [[target alloc]init];
        NSArray *list = [self dictionaryByQuery:query];
        if (path && path.length != 0) {
            NSString *selector = [path stringByReplacingOccurrencesOfString:@"/" withString:@":"];
            selector = [selector substringFromIndex:1];
            if ([list count]!=0) {
                selector = [NSString stringWithFormat:@"%@:",selector];
            }
            NSLog(@"%@",selector);
            NSMethodSignature* methodSig;
            SEL action = NSSelectorFromString(selector);
            if ([object.class respondsToSelector:action]) {
                methodSig = [object.class methodSignatureForSelector:action];
            }
            else {
                methodSig = [object methodSignatureForSelector:action];
            }
            if(methodSig == nil) {
                selector = [NSString stringWithFormat:@"%@:",selector];
                action = NSSelectorFromString(selector);
                if ([object.class respondsToSelector:action]) {
                    methodSig = [object.class methodSignatureForSelector:action];
                }
                else {
                    methodSig = [object methodSignatureForSelector:action];
                }
                if (methodSig == nil) {
                    response?response(nil,[NSError errorWithDomain:NSURLErrorDomain code:500 userInfo:@{NSLocalizedDescriptionKey:@"no action"}]):@"";
                }else{
                    [self performTarget:object action:action pargam:list.firstObject respone:response];
                }
            }else{
                [self performTarget:object action:action pargam:list.firstObject respone:response];
            }
        }else{
            NSDictionary *params = list.lastObject ;
            if (![params isKindOfClass:[NSDictionary class]]) {
                params = nil ;
            }
            [params enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
                if ([key isKindOfClass:[NSString class]]) {
                    [object setObject:obj ForKey:key];
                }
            }];
            response?response(object,nil):@"";
        }
        
        
    }else{
        response?response(nil,[NSError errorWithDomain:NSURLErrorDomain code:500 userInfo:@{NSLocalizedDescriptionKey:@"no host"}]):@"";
    }
    
    
}
/** post 请求模式 **/
+(void)postResquest:(NSURL *)url params:(NSDictionary *)params respone:(void (^)(id, NSError *))response{
    
    NSString *scheme = url.scheme ;
    if (![scheme isEqualToString:[self isScheme]]) { // 检测
//        NSAssert([scheme isEqualToString:@"game"],@"scheme is not game by %@",scheme);
        return ;
    }
    NSString *host = url.host ;
    NSString *path = url.path ;
    NSString *query = url.query ;
    if (host && host.length != 0) {
        Class target = NSClassFromString(host) ;
        NSObject *object = [[target alloc]init];
        NSArray *list = [self dictionaryByQuery:query];
        if (path && path.length != 0) {
            NSString *selector = [path stringByReplacingOccurrencesOfString:@"/" withString:@":"];
            selector = [selector substringFromIndex:1];
            if ([params count]!=0) {
                selector = [NSString stringWithFormat:@"%@:",selector];
            }
            NSLog(@"%@",selector);
            NSMethodSignature* methodSig;
            SEL action = NSSelectorFromString(selector);
            if ([object.class respondsToSelector:action]) {
                methodSig = [object.class methodSignatureForSelector:action];
            }
            else {
                methodSig = [object methodSignatureForSelector:action];
            }
            if(methodSig == nil) {
                response?response(nil,[NSError errorWithDomain:NSURLErrorDomain code:500 userInfo:@{NSLocalizedDescriptionKey:@"no action"}]):@"";
            }else{
                [self performTarget:object action:action pargam:[list.firstObject arrayByAddingObjectsFromArray:params.allValues] respone:response];
            }
        }else{
            if (![params isKindOfClass:[NSDictionary class]]) {
                params = nil ;
            }
            [params enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
                if ([key isKindOfClass:[NSString class]]) {
                    [object setObject:obj ForKey:key];
                }
                
            }];
            response?response(object,nil):@"";
        }
    }else{
        response?response(nil,[NSError errorWithDomain:NSURLErrorDomain code:500 userInfo:@{NSLocalizedDescriptionKey:@"no host"}]):@"";
    }
}

+(id)getSyncRequest:(NSURL *)url{
    
    NSString *scheme = url.scheme ;
    if (![scheme isEqualToString:[self isScheme]]) {
        //        NSAssert([scheme isEqualToString:@"game"],@"scheme is not game by %@",scheme);
        return nil;
    }
    NSString *host = url.host ;
    NSString *path = url.path ;
    NSString *query = url.query ;
    if (host && host.length != 0) {
        Class target = NSClassFromString(host);
        NSObject *object = [[target alloc]init];
        NSArray *list = [self dictionaryByQuery:query];
        if (path && path.length != 0) {
            NSString *selector = [path stringByReplacingOccurrencesOfString:@"/" withString:@":"];
            selector = [selector substringFromIndex:1];
            if ([list count]!=0) {
                selector = [NSString stringWithFormat:@"%@:",selector];
            }
            NSLog(@"%@",selector);
            NSMethodSignature* methodSig;
            SEL action = NSSelectorFromString(selector);
            if ([object.class respondsToSelector:action]) {
                methodSig = [object.class methodSignatureForSelector:action];
            }
            else {
                methodSig = [object methodSignatureForSelector:action];
            }
            if(methodSig == nil) {
                selector = [NSString stringWithFormat:@"%@:",selector];
                action = NSSelectorFromString(selector);
                if ([object.class respondsToSelector:action]) {
                    methodSig = [object.class methodSignatureForSelector:action];
                }
                else {
                    methodSig = [object methodSignatureForSelector:action];
                }
                if (methodSig == nil) {
                    return [NSError errorWithDomain:NSURLErrorDomain code:500 userInfo:@{NSLocalizedDescriptionKey:@"no action"}];
                }else{
                    return [self performTarget:object action:action pargam:list.firstObject respone:nil];
                }
            }else{
                return [self performTarget:object action:action pargam:list.firstObject respone:nil];
            }
        }else{
            NSDictionary *params = list.lastObject ;
            if (![params isKindOfClass:[NSDictionary class]]) {
                params = nil ;
            }
            [params enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
                if ([key isKindOfClass:[NSString class]]) {
                    [object setObject:obj ForKey:key];
                }
            }];
            return object ;
        }
        
        
    }else{
         return [NSError errorWithDomain:NSURLErrorDomain code:500 userInfo:@{NSLocalizedDescriptionKey:@"no host"}];
    }
    
}

+(id)postSyncRequest:(NSURL *)url params:(NSDictionary *)params{
    
    NSString *scheme = url.scheme ;
    if (![scheme isEqualToString:[self isScheme]]) { // 检测
        //        NSAssert([scheme isEqualToString:@"game"],@"scheme is not game by %@",scheme);
        return nil;
    }
    NSString *host = url.host ;
    NSString *path = url.path ;
    NSString *query = url.query ;
    if (host && host.length != 0) {
        Class target = NSClassFromString(host) ;
        NSObject *object = [[target alloc]init];
        NSArray *list = [self dictionaryByQuery:query];
        if (path && path.length != 0) {
            NSString *selector = [path stringByReplacingOccurrencesOfString:@"/" withString:@":"];
            selector = [selector substringFromIndex:1];
            if ([params.allValues count]!=0) {
                selector = [NSString stringWithFormat:@"%@:",selector];
            }
            NSLog(@"%@",selector);
            NSMethodSignature* methodSig;
            SEL action = NSSelectorFromString(selector);
            if ([object.class respondsToSelector:action]) {
                methodSig = [object.class methodSignatureForSelector:action];
            }
            else {
                methodSig = [object methodSignatureForSelector:action];
            }
            if(methodSig == nil) {
                return [NSError errorWithDomain:NSURLErrorDomain code:500 userInfo:@{NSLocalizedDescriptionKey:@"no action"}];
            }else{
               return [self performTarget:object action:action pargam:[list.firstObject arrayByAddingObjectsFromArray:params.allValues] respone:nil];
            }
        }else{
            
            if (![params isKindOfClass:[NSDictionary class]]) {
                params = nil ;
            }
            [params enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
                if ([key isKindOfClass:[NSString class]]) {
                    [object setObject:obj ForKey:key];
                }
                
            }];
            return object ;
            
        }
    }else{
        return [NSError errorWithDomain:NSURLErrorDomain code:500 userInfo:@{NSLocalizedDescriptionKey:@"no host"}];
    }
    
}


+(NSArray *)dictionaryByQuery:(NSString *)query{
    if (query == nil) {
        return nil ;
    }
    NSArray *array = [query componentsSeparatedByString:@"&"];
    NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
    NSMutableArray *list = [[NSMutableArray alloc]init];
    for (NSString *key in array) {
        NSArray *value = [key componentsSeparatedByString:@"="];
        [list addObject:value.lastObject] ;
//        NSAssert(value.firstObject != nil, @"key is nil");
//        NSAssert(value.lastObject != nil, @"value is nil");
        [dict setObject:value.lastObject ForKey:value.firstObject];
    }
    return @[list,dict] ;
}
+(id)performTarget:(NSObject *)object action:(SEL)action pargam:(NSArray *)pargam respone:(void (^)(id, NSError *))response{
    
    NSMethodSignature* methodSig;
    // 优先调用类方法
    if ([object.class respondsToSelector:action]) {
        methodSig = [object.class methodSignatureForSelector:action];
    }
    else {
        methodSig = [object methodSignatureForSelector:action];
    }
    if(methodSig == nil) {
        response?response(nil,[NSError errorWithDomain:NSURLErrorDomain code:500 userInfo:@{NSLocalizedDescriptionKey:@"no action"}]):@"";
        return nil ;
    }
    
    // 获取invocation
    NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:methodSig];
    BOOL isResponse = YES ;
    // 入参
    for (NSInteger idx = 2; idx < methodSig.numberOfArguments; idx ++ ) {
        id obj = nil ;
        if ((idx-2)<pargam.count) {
            obj = pargam[idx - 2];
        }else{
            isResponse = NO ;
            [invocation setArgument:&response atIndex:idx];
            continue ;
        }
        // 类型判断，参数值校验传入
        if ([obj isKindOfClass:[NSNumber class]]) {
            
            // 由于传入的基础类型float cgfloat无法判断，所以用方法参数类型
            const char *type = [methodSig getArgumentTypeAtIndex:idx];
            
            NSNumber *number = (NSNumber *)obj;
            if (strcmp(type, @encode(CGFloat)) == 0) {
                CGFloat num = number.floatValue;
                [invocation setArgument:&num atIndex:idx];
            }
            else if (strcmp(type, @encode(NSInteger)) == 0) {
                NSInteger num = number.integerValue;
                [invocation setArgument:&num atIndex:idx];
            }
            else if (strcmp(type, @encode(NSUInteger)) == 0) {
                NSUInteger num = number.unsignedIntegerValue;
                [invocation setArgument:&num atIndex:idx];
            }
            else if (strcmp(type, @encode(float)) == 0) {
                CGFloat num = number.floatValue;
                [invocation setArgument:&num atIndex:idx];
            }
            else if (strcmp(type, @encode(double)) == 0) {
                double num = number.doubleValue;
                [invocation setArgument:&num atIndex:idx];
            }
            else if (strcmp(type, @encode(int)) == 0) {
                int num = number.intValue;
                [invocation setArgument:&num atIndex:idx];
            }
            else { // 就是NSNumber类型
                [invocation setArgument:&number atIndex:idx];
            }
        }
        else if ([obj isKindOfClass:[NSValue class]]) {
            
            NSValue *value = (NSValue *)obj;
            if (strcmp(value.objCType, @encode(CGSize)) == 0) {
                CGSize size = value.CGSizeValue;
                [invocation setArgument:&size atIndex:idx];
            }
            else if (strcmp(value.objCType, @encode(CGRect)) == 0) {
                CGRect rect = value.CGRectValue;
                [invocation setArgument:&rect atIndex:idx];
            }
            else if (strcmp(value.objCType, @encode(NSRange)) == 0) {
                NSRange range = value.rangeValue;
                [invocation setArgument:&range atIndex:idx];
            }
            else if (strcmp(value.objCType, @encode(CGPoint)) == 0) {
                CGPoint point = value.CGPointValue;
                [invocation setArgument:&point atIndex:idx];
            }
        }
        else {
            [invocation setArgument:&obj atIndex:idx];
        }
    }
    
    [invocation setSelector:action];
    if ([object.class respondsToSelector:action]) {
        [invocation setTarget:object.class];
    }
    else {
        [invocation setTarget:object];
    }
    [invocation invoke];
    
    // 处理返回值
    const char* retType = [methodSig methodReturnType];
    
    if (strcmp(retType, @encode(void)) == 0) {
        (isResponse && response)?response(nil,nil):@"";
        return @"" ;
    }
    else if (strcmp(retType, @encode(NSInteger)) == 0) {
        NSInteger result = 0;
        [invocation getReturnValue:&result];
        (isResponse && response)?response(@(result),nil):@"";
        return @(result);
    }
    else if (strcmp(retType, @encode(BOOL)) == 0) {
        BOOL result = 0;
        [invocation getReturnValue:&result];
        (isResponse && response)?response(@(result),nil):@"";
        return @(result);
    }
    else if (strcmp(retType, @encode(CGFloat)) == 0) {
        CGFloat result = 0;
        [invocation getReturnValue:&result];
        (isResponse && response)?response(@(result),nil):@"";
        return @(result);
    }
    else if (strcmp(retType, @encode(NSUInteger)) == 0) {
        NSUInteger result = 0;
        [invocation getReturnValue:&result];
        (isResponse && response)?response(@(result),nil):@"";
        return @(result);
    }
    
    void *result = nil;
    [invocation getReturnValue:&result];
    (isResponse && response)?response((__bridge id)result,nil):@"";
    return (__bridge id)result ;
    
}


@end
