//
//  BinzFindDealResult.h
//  XiaoTuanTuanHD
//
//  Created by 张彬 on 2018/8/5.
//  Copyright © 2018年 bin.z. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BinzGetSingleDealResult.h"

@interface BinzFindDealResult : BinzGetSingleDealResult

/** total_count         int         所有页面团购总数 */
@property (nonatomic, strong) NSNumber *total_count;

@end
