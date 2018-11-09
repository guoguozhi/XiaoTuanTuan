//
//  BinzRestriction.h
//  XiaoTuanTuanHD
//
//  Created by 张彬 on 2018/9/15.
//  Copyright © 2018年 bin.z. All rights reserved.
//  约束

#import <Foundation/Foundation.h>

@interface BinzRestriction : NSObject

/** restrictions.is_reservation_required    int    是否需要预约，0：不是，1：是 */
@property (nonatomic, assign) BOOL is_reservation_required;
/** restrictions.is_refundable    int    是否支持随时退款，0：不是，1：是 */
@property (nonatomic, assign) BOOL is_refundable;
/** restrictions.special_tips    string    附加信息(一般为团购信息的特别提示) */
@property (nonatomic, copy) NSString *special_tips;

@end
