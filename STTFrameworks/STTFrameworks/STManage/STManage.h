//
//  STManage.h
//  STTFrameworks
//
//  Created by alete on 2018/7/26.
//  Copyright © 2018年 aletevcc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "STIdentifier.h"

@interface STManage : NSObject
/** 初始化单例 **/
+(instancetype)shareInstance ;

@end

@interface STManage (CoreData)

-(void)setObject:(id)object forKey:(NSString *)key ;

-(id)getObjectForKey:(NSString *)key ;

-(void)removeObjectForKey:(NSString *)key;

-(void)presist ;
@end




@interface STManage (NSBundle)
/** 添加语言设置 BundleID **/
-(void)addBundleByIdentifiers:(NSString *)identifier ;
/** 设置语言 **/
-(void)setLanguage:(NSString *)language ;
/** 当前语言 **/
-(NSString *)currentLanguage ;
@end
