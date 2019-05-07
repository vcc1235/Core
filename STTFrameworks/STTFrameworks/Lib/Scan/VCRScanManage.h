//
//  ScanLibViewController.h
//  zbard
//
//  Created by vcc on 16/6/12.
//  Copyright © 2016年 vcc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "VCRQRCodeDelegate.h"


@class LBXScanViewStyle ;
@interface VCRScanManage : NSObject


/**
 生成二维码

 @param info 二维码信息
 @param flat 二维码宽度
 @return <#return value description#>
 */
+(UIImage *)createScanViewShowInfo:(NSString *)info SizeWidth:(CGFloat)flat ;


/**
 生成二维码

 @param info 二维码信息
 @param image 中间图片
 @param logo 图片大小
 @param flat 生成二维码宽度
 @return <#return value description#>
 */
+(UIImage *)createScanViewShowInfo:(NSString *)info LogoImage:(UIImage *)image LogoSize:(CGFloat)logo ImageSize:(CGFloat)flat ;


/**
 扫描二维码
 
 @param viewController 控制器
 @param isPhoto 相册二维码
 @param style 扫描界面
 @param delegate <#delegate description#>
 */
+(void)richScanToBarCodeandViewController:(UIViewController *)viewController isPhoto:(BOOL)isPhoto style:(LBXScanViewStyle *)style setDelegate:(id <VCRQRCodeDelegate> )delegate ;



/**
 识别图片中的二维码

 @param image 图片
 @param delegate <#delegate description#>
 */
+(void)showScanImage:(UIImage *)image Delegate:(id<VCRQRCodeDelegate>)delegate ;



@end
