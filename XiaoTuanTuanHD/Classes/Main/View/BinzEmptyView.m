//
//  BinzEmptyView.m
//  XiaoTuanTuanHD
//
//  Created by 张彬 on 2018/9/9.
//  Copyright © 2018年 bin.z. All rights reserved.
//

#import "BinzEmptyView.h"

@implementation BinzEmptyView

+ (instancetype)emptyView{
    return [[self alloc] init];
}

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
    self.contentMode = UIViewContentModeCenter;
}

// 一个控件从父控件上移除的时候，会调用will/didMoveTo/RemoveFromSuperview方法
- (void)didMoveToSuperview{
    if (self.superview) {
        // 调整大小(和父控件一样大)
        [self autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero];
    }
}

@end
