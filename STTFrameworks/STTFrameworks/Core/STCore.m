//
//  STCore.m
//  STTFrameworks
//
//  Created by alete on 2018/7/26.
//  Copyright © 2018年 aletevcc. All rights reserved.
//

#import "STCore.h"
#import <AFNetworking/AFNetworking.h>
#import <SVProgressHUD/SVProgressHUD.h>
#import <XMLDictionary/XMLDictionary.h>

@interface AFHttpClient : AFHTTPSessionManager

+ (instancetype)sharedClient;

@property (nonatomic, assign) BOOL securitySSL ;

@end

@implementation AFHttpClient

+ (instancetype)sharedClient {
    
    static AFHttpClient * client = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
//        NSURLSessionConfiguration * configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
        
        client = [AFHttpClient manager];
        //接收参数类型[NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"application/x-json",@"text/html",@"text/plain", nil];
        client.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"application/x-json",@"text/html",@"text/plain", nil];
        //申明请求的数据是json类型
//        client.requestSerializer = [AFJSONRequestSerializer serializer];
//        //申明返回的结果是json类型
//        client.responseSerializer = [AFJSONResponseSerializer serializer];
        //设置超时时间
        client.requestSerializer.timeoutInterval = 30;
        //安全策略
        client.securityPolicy = [AFSecurityPolicy defaultPolicy];
    });
    
    return client;
    
}
+ (AFSecurityPolicy *)customSecurityPolicy
{
    //先导入证书，找到证书的路径
    NSString *cerPath = [[NSBundle bundleForClass:self] pathForResource:@"server" ofType:@"cer"];
    NSData *certData = [NSData dataWithContentsOfFile:cerPath];
    //AFSSLPinningModeCertificate 使用证书验证模式
    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeCertificate];
    //allowInvalidCertificates 是否允许无效证书（也就是自建的证书），默认为NO
    //如果是需要验证自建证书，需要设置为YES
    securityPolicy.allowInvalidCertificates = YES;
    //validatesDomainName 是否需要验证域名，默认为YES；
    //假如证书的域名与你请求的域名不一致，需把该项设置为NO；如设成NO的话，即服务器使用其他可信任机构颁发的证书，也可以建立连接，这个非常危险，建议打开。
    //置为NO，主要用于这种情况：客户端请求的是子域名，而证书上的是另外一个域名。因为SSL证书上的域名是独立的，假如证书上注册的域名是www.google.com，那么mail.google.com是无法验证通过的；当然，有钱可以注册通配符的域名*.google.com，但这个还是比较贵的。
    //如置为NO，建议自己添加对应域名的校验逻辑。
    securityPolicy.validatesDomainName = NO;
    securityPolicy.pinnedCertificates = [NSSet setWithObjects:certData, nil]; //(NSSet *)@[certData];
    return securityPolicy;
    
}

-(void)setSecuritySSL:(BOOL)securitySSL{
    if (securitySSL) {
        self.securityPolicy = [self.class customSecurityPolicy];
    }else{
        self.securityPolicy = [AFSecurityPolicy defaultPolicy];
    }
}
@end
@interface STCore ()


@end
@implementation STCore
static AFNetworkReachabilityManager * _reachablityManager;
+(void)setSecuritySSL:(BOOL)ssl{
    [AFHttpClient.sharedClient setSecuritySSL:ssl];
}
+(void)setValue:(NSString *)value forHTTPHeaderField:(NSString *)field{
    [AFHttpClient.sharedClient.requestSerializer setValue:value forHTTPHeaderField:field];
}


+(NSURLSessionDataTask *)requestTask:(void (^)(STCore *))request response:(ResponseTask)response{
    
    if (request == nil) {
        return nil ;
    }
    STCore *core = STCore.alloc.init ;
    request(core);
    if (core.method == RequestGET) {
        return [AFHttpClient.sharedClient GET:core.url parameters:core.param progress:^(NSProgress * _Nonnull downloadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            if (response) {
                response(responseObject,nil);
            }
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            if (response) {
                response(nil,error);
            }
        }];
    }else if(core.method == RequestPOST){
        return [AFHttpClient.sharedClient POST:core.url parameters:core.param progress:^(NSProgress * _Nonnull uploadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            if (response) {
                response(responseObject,nil);
            }
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            if (response) {
                response(nil,error);
            }
        }];
    }else if (core.method == RequestUpLoad){
        //获取完整的url路径
        FormData *__formData = core.formData;
        core.url = [core.url stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
        return [AFHttpClient.sharedClient POST:core.url parameters:core.param constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
            [formData appendPartWithFileData:__formData.data name:__formData.name fileName:__formData.fileName mimeType:__formData.mimeType];
        } progress:^(NSProgress * _Nonnull uploadProgress) {
           
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            if (response) {
                response(responseObject,nil);
            }
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            if (response) {
                response(nil,error);
            }
        }];
    }else{
        return nil ;
    }

}

+(NSURLSessionDataTask *)xmlRequestTask:(void (^)(STCore *))request response:(ResponseTask)response{
    
    if (request == nil) {
        return nil ;
    }
    STCore *core = STCore.alloc.init ;
    request(core);
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFXMLParserResponseSerializer serializer];
    [AFXMLParserResponseSerializer serializer].acceptableContentTypes = [NSSet setWithObjects:@"text/xml", @"application/xml", nil];
    if (core.method == RequestGET) {
        return [manager GET:core.url parameters:core.param progress:^(NSProgress * _Nonnull downloadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            NSXMLParser *parser = (NSXMLParser *)responseObject ;
            NSDictionary *object = [NSDictionary dictionaryWithXMLParser:parser];
            if (response) {
                response(object,nil);
            }
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            if (response) {
                response(nil,error);
            }
        }];
    }else if(core.method == RequestPOST){
        return [manager POST:core.url parameters:core.param progress:^(NSProgress * _Nonnull uploadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            NSXMLParser *parser = (NSXMLParser *)responseObject ;
            NSDictionary *object = [NSDictionary dictionaryWithXMLParser:parser];
            if (response) {
                response(object,nil);
            }
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            if (response) {
                response(nil,error);
            }
        }];
    }else if (core.method == RequestUpLoad){
        //获取完整的url路径
        FormData *__formData = core.formData;
        core.url = [core.url stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
        return [manager POST:core.url parameters:core.param constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
            [formData appendPartWithFileData:__formData.data name:__formData.name fileName:__formData.fileName mimeType:__formData.mimeType];
        } progress:^(NSProgress * _Nonnull uploadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            if (response) {
                response(responseObject,nil);
            }
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            if (response) {
                response(nil,error);
            }
        }];
    }else{
        return nil ;
    }
    
}

+(STCore *(^)(NSString *))requestTask{
    return ^STCore *(NSString *url){
        STCore *Store = [[STCore alloc]init];
        Store.url = url ;
        return  Store ;
    };
}
-(STCore *(^)(NSDictionary *))requestBody{
    return ^STCore*(NSDictionary *param){
        self.param = param ;
        return self ;
    };
}
-(STCore *(^)(RequestMethod))requestMethod{
    return ^STCore*(RequestMethod method){
        self.method = method ;
        return self;
    };
}
-(NSURLSessionDataTask *(^)(ResponseTask))responseTask{
    return ^NSURLSessionDataTask*(ResponseTask response){
        return [STCore requestTask:^(STCore *core) {
            core.url = self.url ;
            core.param = self.param ;
            core.method = self.method ;
        } response:response];
    };
}

-(NSURLSessionDataTask *(^)(ResponseTask))xmlResponseTask{
    
    return ^NSURLSessionDataTask*(ResponseTask response){
        return [STCore xmlRequestTask:^(STCore *core) {
            core.url = self.url ;
            core.param = self.param ;
            core.method = self.method ;
        } response:response];
    };
}

+(ResponseTask)setResponse:(ResponseTask)response{
    return response ;
}

/** GET **/
+(NSURLSessionDataTask *)getWithURLString:(NSString *)urlStr params:(NSDictionary *)params success:(Response)success failure:(Fail)failure{
    
    urlStr = [urlStr stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    return [AFHttpClient.sharedClient GET:urlStr parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
#ifdef DEBUG
        NSLog(@"%.6lf",downloadProgress.fractionCompleted);
#endif
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) {
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(error);
        }
    }];
    
}



+(NSURLSessionDataTask *)postWithURLString:(NSString *)urlStr params:(NSDictionary *)params success:(Response)success failure:(Fail)failure{
    
    urlStr = [urlStr stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    return [AFHttpClient.sharedClient POST:urlStr parameters:params progress:^(NSProgress * _Nonnull uploadProgress) {
#ifdef DEBUG
        NSLog(@"%.6lf",uploadProgress.fractionCompleted);
#endif
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) {
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(error);
        }
    }];
    
}

+(NSURLSessionDownloadTask *)downloadWithURLString:(NSString *)urlStr success:(Response)success failure:(Fail)failure progress:(Progress)progress{
    
    urlStr = [urlStr stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    NSURL *URL = [NSURL URLWithString:urlStr];
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
    NSURLSessionDownloadTask *downloadTask = [AFHttpClient.sharedClient downloadTaskWithRequest:request progress:^(NSProgress * _Nonnull downloadProgress) {
        if (progress) {
            progress(downloadProgress.fractionCompleted);
        }
    } destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
        //获取沙盒cache路径
        NSURL * documentsDirectoryURL = [[NSFileManager defaultManager] URLForDirectory:NSCachesDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:NO error:nil];
        return [documentsDirectoryURL URLByAppendingPathComponent:[response suggestedFilename]];
    } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
        if (error) {
            failure?failure(error):"" ;
        }else{
            success?success(filePath.path):"" ;
        }
    }];
    [downloadTask resume];
    return downloadTask ;
    
}

+ (NSURLSessionDataTask *)uploadFileWithURLString:(NSString *)urlStr params:(NSDictionary *)params FormData:(FormData *)formData success:(Response)success failure:(Fail)failure progress:(Progress)progress {
    
    //获取完整的url路径
    FormData *__formData = formData;
    urlStr = [urlStr stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    
    return [AFHttpClient.sharedClient POST:urlStr parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        [formData appendPartWithFileData:__formData.data name:__formData.name fileName:__formData.fileName mimeType:__formData.mimeType];
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        if (progress) {
            progress(uploadProgress.fractionCompleted);
        }
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) {
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(error);
        }
    }];
}
/**
 * 开启网络状态监听
 */
+ (void)networkReachabilityMonitoring {
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        _reachablityManager = [AFNetworkReachabilityManager manager];
        [_reachablityManager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
            
            switch (status) {
                case AFNetworkReachabilityStatusNotReachable: {
                    [SVProgressHUD showErrorWithStatus:NSLocalizedString(@"core_network_not", nil)];
                    break;
                }
                case AFNetworkReachabilityStatusReachableViaWiFi: {
                    NSLog(@"Wifi已开启");
                    break;
                }
                case AFNetworkReachabilityStatusReachableViaWWAN: {
                    NSLog(@"你现在使用的流量");
                    break;
                }
                case AFNetworkReachabilityStatusUnknown: {
                    NSLog(@"你现在使用的未知网络");
                    break;
                }
                default:
                    break;
            }
        }];
        
        [_reachablityManager startMonitoring];
    });
    
}

@end


@implementation FormData

- (instancetype)initWithImageData:(NSData *)imageData {
    
    if (self = [super init]) {
        self.data = imageData;
        self.mimeType = [self.class mimeTypeWithImageData:self.data];
    }
    return self;
}

+ (NSString *)mimeTypeWithImageData:(NSData *)data {
    uint8_t c;
    [data getBytes:&c length:1];
    switch (c) {
        case 0xFF:
            return @"image/jpeg";
        case 0x89:
            return @"image/png";
        case 0x47:
            return @"image/gif";
        case 0x49:
        case 0x4D:
            return @"image/tiff";
        case 0x52:
            // R as RIFF for WEBP
            if ([data length] < 12) {
                return nil;
            }
            
            NSString *testString = [[NSString alloc] initWithData:[data subdataWithRange:NSMakeRange(0, 12)] encoding:NSASCIIStringEncoding];
            if ([testString hasPrefix:@"RIFF"] && [testString hasSuffix:@"WEBP"]) {
                return @"image/webp";
            }
            
            return @"application/octet-stream";
    }
    return @"application/octet-stream";
}

+ (NSString *)mimeTypeWithFilePath:(NSString *)path {
    
    if (![[[NSFileManager alloc] init] fileExistsAtPath:path]) {
        return nil;
    }
    
    CFStringRef UTI = UTTypeCreatePreferredIdentifierForTag(kUTTagClassFilenameExtension, (__bridge CFStringRef)[path pathExtension], NULL);
    CFStringRef MIMEType = UTTypeCopyPreferredTagWithClass (UTI, kUTTagClassMIMEType); CFRelease(UTI);
    if (!MIMEType) {
        return @"application/octet-stream";
    }
    NSString *type = (__bridge NSString *)(MIMEType);
    
    CFRelease(MIMEType);
    
    return type ;
    
}

@end
