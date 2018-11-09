//
//  BinzSort.h
//  XiaoTuanTuanHD
//
//  Created by 张彬 on 2018/8/9.
//  Copyright © 2018年 bin.z. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MJExtension.h"

/** 结果排序，1:默认，2:价格低优先，3:价格高优先，4:购买人数多优先(人气)，5:最新发布优先，6:即将结束优先，7:离经纬度坐标距离近优先 */
typedef enum : NSUInteger {
    BinzSortValueDefault = 1,   // 默认排序
    BinzSortValueLowPrice,      // 价格最低
    BinzSortValueHighPrice,     // 价格最高
    BinzSortValuePopular,       // 人气最高
    BinzSortValueLatest,        // 最新发布
    BinzSortValueOver,          // 即将结束
    BinzSortValueClosest        // 距离最近
} BinzSortValue;

@interface BinzSort : NSObject<NSCoding>

/** 名称 */
@property (nonatomic, copy) NSString *label;
/** 值 */
@property (nonatomic, strong) NSNumber *value;

@end
