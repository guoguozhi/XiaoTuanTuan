//
//  BinzRegion.m
//  XiaoTuanTuanHD
//
//  Created by 张彬 on 2018/8/9.
//  Copyright © 2018年 bin.z. All rights reserved.
//

#import "BinzRegion.h"
#import "MJExtension.h"

@implementation BinzRegion

- (NSString *)title{
    return self.name;
}

- (NSArray<NSString *> *)subtitles{
    return self.subregions;
}

MJCodingImplementation

@end
