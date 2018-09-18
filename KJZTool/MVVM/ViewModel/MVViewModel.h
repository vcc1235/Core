//
//  MVViewModel.h
//  KJZTool
//
//  Created by alete on 2018/8/24.
//  Copyright © 2018 aletevcc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <ReactiveObjC/ReactiveObjC.h>
#import "MVModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface MVViewModel : NSObject

@property (nonatomic, strong) RACCommand *reccomand ;

@property (nonatomic, strong) NSArray <MVViewModel *> *dataArray ;


@end

NS_ASSUME_NONNULL_END
