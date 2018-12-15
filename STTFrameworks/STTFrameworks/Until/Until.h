//
//  Until.h
//  DKLib
//
//  Created by alete on 2018/7/23.
//  Copyright © 2018年 aletevcc. All rights reserved.
//


/****** 作为服务中心 ******/
/*
 * 尽量避免各个功能模块中文件穿插 公共类别放到一起
 * 利用路由模式来调用各个功能模块
 * 每个模块都应该有属于自己的调度中心
 * 如果要对外开的功能模块 请对外放出请求URL
 */

#import <Foundation/Foundation.h>
/** 各个功能调用中心遵循协议 **/
#import "UntilProtocol.h"

typedef enum NSInteger{
    RMTransitionPresent,
    RMTransitionPush,
    RMTRansitionNAVPresent,
    RMTransitionNone
    
}RMTransition;

@interface Until : NSObject

/** 单例调度 **/
+(instancetype)shareInstance ;

/** 添加Unit功能模块 **/
-(void)addUntil:(Class<UntilProtocol>)target ForScheme:(NSString *)scheme ;

/**
  外部请求开始 Until 功能执行 Get请求
 @param url url:scheme://target/action/action?key1=value1&key2=value2
 @param response response 回调业务
 */
-(void)getResquest:(NSURL *)url respone:(void(^)(id object,NSError *error))response ;


/**
 外部请求开始 until  功能执行 Post请求
 @param url url:scheme://host/target/action
 @param params params   参数
 @param response response  回调
 */
-(void)postResquest:(NSURL *)url params:(NSDictionary *)params respone:(void(^)(id object,NSError *error))response ;


/**
 同步请求
 @param url url
 @return <#return value description#>
 */
-(id)getSyncRequest:(NSURL *)url ;


/**
 同步请求
 @param url url
 @param params params
 @return value
 */
-(id)postSyncRequest:(NSURL *)url params:(NSDictionary *)params ;


/**
 控制器之间
 @param source target
 @param targetName targetName
 @param params params
 @param transition transition
 @return id
 */
+(id)transitionWithSource:(id)source Target:(NSString *)targetName Params:(NSDictionary *)params TransitionMode:(RMTransition)transition ;

@end
