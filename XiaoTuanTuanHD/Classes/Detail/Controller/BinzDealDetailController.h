//
//  BinzDealDetailController.h
//  XiaoTuanTuanHD
//
//  Created by 张彬 on 2018/9/10.
//  Copyright © 2018年 bin.z. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BinzDeal;

@interface BinzDealDetailController : UIViewController

@property (nonatomic, strong) BinzDeal *deal;

// 设置屏幕方向
- (void)setInterfaceOrientation:(UIInterfaceOrientation) orientation;

@end
