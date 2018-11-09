//
//  BinzRegion.h
//  XiaoTuanTuanHD
//
//  Created by 张彬 on 2018/8/9.
//  Copyright © 2018年 bin.z. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BinzDropdownMenu.h"

@interface BinzRegion : NSObject <BinzDropdownMenuItem>

/** 名称 */
@property (nonatomic, copy) NSString *name;
/** 子区域 */
@property (nonatomic, strong) NSArray *subregions;

@end
