//
//  BinzDealService.h
//  XiaoTuanTuanHD
//
//  Created by 张彬 on 2018/8/5.
//  Copyright © 2018年 bin.z. All rights reserved.
//

#import <Foundation/Foundation.h>

@class BinzFindDealParam,BinzFindDealResult,BinzGetSingleDealParam,BinzGetSingleDealResult;

@interface BinzDealService : NSObject

/**
 搜索团购
 
 @param param 请求参数
 @param success 成功的回调
 @param failure 失败的回调
 */
+ (void)findDeal:(BinzFindDealParam *) param success:(void (^)(BinzFindDealResult *result)) success failure:(void (^)(NSError *error)) failure;

/**
 获取单个团购
 
 @param param 请求参数
 @param success 成功的回调
 @param failure 失败的回调
 */
+ (void)getSingleDeal:(BinzGetSingleDealParam *) param success:(void (^)(BinzGetSingleDealResult *result)) success failure:(void (^)(NSError *error)) failure;

@end
