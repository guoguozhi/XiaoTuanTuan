//
//  Foundation+Log.m
//  AFN
//
//  Created by 张彬 on 2017/4/22.
//  Copyright © 2017年 bin.z. All rights reserved.
//

#import <Foundation/Foundation.h>

@implementation NSDictionary (Log)

- (NSString *)descriptionWithLocale:(id)locale{
    NSMutableString *description = [NSMutableString string];
    [description appendString:@"\r\n{\r\n"];
    [self enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        [description appendString:[NSString stringWithFormat:@"\t%@:%@,\r\n",key, obj]];
    }];
    // 查找最后一个","的范围 range 第一次找到就返回
    NSRange range = [description rangeOfString:@"," options:NSBackwardsSearch];
    // 删除指定范围的字符
    if ([description containsString:@","]) {
        [description deleteCharactersInRange:range];
    }
    [description appendString:@"}"];
    return description;
}

- (NSString *)description{
    return [self descriptionWithLocale:self];
}

@end

@implementation NSArray (Log)

- (NSString *)descriptionWithLocale:(id)locale{
    NSMutableString *description = [NSMutableString string];
    [description appendString:@"\r\n{\r\n"];
    [self enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [description appendString:[NSString stringWithFormat:@"\t%@\r\n",obj]];
    }];
    // 查找最后一个","的范围 range 第一次找到就返回
    NSRange range = [description rangeOfString:@"," options:NSBackwardsSearch];
    // 删除指定范围的字符
    if ([description containsString:@","]) {
        [description deleteCharactersInRange:range];
    }
    [description appendString:@"}"];
    return description;
}

- (NSString *)description{
    return [self descriptionWithLocale:self];
}

@end
