//
//  BinzSingleton.h
//  XiaoTuanTuanHD
//
//  Created by 张彬 on 2018/8/5.
//  Copyright © 2018年 bin.z. All rights reserved.
//

// .h
#define BinzSingletonH(name) + (instancetype)share##name;

// .m
#define BinzSingletonM(name) \
\
static id _instance = nil; \
\
+ (instancetype)share##name{ \
    static dispatch_once_t onceToken; \
    dispatch_once(&onceToken, ^{ \
        _instance = [[self alloc] init]; \
    }); \
    return _instance; \
} \
\
+ (instancetype)allocWithZone:(struct _NSZone *)zone{ \
    static dispatch_once_t onceToken; \
    dispatch_once(&onceToken, ^{ \
        _instance = [super allocWithZone:zone]; \
    }); \
    return _instance; \
} \
\
- (id)copyWithZone:(NSZone *)zone{ \
    return _instance; \
}
