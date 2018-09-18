//
//  NSDictionary+Property.h
//  DKLib
//
//  Created by alete on 2018/7/31.
//  Copyright © 2018年 aletevcc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary < KeyType,ObjectType > (Property)

-(NSDictionary *)addDictionary:(NSDictionary <KeyType ,ObjectType> *)dict ;

@end



@interface NSObject (Until)
/** 根据 key 获取值  **/
-(id)getObjectForKey:(NSString *)key ;
/** 设置值 **/
-(void)setObject:(id)object ForKey:(NSString *)key ;

@end















