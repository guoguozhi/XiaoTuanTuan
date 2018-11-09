//
//  BinzDealListController.h
//  XiaoTuanTuanHD
//
//  Created by 张彬 on 2018/9/30.
//  Copyright © 2018 bin.z. All rights reserved.
//  团购列表(基类)

#import <UIKit/UIKit.h>

@class BinzDeal;

@interface BinzDealListController : UICollectionViewController

/** 团购数据 */
@property (nonatomic, strong) NSMutableArray<BinzDeal *> *deals;

/** 无数据时，展示的图片名称 */
- (NSString *)emptyImageName;

@end

