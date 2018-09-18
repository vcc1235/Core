//
//  NSObject+Hash.m
//  DKLib
//
//  Created by alete on 2018/7/25.
//  Copyright © 2018年 aletevcc. All rights reserved.
//

#import "NSDictionary+Hash.h"
#import "NSObject+Swizzling.h"
#import <objc/runtime.h>


@implementation NSDictionary (Hash)
@dynamic list ;
//static char const *nameI = "__NSSingleEntryDictionaryI";
+(void)load{
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [NSDictionary.class methodSwizzlingWithOriginalSelector:@selector(allValues) SwizzledSelector:@selector(allObjects)];
//        [objc_getClass(name) methodSwizzlingWithOriginalSelector:@selector(removeObject:) SwizzledSelector:@selector(safeRemoveObject:)];
//        [objc_getClass(name) methodSwizzlingWithOriginalSelector:@selector(removeObjectAtIndex:) SwizzledSelector:@selector(safeRemoveObjectAtIndex:)];
//        [objc_getClass(name) methodSwizzlingWithOriginalSelector:@selector(insertObject:atIndex:) SwizzledSelector:@selector(safeInsertObject:atIndex:)];
//        [objc_getClass(name) methodSwizzlingWithOriginalSelector:@selector(objectAtIndex:) SwizzledSelector:@selector(safeObjectAtIndex:)];
    });
    
}


+(instancetype)dictionaryWithObjects:(id  _Nonnull const [])objects forKeys:(id<NSCopying>  _Nonnull const [])keys count:(NSUInteger)cnt{
    
    NSMutableArray *values = [[NSMutableArray alloc]init];
    NSMutableArray *key = [[NSMutableArray alloc]init];
    for (NSUInteger i = 0; i < cnt; i ++) {
        if (objects[i] && keys[i])
        {
            [key addObject:keys[i]];
            [values addObject:objects[i]];
        }
    }
    // 用下面的方法构造
    NSDictionary *dictionary =  [self dictionaryWithObjects:values forKeys:key];
    dictionary.list = key.copy ;
    return dictionary ;
    
}

-(void)setList:(NSArray *)list{
    
    [self willChangeValueForKey:@"list"];
    objc_setAssociatedObject(self, @"list", list, OBJC_ASSOCIATION_COPY_NONATOMIC);
    [self didChangeValueForKey:@"list"];
}
-(NSArray *)list{
    return objc_getAssociatedObject(self, @"list");
}

-(NSArray *)allObjects{
    
    if ([self.list count]==0) {
        return self.allObjects ;
    }
    NSMutableArray *array = [[NSMutableArray alloc]init];
    for (NSString *key in self.list) {
        id value = [self objectForKey:key];
        [array addObject:value];
    }
    return array ;
    
}

//+(instancetype)dictionaryWithObjectsAndKeys:(id)firstObject, ...{
//
//    NSMutableArray *value
//
//    va_list argument ;
//
//    va_start(argument, string);
//
//    NSString *arg ;
//
//    while ((arg = va_arg(argument, NSString *))) {
//        [mutableString appendString:arg];
//    }
//
//    va_end(argument);
//
//    return mutableString ;
//
//}



@end


@implementation NSMutableDictionary (Hash)
+(void)load{
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [NSMutableDictionary.class methodSwizzlingWithOriginalSelector:@selector(setObject:forKey:) SwizzledSelector:@selector(setVCRObject:forVCRKey:)];
        [NSMutableDictionary.class methodSwizzlingWithOriginalSelector:@selector(setValue:forKey:) SwizzledSelector:@selector(setVCRValue:forVCRKey:)];
        //        [objc_getClass(name) methodSwizzlingWithOriginalSelector:@selector(removeObjectAtIndex:) SwizzledSelector:@selector(safeRemoveObjectAtIndex:)];
        //        [objc_getClass(name) methodSwizzlingWithOriginalSelector:@selector(insertObject:atIndex:) SwizzledSelector:@selector(safeInsertObject:atIndex:)];
        //        [objc_getClass(name) methodSwizzlingWithOriginalSelector:@selector(objectAtIndex:) SwizzledSelector:@selector(safeObjectAtIndex:)];
    });
    
}
-(void)setVCRObject:(id)object forVCRKey:(id<NSCopying>)key{
    
    if (object == nil) {
        object = @"";
    }
    [self setVCRObject:object forVCRKey:key];
    
}
-(void)setVCRValue:(id)value forVCRKey:(NSString *)key{
    if (value == nil) {
        value = @"" ;
    }
    [self setVCRValue:value forVCRKey:key];
}


@end
