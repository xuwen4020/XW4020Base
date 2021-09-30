//
//  NSMutableArray+XWUtils.m
//  Project
//
//  Created by xuwen on 2018/4/23.
//  Copyright © 2018年 com.Wudiyongshi.www. All rights reserved.
//

#import "NSMutableArray+XWUtils.h"

@implementation NSMutableArray (XWUtils)

-(NSMutableArray*)randowmArrayWithCount:(NSInteger)count
{
    NSMutableArray *newArr = [NSMutableArray new];
    while (newArr.count < count) {
        //生成随机数
        int x =arc4random() % self.count;
        id obj = self[x];
        if (![newArr containsObject:obj]) {
            [newArr addObject:obj];
        }
    }
    return newArr;
}

- (NSMutableArray *)turnOver
{
    NSMutableArray *mutableArray = [NSMutableArray array];
    for(long i = self.count-1;i>=0;i--){
        [mutableArray addObject:self[i]];
    }
    return mutableArray;
}

@end
