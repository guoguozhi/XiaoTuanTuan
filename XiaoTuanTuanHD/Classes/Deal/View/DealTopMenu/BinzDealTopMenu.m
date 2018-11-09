//
//  BinzDealTopMenu.m
//  XiaoTuanTuanHD
//
//  Created by 张彬 on 2018/8/11.
//  Copyright © 2018年 bin.z. All rights reserved.
//

#import "BinzDealTopMenu.h"

@interface BinzDealTopMenu ()

@end

@implementation BinzDealTopMenu

+ (instancetype)dealTopMenu{
    return [[[NSBundle mainBundle] loadNibNamed:@"BinzDealTopMenu" owner:nil options:nil] firstObject];
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super initWithCoder:aDecoder]) {
        // 去掉了系统默认的拉伸行为
        self.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    }
    return self;
}

- (void)addTarget:(id)target action:(SEL)selector{
    [self.imageButton addTarget:target action:selector forControlEvents:UIControlEventTouchDown];
}

@end
