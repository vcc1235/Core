//
//  NSBundle+Language.h
//  STTFrameworks
//
//  Created by alete on 2018/7/26.
//  Copyright © 2018年 aletevcc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSBundle (Language)
/** 添加语言设置 BundleID **/
-(void)addBundleByIdentifiers:(NSString *)identifier ;
/** 设置语言 **/
-(void)setLanguage:(NSString *)language ;
/** 当前语言 **/
-(NSString *)currentLanguage ;
@end
