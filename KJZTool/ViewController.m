//
//  ViewController.m
//  KJZTool
//
//  Created by alete on 2018/7/17.
//  Copyright © 2018年 aletevcc. All rights reserved.
//

#import "ViewController.h"
#import <StoreKit/StoreKit.h>
#import <STTFrameworks/STTFrameworks.h>

@interface ViewController () <VCRFuncToolDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
//    [STCore.getWithURLString(@"http://ccadmin-api.kanjinzhao.group/v1/community/advertisementWeb/selectAdverisementByTitle?title=ios") success:^(id  _Nullable object) {
//        NSLog(@"%@",object);
//    } failure:^(NSError *error) {
//        NSLog(@"%@",error.localizedDescription);
//    }];
    
//    [STCore.getWithURLString(@"http://ccadmin-api.kanjinzhao.group/v1/community/advertisementWeb/selectAdverisementByTitle?title=ios").getParams(@{})
    
//    [store success:^(id  _Nullable object) {
//        NSLog(@"%@",object);
//    } failure:^(NSError *error) {
//        NSLog(@"%@",error.localizedDescription);
//    }];
    
    
//    [STCore getWithURLString:@"http://www.baidu.com" params:nil success:^(id  _Nullable object) {
//        NSLog(@"%@",object);
//    } failure:^(NSError *error) {
//        NSLog(@"%@",error.localizedDescription);
//    }];
//
//
//    NSString *strin = [@"1" append:@"2",@"3",@(4.25432543254325432), nil];
//
//    NSLog(@"%@",strin);
    
    
}


-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
//    NSString *viewController = @"MVViewController";
//
//    [self presentViewController:[[NSClassFromString(viewController) alloc]init] animated:false completion:nil];
    
//    [[VCRFuncTool initAddFuncToolItems:@[@"确定"] delegate:self ]show];
    
    [[VCRFuncTool initAddFuncToolItems:@[@"确定"] title:@"是否删除" delegate:self]show];
    
}





- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
