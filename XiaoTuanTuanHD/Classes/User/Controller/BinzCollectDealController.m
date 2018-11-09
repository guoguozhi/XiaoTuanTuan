//
//  BinzCollectDealController.m
//  XiaoTuanTuanHD
//
//  Created by 张彬 on 2018/10/17.
//  Copyright © 2018 bin.z. All rights reserved.
//

#import "BinzCollectDealController.h"
#import "BinzLocalDealTool.h"
#import "UIBarButtonItem+Extension.h"

@interface BinzCollectDealController ()

@end

@implementation BinzCollectDealController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSMutableArray<BinzDeal *> *historyDeals = [binzLocalDealTool collectDeals];
    self.deals = historyDeals;
    // 添加关闭按钮
    UIBarButtonItem *closeBarButtonItem = [UIBarButtonItem barButtonItemWithNormalBackgroundImageName:@"btn_navigation_close" highlightedBackgroundImageName:@"btn_navigation_close_hl" target:self action:@selector(close)];
    self.navigationItem.leftBarButtonItem = closeBarButtonItem;
    self.navigationItem.title = @"我的收藏";
}

- (void)close{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (NSString *)emptyImageName{
    return @"icon_collects_empty";
}

@end
