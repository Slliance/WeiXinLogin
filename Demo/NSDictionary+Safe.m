//
//  NSDictionary+Safe.m
//  mike2.0
//
//  Created by 佐毅 on 15/9/15.
//  Copyright (c) 2015年 上海乐住信息技术有限公司. All rights reserved.
//

#import "NSDictionary+Safe.h"

@implementation NSDictionary (Safe)

- (NSString *)stringObjectForKey:(id <NSCopying>)key {
    id ob = [self objectForKey:key];
    if(ob == [NSNull null] || ob == nil) {
        return (@"");
    }
    if([ob isKindOfClass:[NSString class]]) {
        return (ob);
    }
    return ([NSString stringWithFormat:@"%@", ob]);
}

- (NSInteger)integerObjectForKey:(id <NSCopying>)aKey{
    NSString *strValue = [self stringObjectForKey:aKey];
    if (strValue.length==0) {
        return 0;
    }
    return [strValue integerValue];
}

- (CGFloat)floatObjectForKey:(id <NSCopying>)aKey{
    NSString *strValue = [self stringObjectForKey:aKey];
    if (strValue.length==0) {
        return 0;
    }
    return [strValue floatValue];
}

- (id)safeJsonObjectForKey:(id <NSCopying>)key {
    id ob = [self objectForKey:key];
    if(ob == [NSNull null]) {
        return (nil);
    }
    return (ob);
}

@end
