//
//  NSObject+Swizzling.h
//  ART
//
//  Created by Lyra on 19/01/2018.
//  Copyright © 2018 Lyra. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>

@interface NSObject (Swizzling)

+ (void)methodSwizzlingWithOriginalSelector:(SEL)originalSelector
                           SwizzledSelector:(SEL)swizzledSelector;

@end
