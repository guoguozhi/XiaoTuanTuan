//
//  BinzRegionViewController.h
//  XiaoTuanTuanHD
//
//  Created by 张彬 on 2018/8/12.
//  Copyright © 2018年 bin.z. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BinzRegion;

@interface BinzRegionViewController : UIViewController

/** 展示的区域 */
@property (nonatomic, strong) NSArray *displayRegions;
/** 选中的区域 */
@property (nonatomic, strong) BinzRegion *selectedRegion;
/** 选中的子区域名称 */
@property (nonatomic, copy) NSString *selecteSubRegionName;
// 切换城市block
@property (nonatomic, copy) void (^changeCityComplentionHandler)(void) ;

@end
