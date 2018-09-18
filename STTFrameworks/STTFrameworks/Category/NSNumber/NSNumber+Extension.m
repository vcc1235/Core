//
//  NSNumber+Extension.m
//  UBK
//
//  Created by alete on 2018/4/25.
//  Copyright © 2018年 aletevcc. All rights reserved.
//

#import "NSNumber+Extension.h"

@implementation NSNumber (Extension)
-(NSString *)stringByBaseCoin{
    return [NSString stringWithFormat:@"%.6lf",self.doubleValue];
}
-(NSString *)stringByBaseCoinCny{
    return [NSString stringWithFormat:@"≈¥%.2lf",self.doubleValue];
}
-(NSString *)doubleString{
    return [NSString stringWithFormat:@"%.2lf",self.doubleValue];
}

@end
