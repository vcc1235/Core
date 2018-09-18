//
//  NSString+Extension.m
//  STTFrameworks
//
//  Created by alete on 2018/7/26.
//  Copyright © 2018年 aletevcc. All rights reserved.
//

#import "NSString+Extension.h"

@implementation NSString (Extension)
- (NSString *)trim {
    return [self clean];
}
- (NSString *)clean {
    NSString *str =  [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    return [str stringByReplacingOccurrencesOfString:@" " withString:@""];
}
/// String 转 URL
-(NSURL *)URL{
    return [NSURL URLWithString:self];
}
/// json 字符串转 字典
-(NSDictionary *)dictionary{
    
    if (self.length) {
        NSError *error = nil ;
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:[self dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableContainers error:&error];
        if (error) {
            return nil ;
        }
        return dict ;
    }
    return nil ;
    
}

-(NSString *)append:(id)str, ... {
 
    NSMutableString *mutableString = [NSMutableString stringWithString:self];
    NSString *objc = [NSString analyObject:str];
    [mutableString appendString:objc];
    
    va_list args;
    va_start(args, str); //开始解析。args指向view后面的参数
    id arg;
    while ((arg=va_arg(args,id))) {
        NSString *argsc = [NSString analyObject:arg];
        [mutableString appendString:argsc];
    }
    va_end(args);
    return mutableString ;
}
+(NSString *)analyObject:(id)objc{
    return [NSString stringWithFormat:@"%@",objc];
}
@end

















