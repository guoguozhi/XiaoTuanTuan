//
//  BinzHistoryDealController.m
//  XiaoTuanTuanHD
//
//  Created by 张彬 on 2018/9/26.
//  Copyright © 2018年 bin.z. All rights reserved.
//

#import "BinzHistoryDealController.h"
#import "BinzLocalDealTool.h"
#import "UIBarButtonItem+Extension.h"

@interface BinzHistoryDealController ()

@end

@implementation BinzHistoryDealController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSMutableArray<BinzDeal *> *historyDeals = [binzLocalDealTool historyDeals];
    self.deals = historyDeals;
    // 添加关闭按钮
    UIBarButtonItem *closeBarButtonItem = [UIBarButtonItem barButtonItemWithNormalBackgroundImageName:@"btn_navigation_close" highlightedBackgroundImageName:@"btn_navigation_close_hl" target:self action:@selector(close)];
    self.navigationItem.leftBarButtonItem = closeBarButtonItem;
    self.navigationItem.title = @"我的历史";
}

- (void)close{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (NSString *)emptyImageName{
    return @"icon_latestBrowse_empty";
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self.collectionView reloadData];
}

@end

/**
 注意点: UICollectionViewController的view并不是collectionView，collectionView仅仅只是view的子视图
 */

