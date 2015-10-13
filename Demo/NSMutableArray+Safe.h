//
//  NSMutableArray+Safe.h
//  mike2.0
//
//  Created by 佐毅 on 15/9/15.
//  Copyright (c) 2015年 上海乐住信息技术有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSMutableArray (Safe)

//NSMutableArray addObject:的安全方法，避免anObject为nil时造成的崩溃
- (void)safeAddObject:(id)anObject;

//NSMutableArray insertObject:atIndex:的安全方法，避免index越界以及anObject为nil时造成的崩溃
- (void)safeInsertObject:(id)anObject atIndex:(NSInteger)index;

//NSMutableArray removeObjectAtIndex:的安全方法，避免数组越界造成的崩溃
- (void)safeRemoveObjectAtIndex:(NSInteger)index;

//NSMutableArray replaceObjectAtIndex:withObject:的安全方法，避免index越界以及anObject为nil时造成的崩溃
- (void)safeReplaceObjectAtIndex:(NSInteger)index withObject:(id)anObject;

@end
