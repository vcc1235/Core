//
//  NSDictionary+Extension.m
//  DKLib
//
//  Created by alete on 2018/7/31.
//  Copyright © 2018年 aletevcc. All rights reserved.
//

#import "NSDictionary+Extension.h"

@implementation NSDictionary (Extension)

-(NSString *)jsonString{
    NSError *error = nil;
    NSData *data = [NSJSONSerialization dataWithJSONObject:self options:NSJSONWritingPrettyPrinted error:&error];
    if (error == nil) {
        NSString *string = [NSString.alloc initWithData:data encoding:NSUTF8StringEncoding];
        string = [string stringByTrimmingCharactersInSet:NSCharacterSet.whitespaceAndNewlineCharacterSet];
        return string ;
    }
    return nil ;
}

-(NSString *)queryString{
    
    NSMutableString *string = [[NSMutableString alloc]init];
    [self enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        if ([key isKindOfClass:[NSString class]]) {
            [string appendString:key];
        }else if ([key isKindOfClass:[NSNumber class]]){
            [string appendString:((NSNumber *)key).stringValue];
        }else{
            [string appendString:@""];
        }
        [string appendString:@"="];
        if ([obj isKindOfClass:[NSString class]]) {
            [string appendString:obj];
        }else if ([obj isKindOfClass:[NSNumber class]]){
            [string appendString:((NSNumber *)obj).stringValue];
        }
        else if ([obj isKindOfClass:[NSArray class]]) {
            NSArray *objs = (NSArray *)obj;
            NSMutableString *ids = [NSMutableString stringWithString:@"["];
            for (id consulDoctor in objs) {
                [ids appendFormat:@"'%@',",consulDoctor];
            }
            NSString *idStr = [NSString stringWithFormat:@"%@]",[ids substringWithRange:NSMakeRange(0, [ids length]-1)]];
            [string appendString:idStr];
        }
        else if([obj isKindOfClass:[NSDictionary class]]){
            [string appendString:((NSDictionary *)obj).jsonString];
        }else{
            [string appendString:@""];
        }
        [string appendString:@"&"];
    }];
    if (!string || string.length == 0 ) {
        return string ;
    }
    NSString *subString = [string substringToIndex:string.length-1];
    return subString ;
    
}

// magus: return an empty string if the value is null or not a string.
- (NSString *)stringForKey:(id)key
{
    NSString *result = [self objectForKey:key];
    if([result isKindOfClass:[NSString class]])
    {
        return result;
    }
    if ([result isKindOfClass:[NSNumber class]]) {
        return [NSString stringWithFormat:@"%@",result];
    }
    else {
        return kEmptyString;
    }
}
- (NSNumber *)numberForKey:(id)key
{
    NSNumber *result = [self objectForKey:key];
    if([result isKindOfClass:[NSNumber class]])
    {
        return result;
    }
    else
    {
        return nil;
    }
}
@end
