//
//  BinzGetSingleDealParam.h
//  XiaoTuanTuanHD
//
//  Created by 张彬 on 2018/8/5.
//  Copyright © 2018年 bin.z. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BinzGetSingleDealParam : NSObject

/** deal_id    string    团购ID */
@property (nonatomic, copy) NSString *deal_id;
/** format    string    返回数据格式，可选值为json或xml，如不传入，默认值为json */
@property (nonatomic, copy) NSString *format;

@end
