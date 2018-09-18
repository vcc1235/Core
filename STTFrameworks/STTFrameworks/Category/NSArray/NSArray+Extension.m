//
//  NSArray+Extension.m
//  STTFrameworks
//
//  Created by alete on 2018/7/26.
//  Copyright © 2018年 aletevcc. All rights reserved.
//

#import "NSArray+Extension.h"
#import "NSObject+Swizzling.h"

@implementation NSArray (Extension)
static char const *nameI = "__NSArrayI";
+(void)load{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [objc_getClass(nameI) methodSwizzlingWithOriginalSelector:@selector(objectAtIndex:) SwizzledSelector:@selector(swizzleObjectAtIndex:)];
    });
}

+(instancetype)arrayWithObjects:(id  _Nonnull const [])objects count:(NSUInteger)cnt{
    
    NSMutableArray *values = [[NSMutableArray alloc]init];
    for (int i= 0; i<cnt; i++) {
        id obj = objects[i];
        if (obj == nil || obj == NULL) {
            obj = @"" ;
        }
        [values addObject:obj];
    }
    // 用下面的方法构造
    return [self arrayWithArray:values];
}


- (id)swizzleObjectAtIndex:(NSUInteger)index
{
    if (index < self.count)
    {
        return [self swizzleObjectAtIndex:index];
    }
    NSLog(@"%@ 越界",self);
    return nil;//越界返回为nil
}



-(BOOL)isContainsByObject:(id)object{
    
    if (object == nil) {
        return NO ;
    }else if ([object isKindOfClass:NSString.class]){
        return [self filteredArrayUsingPredicate:[NSPredicate predicateWithBlock:^BOOL(NSString * _Nullable evaluatedObject, NSDictionary<NSString *,id> * _Nullable bindings) {
            if ([evaluatedObject isEqualToString:object]) {
                return YES ;
            }
            return NO;
        }]];
    }else if ([object isKindOfClass:NSNumber.class]){
        return [self filteredArrayUsingPredicate:[NSPredicate predicateWithBlock:^BOOL(NSNumber * _Nullable evaluatedObject, NSDictionary<NSString *,id> * _Nullable bindings) {
            if (evaluatedObject.boolValue == ((NSNumber *)object).doubleValue || evaluatedObject.integerValue == ((NSNumber *)object).integerValue) {
                return YES ;
            }
            return NO;
        }]];
    }else{
        return [self containsObject:object];
    }
}

@end

@implementation NSMutableArray (Empty)
static char const *name = "__NSArrayM";
+(void)load{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [objc_getClass(name) methodSwizzlingWithOriginalSelector:@selector(addObject:) SwizzledSelector:@selector(safeAddObject:)];
        [objc_getClass(name) methodSwizzlingWithOriginalSelector:@selector(removeObject:) SwizzledSelector:@selector(safeRemoveObject:)];
        [objc_getClass(name) methodSwizzlingWithOriginalSelector:@selector(removeObjectAtIndex:) SwizzledSelector:@selector(safeRemoveObjectAtIndex:)];
        [objc_getClass(name) methodSwizzlingWithOriginalSelector:@selector(insertObject:atIndex:) SwizzledSelector:@selector(safeInsertObject:atIndex:)];
        [objc_getClass(name) methodSwizzlingWithOriginalSelector:@selector(objectAtIndex:) SwizzledSelector:@selector(safeObjectAtIndex:)];
    });
}

- (void)safeAddObject:(id)obj {
    if (obj == nil) {
        NSLog(@"%s can add nil object into NSMutableArray", __FUNCTION__);
        return;
    }
    [self safeAddObject:obj];
}
- (void)safeRemoveObject:(id)obj {
    if (obj == nil) {
        NSLog(@"%s call -removeObject:, but argument obj is nil", __FUNCTION__);
        return;
    }
    [self safeRemoveObject:obj];
}
- (void)safeRemoveObjectAtIndex:(NSUInteger)index {
    if (self.count <= 0) {
        NSLog(@"%s can't get any object from an empty array", __FUNCTION__);
    } else if (index >= self.count) {
        NSLog(@"%s index out of bound", __FUNCTION__);
    } else {
        [self safeRemoveObjectAtIndex:index];
    }
}
- (void)safeInsertObject:(id)anObject atIndex:(NSUInteger)index {
    if (anObject == nil) {
        NSLog(@"%s can't insert nil into NSMutableArray", __FUNCTION__);
    } else if (index > self.count) {
        NSLog(@"%s: index is invalid", __FUNCTION__);
    } else {
        [self safeInsertObject:anObject atIndex:index];
    }
}
- (id)safeObjectAtIndex:(NSUInteger)index {
    if (self.count == 0) {
        NSLog(@"%s can't get any object from an empty array", __FUNCTION__);
        return nil;
    } else if (index > self.count  - 1) {
        // [__NSArrayM objectAtIndex:]: index 2 beyond bounds [0 .. 1]
        NSLog(@"%s: index %ld beyond bounds [0..%ld]", __FUNCTION__, index, self.count);
        return nil;
    } else {
        return [self safeObjectAtIndex:index];
    }
}

@end
