//
//  BinzGetSingleDealResult.h
//  XiaoTuanTuanHD
//
//  Created by 张彬 on 2018/8/5.
//  Copyright © 2018年 bin.z. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BinzGetSingleDealResult : NSObject

/** status              string      本次API访问状态，如果成功返回"OK"，并返回结果字段，如果失败返回"ERROR"，并返回错误说明 */
@property (nonatomic, copy) NSString *status;
/** count               int         本次API访问所获取的单页团购数量 */
@property (nonatomic, strong) NSNumber *count;
/** deals               list        所有团购信息*/
@property (nonatomic, strong) NSArray *deals;

@end
