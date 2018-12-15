//
//  NSObject+Extension.h
//  秀VV
//
//  Created by vcc on 17/5/11.
//  Copyright © 2017年 vcc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSObject (Extension)

/**
 *  主线程执行
 *
 *  @param block <#block description#>
 */
-(void)getMainFunc:(void(^)())block ;


/**
 *  隐藏多余的cell 底线
 *
 *  @param tableView <#tableView description#>
 */
-(void)setExtraCellLineHidden: (UITableView *)tableView ;



/**
 字符串拼接
 
 @param string <#string description#>
 @return <#return value description#>
 */
-(NSString *)stringAppend:(NSString *)string,... NS_REQUIRES_NIL_TERMINATION ;



/**
 定时器

 @param time 总时间   间隔为 1s
 @param block 结束
 @param progress 进行计时中
 */
-(void)dispatchTimer:(NSInteger)time andSuccess:(void(^)(NSInteger time))block andProgress:(void(^)(NSInteger time))progress ;


/**
 定时

 @param time 总时间
 @param second 每次改变时间间隔
 @param block 结束返回
 @param progress 计时进行中
 */
-(void)dispatchTimer:(NSInteger)time second:(CGFloat)second andSuccess:(void (^)(NSInteger time))block andProgress:(void (^)(NSInteger time))progress;


/**
 用作解耦

 @param targetName classString
 @param params @{'属性':'value'}
 @return UIViewController*
 */
+(UIViewController *)perforTarget:(NSString *)targetName WithObject:(NSDictionary *)params ;


/**
 组合解耦

 @param url VCR://target/action?n=re&m=re
 @param completion <#completion description#>
 @return <#return value description#>
 */
+(UIViewController *)perforUrl:(NSURL *)url completion:(void(^)(NSDictionary *dic))completion ;
@end
