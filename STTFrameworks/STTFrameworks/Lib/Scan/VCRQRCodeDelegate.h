//
//  QRCodeShow.h
//  zbard
//
//  Created by vcc on 16/6/12.
//  Copyright © 2016年 vcc. All rights reserved.
//


@protocol VCRQRCodeDelegate <NSObject>

@required
/**
 扫描获取到结果前动作
 @param viewController <#viewController description#>
 */
-(void)getQRFinishByViewController:(UIViewController *)viewController ;



/**
 扫描错误
 
 @param error <#error description#>
 */
-(void)qrQRCodeForError:(NSString *)error ;


@optional
// 扫描标题
-(NSString *)qrDrawTotopTitle ;

// 扫描获取得到的信息
-(void)getQRCodeWithImg:(UIImage *)img andStr:(NSString *)info andStyle:(NSString *)style;

/// 获取闪光灯图片
-(UIImage *)getFlashButtonImageWithState:(BOOL)isFlash ;
@end






