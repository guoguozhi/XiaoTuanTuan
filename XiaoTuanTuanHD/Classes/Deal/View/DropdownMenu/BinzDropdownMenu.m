//
//  BinzDropdownMenu.m
//  XiaoTuanTuanHD
//
//  Created by 张彬 on 2018/8/12.
//  Copyright © 2018年 bin.z. All rights reserved.
//

#import "BinzDropdownMenu.h"
#import "BinzDropdownMainCell.h"
#import "BinzDropdownSubCell.h"

@interface BinzDropdownMenu () <UITableViewDataSource,UITableViewDelegate>

/** 大分类tableView */
@property (weak, nonatomic) IBOutlet UITableView *mainTableView;
/** 小分类tableView */
@property (weak, nonatomic) IBOutlet UITableView *subTableView;

@end

@implementation BinzDropdownMenu

+ (instancetype)dropdownMenu{
    return [[[NSBundle mainBundle] loadNibNamed:@"BinzDropdownMenu" owner:nil options:nil] firstObject];
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if (tableView == self.mainTableView) { // 大分类
        if ([self.dataSource respondsToSelector:@selector(numberOfSectionsInDropdownMenu:)]) {
            return [self.dataSource numberOfSectionsInDropdownMenu:self];
        } else{
            return 1;
        }
    } else { // 小分类
        return 1; // 暂时只有一组
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (tableView == self.mainTableView) { // 大分类
        return [self.dataSource dropdownMenu:self numberOfRowsInSection:section];
    } else { // 小分类
        // 获取大分类选中的cell
        NSIndexPath *indexPathForSelectedRow = [self.mainTableView indexPathForSelectedRow];
        // 取得模型
        id<BinzDropdownMenuItem> item = [self.dataSource dropdownMenu:self itemForRowAtIndexPath:indexPathForSelectedRow];
        // 返回行数
        return item.subtitles.count;
    }
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == self.mainTableView) {
        // 创建mainCell
        BinzDropdownMainCell *mainCell = [BinzDropdownMainCell dropdownMainCellWithTableView:tableView];
        // 传递模型
        mainCell.item = [self.dataSource dropdownMenu:self itemForRowAtIndexPath:indexPath];
        return mainCell;
    } else {
        BinzDropdownSubCell *subCell = [BinzDropdownSubCell dropdownSubCellWithTableView:tableView];
        // 获取大分类选中的cell
        NSIndexPath *indexPathForSelectedRow = [self.mainTableView indexPathForSelectedRow];
        // 取得模型
        id<BinzDropdownMenuItem> item = [self.dataSource dropdownMenu:self itemForRowAtIndexPath:indexPathForSelectedRow];
        // 设置标题
        subCell.textLabel.text = item.subtitles[indexPath.row];
        return subCell;
    }
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == self.mainTableView) { // 大分类
        [self.subTableView reloadData];
        if ([self.delegate respondsToSelector:@selector(dropdownMenu:didSelectAtIndexPathInMain:)]) {
            [self.delegate dropdownMenu:self didSelectAtIndexPathInMain:indexPath];
        }
    } else {// 小分类
        if ([self.delegate respondsToSelector:@selector(dropdownMenu:didSelectAtIndexPathInSub:forMainIndexPath:)]) {
            // 大分类选中的indexPath
            NSIndexPath *mainIndexPath = [self.mainTableView indexPathForSelectedRow];
            [self.delegate dropdownMenu:self didSelectAtIndexPathInSub:indexPath forMainIndexPath:mainIndexPath];
        }
    }
}

#pragma mark - 公共方法

- (void)reloadData {
    // 刷新大分类表格
    [self.mainTableView reloadData];
    // 刷新小分类表格
    [self.subTableView reloadData];
}

- (void)selectMainRowAtIndexPath:(NSIndexPath *)indexPath {
    // 选中
    [self.mainTableView selectRowAtIndexPath:indexPath animated:YES scrollPosition:UITableViewScrollPositionMiddle];
}

- (void)selectSubRowAtIndexPath:(NSIndexPath *)subIndexPath ofMainRowAtIndexPath:(NSIndexPath *)mainIndexPath {
    // 刷新右侧数据
    [self.subTableView reloadData];
    // 选中
    [self.subTableView selectRowAtIndexPath:subIndexPath animated:YES scrollPosition:UITableViewScrollPositionMiddle];
}

@end
