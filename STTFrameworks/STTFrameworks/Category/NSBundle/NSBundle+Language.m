//
//  NSBundle+Language.m
//  STTFrameworks
//
//  Created by alete on 2018/7/26.
//  Copyright © 2018年 aletevcc. All rights reserved.
//

#import "NSBundle+Language.h"
#import "NSArray+Extension.h"
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
-(NSArray<NSString *> *)identifiers{
    return objc_getAssociatedObject(self, @"BundleIdentifier");
}
-(void)setIdentifiers:(NSArray<NSString *> *)Identifiers{
    [self willChangeValueForKey:@"BundleIdentifier"];
    objc_setAssociatedObject(self, @"BundleIdentifier", Identifiers, OBJC_ASSOCIATION_COPY_NONATOMIC);
    [self didChangeValueForKey:@"BundleIdentifier"];
}


#pragma mark - 语言设置处理 -
-(void)addBundleByIdentifiers:(NSString *)identifier{
    
    if (self.identifiers == nil) {
        NSBundle *bundle = [NSBundle bundleWithIdentifier:identifier];
        self.identifiers = @[identifier];
        object_setClass(bundle, [Language class]);
    }else{
        if (![[self identifiers] containsObject:identifier]) {
            NSBundle *bundle = [NSBundle bundleWithIdentifier:identifier];
            self.identifiers = [self.identifiers arrayByAddingObject:identifier];
            object_setClass(bundle, [Language class]);
        }
    }
}
-(void)setLanguage:(NSString *)language{
    
    // 然后将设置好的语言存储好，下次进来直接加载
    [[NSUserDefaults standardUserDefaults] setObject:language forKey:@"sys_language"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    for (NSString *identifier in [self identifiers]) {
        NSBundle *bundle = [NSBundle bundleWithIdentifier:identifier];
        if ([identifier isEqualToString:@"com.STTFrameworks"]) {
            NSBundle *fbundle = [NSBundle bundleWithPath:[[NSBundle bundleForClass:Language.class]pathForResource:@"STResource" ofType:@"bundle"]];
            objc_setAssociatedObject([NSBundle mainBundle], &_bundlekey, language ? [NSBundle bundleWithPath:[fbundle pathForResource:language ofType:@"lproj"]] : nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        }else{
            objc_setAssociatedObject(bundle, &_bundlekey, language ? [NSBundle bundleWithPath:[bundle pathForResource:language ofType:@"lproj"]] : nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        }
    }
    
}
-(NSString *)currentLanguage {
    NSString *savedLanguage = [[NSUserDefaults standardUserDefaults] objectForKey:@"sys_language"];
    return savedLanguage ?: [[NSBundle mainBundle] preferredLocalizations].firstObject;
}











@end
