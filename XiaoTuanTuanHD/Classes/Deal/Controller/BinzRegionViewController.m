//
//  BinzRegionViewController.m
//  XiaoTuanTuanHD
//
//  Created by 张彬 on 2018/8/12.
//  Copyright © 2018年 bin.z. All rights reserved.
//

#import "BinzRegionViewController.h"
#import "BinzDropdownMenu.h"
#import "BinzRegion.h"

@interface BinzRegionViewController () <BinzDropdownMenuDataSource, BinzDropdownMenuDelegate>

/** 切换城市按钮 */
@property (weak, nonatomic) IBOutlet UIButton *changeCityButton;
/** 下拉菜单 */
@property (nonatomic, weak) BinzDropdownMenu *dropdownMenu;

// 点击切换城市
- (IBAction)changeCityButtonDidClick:(UIButton *)sender;

@end

@implementation BinzRegionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 调用先添加下拉菜单
    [self dropdownMenu];
    // 设置在弹出框中的大小
    self.preferredContentSize = self.view.size;
}

#pragma mark - lazy

- (BinzDropdownMenu *)dropdownMenu{
    if (!_dropdownMenu) {
        BinzDropdownMenu *dropdownMenu = [BinzDropdownMenu dropdownMenu];
        // 设置数据源
        dropdownMenu.dataSource = self;
        // 设置代理
        dropdownMenu.delegate = self;
        // 添加dropdownMenu
        [self.view addSubview:dropdownMenu];
        // 顶部view
        UIView *topView = [self.view.subviews firstObject];
        // 约束顶部
        [dropdownMenu autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:topView];
        // 约束边距
        [dropdownMenu autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero excludingEdge:ALEdgeTop];
        self.dropdownMenu = dropdownMenu;
    }
    return _dropdownMenu;
}


#pragma mark - BinzDropdownMenuDataSource

- (NSUInteger)numberOfSectionsInDropdownMenu:(BinzDropdownMenu *)dropdownMenu{
    return 1;
}

- (NSUInteger)dropdownMenu:(BinzDropdownMenu *)dropdownMenu numberOfRowsInSection:(NSUInteger)section{
    return self.displayRegions.count;
}

- (id<BinzDropdownMenuItem>)dropdownMenu:(BinzDropdownMenu *)dropdownMenu itemForRowAtIndexPath:(NSIndexPath *)indexPath{
    return self.displayRegions[indexPath.row];
}

#pragma mark - BinzDropdownMenuDelegate

- (void)dropdownMenu:(BinzDropdownMenu *)dropdownMenu didSelectAtIndexPathInMain:(NSIndexPath *)indexPath{
    id<BinzDropdownMenuItem> item = [self.dropdownMenu.dataSource dropdownMenu:self.dropdownMenu itemForRowAtIndexPath:indexPath];
    if ([item subtitles].count == 0) { // 无子分类
        NSMutableDictionary *userInfo = [NSMutableDictionary dictionary];
        userInfo[BinzSelectedRegion] = item;
        [BinzNotificationCenter postNotificationName:BinzRegionDidSelectNotification object:self userInfo:userInfo];
    }
}

- (void)dropdownMenu:(BinzDropdownMenu *)dropdownMenu didSelectAtIndexPathInSub:(NSIndexPath *)subIndexPath forMainIndexPath:(NSIndexPath *)mainIndexPath{
    NSMutableDictionary *userInfo = [NSMutableDictionary dictionary];
    id<BinzDropdownMenuItem> item = [self.dropdownMenu.dataSource dropdownMenu:self.dropdownMenu itemForRowAtIndexPath:mainIndexPath];
    userInfo[BinzSelectedRegion] = item;
    userInfo[BinzSelectedSubRegion] = [item subtitles][subIndexPath.row];
    [BinzNotificationCenter postNotificationName:BinzRegionDidSelectNotification object:self userInfo:userInfo];
}

#pragma mark - 公共接口

- (IBAction)changeCityButtonDidClick:(UIButton *)sender {
    if (self.changeCityComplentionHandler) {
        self.changeCityComplentionHandler();
    }
}

- (void)setDisplayRegions:(NSArray *)displayRegions{
    _displayRegions = displayRegions;
    // 刷新表格
    [self.dropdownMenu reloadData];
}

- (void)setSelectedRegion:(BinzRegion *)selectedRegion{
    _selectedRegion = selectedRegion;
    NSInteger mainRow = [self.displayRegions indexOfObject:self.selectedRegion];
    NSIndexPath *mainIndexPath = [NSIndexPath indexPathForRow:mainRow inSection:0];
    [self.dropdownMenu selectMainRowAtIndexPath:mainIndexPath];
}

- (void)setSelecteSubRegionName:(NSString *)selecteSubRegionName{
    if (selecteSubRegionName == nil) {
        return;
    }
    _selecteSubRegionName = selecteSubRegionName;
    NSInteger mainRow = [self.displayRegions indexOfObject:self.selectedRegion];
    NSIndexPath *mainIndexPath = [NSIndexPath indexPathForRow:mainRow inSection:0];
    NSInteger subRow = [self.selectedRegion.subregions indexOfObject:self.selecteSubRegionName];
    NSIndexPath *subIndexPath = [NSIndexPath indexPathForRow:subRow inSection:0];
    [self.dropdownMenu selectSubRowAtIndexPath:subIndexPath ofMainRowAtIndexPath:mainIndexPath];
}

@end
