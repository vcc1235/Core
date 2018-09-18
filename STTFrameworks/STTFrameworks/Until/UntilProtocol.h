//
//  UntilProtocol.h
//  DKLib
//
//  Created by alete on 2018/7/31.
//  Copyright © 2018年 aletevcc. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol UntilProtocol < NSObject >

@required
+(NSString *)isScheme ;

@optional
+(void)getResquest:(NSURL *)url respone:(void(^)(id object,NSError *error))response ;

+(void)postResquest:(NSURL *)url params:(NSDictionary *)params respone:(void(^)(id object,NSError *error))response ;

+(id)getSyncRequest:(NSURL *)url ;

+(id)postSyncRequest:(NSURL *)url params:(NSDictionary *)params ;

@end

@interface NSObject (UntilProtocol)


@end
