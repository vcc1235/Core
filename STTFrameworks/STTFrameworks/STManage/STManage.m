//
//  STManage.m
//  STTFrameworks
//
//  Created by alete on 2018/7/26.
//  Copyright © 2018年 aletevcc. All rights reserved.
//

#import "STManage.h"
#import "NSBundle+Language.h"
#import <objc/runtime.h>

@interface STManage ()
{
    @private
    NSMutableDictionary *__datalist ;
}
@property (nonatomic, strong) NSBundle *bundle ;


@end

@implementation STManage
- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

+(instancetype)shareInstance{
    
    static STManage *__shareInstance = nil ;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        __shareInstance = [[STManage alloc]init];
        NSData *data = [NSUserDefaults.standardUserDefaults objectForKey:@"STManager.datalist"];
        __shareInstance->__datalist = [NSKeyedUnarchiver unarchiveObjectWithData:data];
        if ([__shareInstance->__datalist isKindOfClass:[NSDictionary class]]) {
            __shareInstance->__datalist = [NSMutableDictionary dictionaryWithDictionary:__shareInstance->__datalist];
        }
        if (__shareInstance->__datalist == nil) {
            __shareInstance->__datalist = NSMutableDictionary.alloc.init ;
        }
    });
    return __shareInstance ;

}


@end



@implementation STManage (CoreData)
+(BOOL)isKindOfClassWithValue:(NSObject *)value{
    if ([value isKindOfClass:NSString.class]) {
        return true ;
    }else if ([value isKindOfClass:NSNumber.class]){
        return true ;
    }else if ([value isKindOfClass:NSData.class]){
        return true ;
    }else if ([value isKindOfClass:NSDate.class]){
        return true ;
    }else{
        return false ;
    }
}
-(NSDictionary *)dictionaryRepresentation:(NSObject *)object {
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    unsigned int count;
    objc_property_t *propertyList = class_copyPropertyList([object class], &count);
    
    for (int i = 0; i < count; i++) {
        objc_property_t property = propertyList[i];
        const char *cName = property_getName(property);
        NSString *name = [NSString stringWithUTF8String:cName];
        NSObject *value = [object valueForKey:name];
        NSMutableDictionary *keyName = [NSMutableDictionary dictionaryWithDictionary:@{@"ID":@"id",@"Namespace":@"namespace",@"descriptions":@"description"}];
        name = keyName[name] != nil ? keyName[name] : name;
        if ([self.class isKindOfClassWithValue:value]) {
            [dic setObject:value forKey:name];
        } else if ([value isKindOfClass:[NSArray class]] || [value isKindOfClass:[NSDictionary class]]) {
            [dic setObject:[self arrayOrDicWithObject:value] forKey:name];
        } else if (value == nil) {
        } else if(![name isEqualToString:@"superclass"]){
            [dic setObject:[self dictionaryRepresentation:value] forKey:name];
        }
    }
    return [dic copy];
}
- (id)arrayOrDicWithObject:(id)origin {
    if ([origin isKindOfClass:[NSArray class]]) {
        NSMutableArray *array = [NSMutableArray array];
        for (NSObject *object in origin) {
            if ([self.class isKindOfClassWithValue:object]) {
                [array addObject:object];
            } else if ([object isKindOfClass:[NSArray class]] || [object isKindOfClass:[NSDictionary class]]) {
                [array addObject:[self arrayOrDicWithObject:object]];
            } else {
                [array addObject:[self dictionaryRepresentation:object]];
            }
        }
        return [array copy];
    } else if ([origin isKindOfClass:[NSDictionary class]]) {
        NSDictionary *originDic = (NSDictionary *)origin;
        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        for (NSString *key in originDic.allKeys) {
            id object = [originDic objectForKey:key];
            if ([self.class isKindOfClassWithValue:object]) {
                [dic setObject:object forKey:key];
            } else if ([object isKindOfClass:[NSArray class]] || [object isKindOfClass:[NSDictionary class]]) {
                [dic setObject:[self arrayOrDicWithObject:object] forKey:key];
            } else {
                [dic setObject:[self dictionaryRepresentation:object] forKey:key];
            }
        }
        return [dic copy];
    }
    return [NSNull null];
}

-(id)getObjectForKey:(NSString *)key{
    return [__datalist objectForKey:key];
}

-(void)removeObjectForKey:(NSString *)key{
    [__datalist removeObjectForKey:key];
}

-(void)setObject:(id)object forKey:(NSString *)key{
    
    if (object == nil) {
        return ;
    }
    if ([object isKindOfClass:NSString.class]) {
        [__datalist setObject:object forKey:key];
    }else if ([object isKindOfClass:NSArray.class]){
        [__datalist setObject:object forKey:key];
    }else if ([object isKindOfClass:NSDictionary.class]){
        [__datalist setObject:object forKey:key];
    }else if ([object isKindOfClass:NSDate.class]){
        [__datalist setObject:object forKey:key];
    }else if ([object isKindOfClass:NSNumber.class]){
        [__datalist setObject:object forKey:key];
    }else if ([object isKindOfClass:NSData.class]){
        [__datalist setObject:object forKey:key];
    }else if ([object isKindOfClass:NSValue.class]){
        [__datalist setObject:object forKey:key];
    }else if ([object isKindOfClass:NSSet.class]){
        [__datalist setObject:object forKey:key];
    }else if ([object isKindOfClass:NSURL.class]){
        [__datalist setObject:object forKey:key];
    }else if ([object isKindOfClass:NSObject.class]){
        NSDictionary *json = [self dictionaryRepresentation:object];
        [__datalist setObject:json forKey:key];
    }else{
        return ;
    }
}
-(void)presist{
    
    NSDictionary *dictionary = [__datalist copy];
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:dictionary];
    [NSUserDefaults.standardUserDefaults setObject:data forKey:@"STManager.datalist"];
    
}
@end












































































@implementation STManage (NSBundle)
-(NSBundle *)bundle{
    if (!_bundle) {
        _bundle = [[NSBundle alloc]init];
        [_bundle addBundleByIdentifiers:NSBundle.mainBundle.bundleIdentifier andBundle:@"STResource" type:2];
    }
    return _bundle ;
}
-(void)addBundleByIdentifiers:(NSString *)identifier andBundle:(NSString *)bundle type:(NSInteger)type{
    [self.bundle addBundleByIdentifiers:identifier andBundle:bundle type:type];
}
-(void)setLanguage:(NSString *)language{
    [self.bundle setLanguage:language];
}
-(NSString *)currentLanguage{
    return self.bundle.currentLanguage ;
}
@end
