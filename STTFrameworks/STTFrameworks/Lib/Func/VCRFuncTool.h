//
//  VCRFuncTool.h
//  秀VV
//
//  Created by alete on 2017/5/19.
//  Copyright © 2017年 vcc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#define RectW [UIScreen mainScreen].bounds.size.width
#define RectH [UIScreen mainScreen].bounds.size.height

#define kDevice_Is_iPhoneX ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) : NO)
//#define kNavigationHeight self.navigationController.navigationBar.frame.size.height
//#define kTabBarHeight self.tabBarController.tabBar.frame.size.height
//#define kStatusHeight [[UIApplication sharedApplication] statusBarFrame].size.height


BOOL Device(void) ;
@class VCRFuncToolItem ;
@protocol VCRFuncToolDelegate <NSObject>


@optional 
-(void)funcToolItem:(VCRFuncToolItem *)item AtIndex:(NSInteger)index ;

-(void)funcToolCancel ;

@end


@interface VCRFuncToolItem : NSObject

@property (nonatomic, strong,readonly) NSString *itemName ;

@end




@interface VCRFuncTool : NSObject

@property (nonatomic, weak) id < VCRFuncToolDelegate > delegate ;

@property (nonatomic, strong) UIColor *tintColor ;

@property (nonatomic, strong) UIColor *separatorColor ;

@property (nonatomic, strong) UIColor *backColor ;

+(instancetype)initAddFuncToolItems:(NSArray <NSString *> *)items ;

+(instancetype)initAddFuncToolItems:(NSArray <NSString *> *)items delegate:(id<VCRFuncToolDelegate>)delegate ;

+(instancetype)initAddFuncToolItems:(NSArray <NSString *> *)items title:(NSString *)title;

+(instancetype)initAddFuncToolItems:(NSArray <NSString *> *)items title:(NSString *)title delegate:(id<VCRFuncToolDelegate>)delegate;

-(void)show ;

-(void)addFuncItem:(NSString *)name ;

-(void)removeItem:(NSString *)name ;

@end
