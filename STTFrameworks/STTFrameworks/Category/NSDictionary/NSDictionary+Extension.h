//
//  NSDictionary+Extension.h
//  DKLib
//
//  Created by alete on 2018/7/31.
//  Copyright © 2018年 aletevcc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (Extension)
/** 字典转 json字符串 **/
-(NSString *)jsonString ;
/** 字典转 query 字符串 **/
-(NSString *)queryString ;

- (NSString *)stringForKey:(id)key;

- (NSNumber *)numberForKey:(id)key ;
@end
