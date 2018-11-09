//
//  BinzCategoryViewController.m
//  XiaoTuanTuanHD
//
//  Created by 张彬 on 2018/8/12.
//  Copyright © 2018年 bin.z. All rights reserved.
//

#import "BinzCategoryViewController.h"
#import "BinzDropdownMenu.h"
#import "BinzMetaDataTool.h"
#import "BinzCategory.h"

@interface BinzCategoryViewController () <BinzDropdownMenuDataSource, BinzDropdownMenuDelegate>

@property (nonatomic, weak) BinzDropdownMenu *dropdownMenu;

@end

@implementation BinzCategoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.size = CGSizeMake(400, 480);
    // 调用先添加下拉菜单
    [self dropdownMenu];
    self.preferredContentSize = self.view.size;
}

#pragma mark - lazy

- (BinzDropdownMenu *)dropdownMenu{
    if (!_dropdownMenu) {
        // 创建下拉菜单
        BinzDropdownMenu *dropdownMenu = [BinzDropdownMenu dropdownMenu];
        // 设置数据源
        dropdownMenu.dataSource = self;
        // 设置代理
        dropdownMenu.delegate = self;
        // 添加到view中
        [self.view addSubview:dropdownMenu];
        dropdownMenu.height = self.view.height;
        self.dropdownMenu = dropdownMenu;
    }
    return _dropdownMenu;
}

#pragma mark - BinzDropdownMenuDataSource

- (NSUInteger)numberOfSectionsInDropdownMenu:(BinzDropdownMenu *)dropdownMenu{
    return 1;
}

- (NSUInteger)dropdownMenu:(BinzDropdownMenu *)dropdownMenu numberOfRowsInSection:(NSUInteger)section{
    return binzMetaDataTool.categories.count;
}

- (id<BinzDropdownMenuItem>)dropdownMenu:(BinzDropdownMenu *)dropdownMenu itemForRowAtIndexPath:(NSIndexPath *)indexPath{
    return binzMetaDataTool.categories[indexPath.row];
}

#pragma mark - BinzDropdownMenuDelegate

- (void)dropdownMenu:(BinzDropdownMenu *)dropdownMenu didSelectAtIndexPathInMain:(NSIndexPath *)indexPath{
    id<BinzDropdownMenuItem> item = [self.dropdownMenu.dataSource dropdownMenu:self.dropdownMenu itemForRowAtIndexPath:indexPath];
    if ([item subtitles].count == 0) { // 无子分类
        NSMutableDictionary *userInfo = [NSMutableDictionary dictionary];
        userInfo[BinzSelectedMainCategory] = item;
        [BinzNotificationCenter postNotificationName:BinzCategoryDidSelectNotification object:self userInfo:userInfo];
    }
}

- (void)dropdownMenu:(BinzDropdownMenu *)dropdownMenu didSelectAtIndexPathInSub:(NSIndexPath *)subIndexPath forMainIndexPath:(NSIndexPath *)mainIndexPath{
     NSMutableDictionary *userInfo = [NSMutableDictionary dictionary];
    id<BinzDropdownMenuItem> item = [self.dropdownMenu.dataSource dropdownMenu:self.dropdownMenu itemForRowAtIndexPath:mainIndexPath];
    userInfo[BinzSelectedMainCategory] = item;
    userInfo[BinzSelectedSubCategory] = [item subtitles][subIndexPath.row];
    [BinzNotificationCenter postNotificationName:BinzCategoryDidSelectNotification object:self userInfo:userInfo];
}

#pragma mark - 公共方法

- (void)setSelectedCategory:(BinzCategory *)selectedCategory{
    if (selectedCategory == nil) { // 选中的大分类不存在时，不必选中
        return ;
    }
    // 保存属性
    _selectedCategory = selectedCategory;
    // 选中大分类
    NSInteger row = [binzMetaDataTool.categories indexOfObject:selectedCategory];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:row inSection:0];
    [self.dropdownMenu selectMainRowAtIndexPath:indexPath];
}

- (void)setSelectedSubCategoryName:(NSString *)selectedSubCategoryName{
    if (selectedSubCategoryName == nil || self.selectedCategory == nil) { // 选中的大/小分类不存在时，不必选中
        return ;
    }
    // 保存属性
    _selectedSubCategoryName = selectedSubCategoryName;
    // 选中小分类
    NSInteger mainRow = [binzMetaDataTool.categories indexOfObject:self.selectedCategory];
    NSIndexPath *mainIndexPath = [NSIndexPath indexPathForRow:mainRow inSection:0];
    NSInteger subRow = [self.selectedCategory.subtitles indexOfObject:selectedSubCategoryName];
    NSIndexPath *subIndexPath = [NSIndexPath indexPathForRow:subRow inSection:0];
    [self.dropdownMenu selectSubRowAtIndexPath:subIndexPath ofMainRowAtIndexPath:mainIndexPath];
}

@end
