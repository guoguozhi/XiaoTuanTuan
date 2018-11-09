//
//  BinzLocalDealTool.m
//  XiaoTuanTuanHD
//
//  Created by 张彬 on 2018/9/26.
//  Copyright © 2018年 bin.z. All rights reserved.
//

#import "BinzLocalDealTool.h"
#import "BinzDeal.h"

// 浏览历史的路径
#define BinzHistoryDealsPath [UserDirectory stringByAppendingPathComponent:@"history_deals.archive"]
// 收藏记录的路径
#define BinzCollectDealsPath [UserDirectory stringByAppendingPathComponent:@"collect_deals.archive"]

@interface BinzLocalDealTool()

/** 历史团购数组 */
@property (nonatomic, strong) NSMutableArray<BinzDeal *> *historyDeals;
/** 收藏团购数组 */
@property (nonatomic, strong) NSMutableArray<BinzDeal *> *collectDeals;

@end

@implementation BinzLocalDealTool

BinzSingletonM(LocalDealTool)

#pragma mark - 懒加载

// 读取浏览历史记录
- (NSMutableArray<BinzDeal *> *)historyDeals{
    if (!_historyDeals) {
        // 加载
        _historyDeals = [NSKeyedUnarchiver unarchiveObjectWithFile:BinzHistoryDealsPath];
        if (_historyDeals == nil) {
            _historyDeals = [NSMutableArray<BinzDeal *> array];
        }
    }
    return _historyDeals;
}

// 读取收藏记录
- (NSMutableArray<BinzDeal *> *)collectDeals{
    if (!_collectDeals) {
        // 加载
        _collectDeals = [NSKeyedUnarchiver unarchiveObjectWithFile:BinzCollectDealsPath];
        if (_collectDeals == nil) {
            _collectDeals = [NSMutableArray<BinzDeal *> array];
        }
    }
    return _collectDeals;
}

// 保存浏览历史记录
- (void)saveHistoryDeal:(BinzDeal *)deal{
    NSLog(@"BinzHistoryDealsPath:%@", BinzHistoryDealsPath);
    // 判断deal是否已存在
    if ([self.historyDeals containsObject:deal]) {
        [self.historyDeals removeObject:deal];
    }
    // 读取浏览历史将最新的团购放最前面
    [self.historyDeals insertObject:deal atIndex:0];
    // 保存数据至沙盒
    [NSKeyedArchiver archiveRootObject:self.historyDeals toFile:BinzHistoryDealsPath];
}

// 保存收藏记录
- (void)saveCollectDeal:(BinzDeal *)deal{
    NSLog(@"BinzCollectDealsPath:%@", BinzCollectDealsPath);
    // 判断deal是否已存在
    if ([self.collectDeals containsObject:deal]) {
        return ;
    }
    // 读取浏览历史将最新的团购放最前面
    [self.collectDeals insertObject:deal atIndex:0];
    // 保存数据至沙盒
    [NSKeyedArchiver archiveRootObject:self.collectDeals toFile:BinzCollectDealsPath];
}

// 取消收藏记录
- (void)cancelCollectDeal:(BinzDeal *)deal{
    // 依据团购ID删除团购
    [self.collectDeals removeObject:deal];
    // 保存数据至沙盒
    [NSKeyedArchiver archiveRootObject:self.collectDeals toFile:BinzCollectDealsPath];
}

// 判断是否收藏了团购
- (BOOL)isDealCollected:(BinzDeal *)deal{
    return [self.collectDeals containsObject:deal];
}

@end
