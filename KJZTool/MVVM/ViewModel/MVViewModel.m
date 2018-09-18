//
//  MVViewModel.m
//  KJZTool
//
//  Created by alete on 2018/8/24.
//  Copyright © 2018 aletevcc. All rights reserved.
//

#import "MVViewModel.h"

@implementation MVViewModel


-(RACCommand *)reccomand{
    
    if (!_reccomand) {
        @weakify(self)
        _reccomand = [[RACCommand alloc]initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            @strongify(self)
            return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
                dispatch_async(dispatch_queue_create("com.request", NULL), ^{
                    [self loadData:subscriber];
                });
                return [RACDisposable disposableWithBlock:^{
                    NSLog(@"quxiaole");
                }] ;
            }];
        }];
    }
    return _reccomand ;
    
}

-(void)loadData:(id<RACSubscriber>)subscriber{
    
    NSMutableArray *datalist = [NSMutableArray arrayWithCapacity:10];
    for (int i = 0; i<10; i++) {
        MVModel *model = [[MVModel alloc]init];
        model.title = @"werqewqrewqrew";
        [datalist addObject:model];
    }
    if (self.dataArray == nil) {
        self.dataArray = datalist.copy ;
    }else{
        self.dataArray = [self.dataArray arrayByAddingObjectsFromArray:datalist.copy];
    }
    dispatch_async(dispatch_get_main_queue(), ^{
        [subscriber sendNext:nil];
        [subscriber sendCompleted];
    });
    
    
}







@end
