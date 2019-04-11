//
//  NSString+Extension.h
//  STTFrameworks
//
//  Created by alete on 2018/7/26.
//  Copyright © 2018年 aletevcc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Extension)
/** 替换空格与换行符 **/
-(NSString *)trim ;
/*** String 转 URL ***/
-(NSURL *)URL ;
/// 字符串转字典
-(NSDictionary *)dictionary;

-(NSString *)append:(id)str,... NS_REQUIRES_NIL_TERMINATION ;
/// 编码
-(NSString *)isDecode ;
@end
