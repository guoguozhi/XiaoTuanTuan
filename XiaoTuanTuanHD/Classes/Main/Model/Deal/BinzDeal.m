//
//  BinzDeal.m
//  XiaoTuanTuanHD
//
//  Created by 张彬 on 2018/8/5.
//  Copyright © 2018年 bin.z. All rights reserved.
//

#import "BinzDeal.h"
#import "BinzBusiness.h"
#import "BinzRestriction.h"
#import "BinzCategory.h"
#import "BinzRegion.h"
#import "MJExtension.h"

@implementation BinzDeal

+ (NSDictionary *)mj_objectClassInArray{
    return @{
                @"regions":[BinzRegion class],
                @"categories":[BinzCategory class],
                @"businesses":[BinzBusiness class],
                @"BinzRestriction":[BinzRestriction class]
            };
}

+ (NSDictionary *)mj_replacedKeyFromPropertyName{
    return @{@"desc" : @"description"};
}

- (BOOL)isEqual:(id)object{
    if ([object isKindOfClass:[self class]]) {
        BinzDeal *otherObject = (BinzDeal *)object;
        // 通过团购ID来判断
        return [self.deal_id isEqual:otherObject.deal_id];
    } else {
        return NO;
    }
}

MJCodingImplementation

@end
