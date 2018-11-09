//
//  BinzDealService.m
//  XiaoTuanTuanHD
//
//  Created by 张彬 on 2018/8/5.
//  Copyright © 2018年 bin.z. All rights reserved.
//

#import "BinzDealService.h"
#import "BinzAPITool.h"
#import "MJExtension.h"
#import "BinzFindDealParam.h"
#import "BinzFindDealResult.h"
#import "BinzGetSingleDealParam.h"
#import "BinzGetSingleDealResult.h"

@implementation BinzDealService

+ (void)findDeal:(BinzFindDealParam *)param success:(void (^)(BinzFindDealResult *result))success failure:(void (^)(NSError *error))failure{
    BinzAPITool *apiTool = [BinzAPITool shareAPITool];
    // 模型转字典
    NSMutableDictionary *paramDict = [param mj_keyValues];
    [apiTool requestWithURL:@"v1/deal/find_deals" params:paramDict success:^(id json) {
        if (success) {
            // 字典转模型
            BinzFindDealResult *result = [BinzFindDealResult mj_objectWithKeyValues:json];
            // block传递模型数据
            success(result);
        }
    } failure:failure];
}

+ (void)getSingleDeal:(BinzGetSingleDealParam *)param success:(void (^)(BinzGetSingleDealResult *result))success failure:(void (^)(NSError *))failure{
    BinzAPITool *apiTool = [BinzAPITool shareAPITool];
    // 模型转字典
    NSMutableDictionary *paramDict = [param mj_keyValues];
    [apiTool requestWithURL:@"v1/deal/get_single_deal" params:paramDict success:^(id json) {
        if (success) {
            // 字典转模型
            BinzGetSingleDealResult *result = [BinzGetSingleDealResult mj_objectWithKeyValues:json];
            // block传递模型数据
            success(result);
        }
    } failure:failure];
}

@end
