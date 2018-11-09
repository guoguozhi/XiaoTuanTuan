//
//  BinzLineThroughLabel.m
//  XiaoTuanTuanHD
//
//  Created by 张彬 on 2018/9/9.
//  Copyright © 2018年 bin.z. All rights reserved.
//

#import "BinzLineThroughLabel.h"

@implementation BinzLineThroughLabel

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initComponent];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self initComponent];
    }
    return self;
}

- (void)initComponent{
    
}

- (void)drawRect:(CGRect)rect{
    [super drawRect:rect];
    // 设置绘制颜色
    //[[UIColor redColor] setFill];
    [self.textColor setFill];
    CGFloat x = 0;
    CGFloat y = self.bounds.size.height * 0.5;
    CGFloat width = self.bounds.size.width;
    CGFloat height = 1;
    // 绘制一条中划线
    UIRectFill(CGRectMake(x, y, width, height));
}

@end
