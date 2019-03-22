//
//  NSBundle+Language.m
//  STTFrameworks
//
//  Created by alete on 2018/7/26.
//  Copyright © 2018年 aletevcc. All rights reserved.
//

#import "NSBundle+Language.h"
#import <objc/runtime.h>

static const char *_bundlekey = "_bundle_key";
@interface Language : NSBundle

@end

@implementation Language
-(NSString *)localizedStringForKey:(NSString *)key value:(NSString *)value table:(NSString *)tableName {
    NSBundle *bundle = objc_getAssociatedObject(self, &_bundlekey);
    return bundle ? [bundle localizedStringForKey:key value:value table:tableName] : [super localizedStringForKey:key value:value table:tableName];
}
@end

@implementation NSBundle (Language)
-(NSArray<NSDictionary *> *)identifiers{
    return objc_getAssociatedObject(self, @"BundleIdentifier");
}
-(void)setIdentifiers:(NSArray<NSDictionary *> *)Identifiers{
    [self willChangeValueForKey:@"BundleIdentifier"];
    objc_setAssociatedObject(self, @"BundleIdentifier", Identifiers, OBJC_ASSOCIATION_COPY_NONATOMIC);
    [self didChangeValueForKey:@"BundleIdentifier"];
}
-(BOOL)containsIdentifiers:(NSArray *)identifiers withObject:(NSString *)identifer{
    for (NSDictionary *obj in identifiers) {
        if ([obj[@"identifier"] isEqualToString:identifer]) {
            return YES ;
        }
    }
    return NO ;
}
#pragma mark - 语言设置处理 -
-(void)addBundleByIdentifiers:(NSString *)identifier andBundle:(NSString *)resourceName type:(NSInteger)type{
    if (self.identifiers == nil) {
        NSBundle *bundle = [NSBundle bundleWithIdentifier:identifier];
        if (bundle) {
            self.identifiers = @[@{@"identifier":identifier,@"bundle":resourceName,@"type":@(type)}];
        }else{
            self.identifiers = @[@{@"identifier":identifier}];
        }
        object_setClass(bundle, [Language class]);
    }else{
         if (![self containsIdentifiers:self.identifiers withObject:identifier]) {
             NSBundle *bundle = [NSBundle bundleWithIdentifier:identifier];
             NSDictionary *dict ;
             if (identifier) {
                 dict = @{@"identifier":identifier,@"bundle":resourceName,@"type":@(type)};
             }else{
                 dict = @{@"identifier":identifier};
             }
             self.identifiers = [self.identifiers arrayByAddingObject:dict];
             object_setClass(bundle, [Language class]);
         }
    }
}
-(void)setLanguage:(NSString *)language{
    
    // 然后将设置好的语言存储好，下次进来直接加载
    [[NSUserDefaults standardUserDefaults] setObject:language forKey:@"sys_language"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    for (NSDictionary *dict in [self identifiers]) {
        NSString *identifier = dict[@"identifier"];
        NSString *bundleString = dict[@"bundle"];
        NSString *type = dict[@"type"] ;
        NSBundle *bundle = [NSBundle bundleWithIdentifier:identifier];
        if (bundleString != nil) {
            if (type.integerValue == 2) {
                NSBundle *fbundle = [NSBundle bundleWithPath:[bundle pathForResource:bundleString ofType:@"bundle"]];
                objc_setAssociatedObject(NSBundle.mainBundle, &_bundlekey, language ? [NSBundle bundleWithPath:[fbundle pathForResource:language ofType:@"lproj"]] : nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
            }else{
                NSBundle *fbundle = [NSBundle bundleWithPath:bundleString];
                objc_setAssociatedObject(NSBundle.mainBundle, &_bundlekey, language ? [NSBundle bundleWithPath:[fbundle pathForResource:language ofType:@"lproj"]] : nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
            }
        }else{
            objc_setAssociatedObject(NSBundle.mainBundle, &_bundlekey, language ? [NSBundle bundleWithPath:[bundle pathForResource:language ofType:@"lproj"]] : nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        }
    }
    
}
-(NSString *)currentLanguage {
    NSString *savedLanguage = [[NSUserDefaults standardUserDefaults] objectForKey:@"sys_language"];
    return savedLanguage ?: [[NSBundle mainBundle] preferredLocalizations].firstObject;
}











@end
