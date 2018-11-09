//
//  BinzLocalDealTool.h
//  XiaoTuanTuanHD
//
//  Created by 张彬 on 2018/9/26.
//  Copyright © 2018年 bin.z. All rights reserved.
//  本地团购缓存数据工具类(历史记录、收藏夹等)

#import <Foundation/Foundation.h>
#import "BinzSingleton.h"

@class BinzDeal;

@interface BinzLocalDealTool : NSObject

BinzSingletonH(LocalDealTool)

#pragma mark - 历史记录

/** 保存浏览历史记录 */
- (void)saveHistoryDeal:(BinzDeal *)deal;
/** 读取浏览历史记录 */
- (NSMutableArray<BinzDeal *> *)historyDeals;

#pragma mark - 收藏

/** 保存收藏记录 */
- (void)saveCollectDeal:(BinzDeal *)deal;
/** 取消收藏记录 */
- (void)cancelCollectDeal:(BinzDeal *)deal;
/** 读取收藏记录 */
- (NSMutableArray<BinzDeal *> *)collectDeals;
/** 判断是否收藏了团购 */
- (BOOL)isDealCollected:(BinzDeal *)deal;

@end
