//
//  NSNumber+Extension.h
//  UBK
//
//  Created by alete on 2018/4/25.
//  Copyright © 2018年 aletevcc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSNumber (Extension)
/*** 返回6位小数 ***/
-(NSString *)stringByBaseCoin ;
/** 返回 ≈¥%.2lf ***/
-(NSString *)stringByBaseCoinCny ;
/** 返回两位小数 **/
-(NSString *)doubleString ;
@end
