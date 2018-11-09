//
//  BinzGetSingleDealResult.m
//  XiaoTuanTuanHD
//
//  Created by 张彬 on 2018/8/5.
//  Copyright © 2018年 bin.z. All rights reserved.
//

#import "BinzGetSingleDealResult.h"
#import "MJExtension.h"
#import "BinzDeal.h"

@implementation BinzGetSingleDealResult

+ (NSDictionary *)mj_objectClassInArray{
    return @{@"deals" : [BinzDeal class]};
}

@end
