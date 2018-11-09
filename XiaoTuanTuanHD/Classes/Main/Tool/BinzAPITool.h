//
//  BinzAPITool.h
//  XiaoTuanTuanHD
//
//  Created by 张彬 on 2018/8/4.
//  Copyright © 2018年 bin.z. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BinzSingleton.h"

@interface BinzAPITool : NSObject<NSCopying>

BinzSingletonH(APITool)

- (void)requestWithURL:(NSString *) url params:(NSMutableDictionary *) params success:(void(^)(id json)) success failure: (void (^)(NSError *error)) error;

@end
