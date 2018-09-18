//
//  NSDictionary+Property.m
//  DKLib
//
//  Created by alete on 2018/7/31.
//  Copyright © 2018年 aletevcc. All rights reserved.
//

#import "NSDictionary+Property.h"
#import <objc/runtime.h>

@implementation NSDictionary (Property)
-(NSDictionary *)addDictionary:(NSDictionary *)dict{
    NSMutableDictionary *dictionary = [NSMutableDictionary dictionaryWithDictionary:self];
    [dictionary addEntriesFromDictionary:dict];
    return dictionary ;
}
@end

@implementation NSObject (Until)
-(id)getObjectForKey:(NSString *)key{
    if (![key isKindOfClass:[NSString class]]) {
        return nil;
    }
    NSDictionary *dict = [self paragm];
    return dict[key];
}
-(void)setObject:(id)object ForKey:(NSString *)key{
    if (![key isKindOfClass:[NSString class]]) {
        object = @"" ;
    }
    NSDictionary *dict = [self paragm];
    [self setParagm:[dict addDictionary:@{key:object}]];
}
-(NSDictionary *)paragm{
    NSDictionary *dict = objc_getAssociatedObject(self, @"Until_game_pargam");
    if (dict == nil) {
        return [NSDictionary dictionary];
    }
    return dict ;
}
-(void)setParagm:(NSDictionary *)paragm{
    objc_setAssociatedObject(self, @"Until_game_pargam",paragm, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
@end

