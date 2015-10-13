//
//  NSDictionary+Safe.h
//  mike2.0
//
//  Created by 佐毅 on 15/9/15.
//  Copyright (c) 2015年 上海乐住信息技术有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface NSDictionary (Safe)

- (NSString *)stringObjectForKey:(id <NSCopying>)key;

- (NSInteger)integerObjectForKey:(id <NSCopying>)aKey;

- (CGFloat)floatObjectForKey:(id <NSCopying>)aKey;

- (id)safeJsonObjectForKey:(id <NSCopying>)key;

@end
