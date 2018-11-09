//
//  BinzCity.m
//  XiaoTuanTuanHD
//
//  Created by 张彬 on 2018/8/9.
//  Copyright © 2018年 bin.z. All rights reserved.
//

#import "BinzCity.h"
#import "MJExtension.h"
#import "BinzRegion.h"

@implementation BinzCity

+ (NSDictionary *)mj_objectClassInArray{
    return @{@"regions" : [BinzRegion class]};
}

@end
