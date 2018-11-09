//
//  BinzCategory.m
//  XiaoTuanTuanHD
//
//  Created by 张彬 on 2018/8/9.
//  Copyright © 2018年 bin.z. All rights reserved.
//

#import "BinzCategory.h"
#import "MJExtension.h"

@implementation BinzCategory

- (NSString *)title{
    return self.name;
}

- (NSArray<NSString *> *)subtitles{
    return self.subcategories;
}

+ (NSDictionary *)mj_replacedKeyFromPropertyName{
    return @{@"name" : @"category_name"};
}

MJCodingImplementation

@end
