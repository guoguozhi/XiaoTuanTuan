//
//  BinzCity.h
//  XiaoTuanTuanHD
//
//  Created by 张彬 on 2018/8/9.
//  Copyright © 2018年 bin.z. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BinzCity : NSObject

/** 名称 */
@property (nonatomic, copy) NSString *name;
/** 拼音(全拼) */
@property (nonatomic, copy) NSString *pinYin;
/** 拼音(简拼) */
@property (nonatomic, copy) NSString *pinYinHead;
/** 区域 */
@property (nonatomic, strong) NSArray *regions;

@end
