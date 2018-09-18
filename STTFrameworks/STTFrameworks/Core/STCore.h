//
//  STCore.h
//  STTFrameworks
//
//  Created by alete on 2018/7/26.
//  Copyright © 2018年 aletevcc. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum:NSInteger{
    
    RequestGET =  1<<1 ,
    RequestPOST = 1<<2 ,
    RequestUpLoad = 1<<3
    
}RequestMethod;

typedef void(^ResponseTask)(id _Nullable resObject,NSError *error);

typedef void(^Response)(id _Nullable object);
typedef void(^Fail)(NSError *error);
typedef void(^Progress)(double  progress);

// 用来封装文件数据的模型
@interface FormData : NSObject
/**
 *  文件数据
 */
@property (nonatomic, strong) NSData *data;
/**
 *  参数名
 */
@property (nonatomic, copy) NSString *name;
/**
 *  文件名 带有后缀的
 */
@property (nonatomic, copy) NSString *fileName;
/**
 *  文件类型
 */
@property (nonatomic, copy) NSString *mimeType;


- (instancetype)initWithImageData:(NSData *)imageData;

@end



@interface STCore  : NSObject
/** 请求 URL **/
@property (nonatomic, copy) NSString *url ;
/** 请求体 **/
@property (nonatomic, copy) NSDictionary *param ;
/** 请求方式 **/
@property (nonatomic, assign) RequestMethod method ;

@property (nonatomic, strong) FormData *formData ;

/** 开启网络监听 **/
+ (void)networkReachabilityMonitoring ;

/** 是否开启https请求验证 **/
+(void)setSecuritySSL:(BOOL)ssl ;


/**
 请求头设置
 @param value value
 @param field field
 */
+(void)setValue:(NSString *)value forHTTPHeaderField:(NSString *)field ;


/**
 请求
 @param request 请求所需参数  url , body , method
 @return core
 */
+(NSURLSessionDataTask *)requestTask:(void(^)(STCore *core))request response:(ResponseTask)response;


+(STCore *(^)(NSString *urlStr))requestTask ;

-(STCore *(^)(NSDictionary *params))requestBody ;

-(STCore *(^)(RequestMethod method))requestMethod;

-(NSURLSessionDataTask *(^)(ResponseTask response))responseTask ;

+(ResponseTask)setResponse:(ResponseTask)response ;

/**
 GET 请求
 @param urlStr url: http(s)?://xxx.xxx.xx/xx/xx?key=value
 @param params params
 @param success success
 @param failure failure
 @return task
 */
+(NSURLSessionDataTask *)getWithURLString:(NSString *)urlStr params:(NSDictionary *)params success:(Response)success failure:(Fail)failure ;


/**
 POST 请求
 @param urlStr urlStr http(s)?://xxx.xxx.xx/xx/xx
 @param params params
 @param success success
 @param failure failure
 @return value
 */
+(NSURLSessionDataTask *)postWithURLString:(NSString *)urlStr params:(NSDictionary *)params success:(Response)success failure:(Fail)failure ;

/**
 下载
 @param urlStr  urlStr http(s)?://xxx.xxx.xx/xx/xx?key=value
 @param success success
 @param failure failure
 @param progress progress
 @return value
 */
+(NSURLSessionDownloadTask *)downloadWithURLString:(NSString *)urlStr success:(Response)success failure:(Fail)failure progress:(Progress)progress ;

/**
 上传
 @param urlStr urlStr http(s)?://xxx.xxx.xx/xx/xx?key=value
 @param params params
 @param formData fromData
 @param success success
 @param failure failure
 @param progress progress
 @return value
 */
+ (NSURLSessionDataTask *)uploadFileWithURLString:(NSString *)urlStr params:(NSDictionary *)params FormData:(FormData *)formData success:(Response)success failure:(Fail)failure progress:(Progress)progress ;


@end
