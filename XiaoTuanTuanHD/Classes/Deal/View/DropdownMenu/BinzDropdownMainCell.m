//
//  BinzDropdownMainCell.m
//  XiaoTuanTuanHD
//
//  Created by 张彬 on 2018/8/12.
//  Copyright © 2018年 bin.z. All rights reserved.
//

#import "BinzDropdownMainCell.h"

@interface BinzDropdownMainCell ()

/** 右边的箭头 */
@property (nonatomic, strong) UIImageView *rightArrow;

@end


@implementation BinzDropdownMainCell

#pragma mark - lazy

- (UIImageView *)rightArrow{
    if (!_rightArrow) {
        _rightArrow = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_cell_rightArrow"]];
    }
    return _rightArrow;
}

#pragma mark - 初始化方法

+ (instancetype)dropdownMainCellWithTableView:(UITableView *)tableView{
    static NSString *identifier = @"main";
    BinzDropdownMainCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if(!cell){
        cell = [[BinzDropdownMainCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        // 设置普通背景
        UIImageView *backgroundView = [[UIImageView alloc] init];
        backgroundView.image = [UIImage imageNamed:@"bg_dropdown_leftpart"];
        [self setBackgroundView:backgroundView];
        // 设置选中背景
        UIImageView *selectedBackgroundView = [[UIImageView alloc] init];
        selectedBackgroundView.image = [UIImage imageNamed:@"bg_dropdown_left_selected"];
        [self setSelectedBackgroundView:selectedBackgroundView];
    }
    return self;
}

- (void)setItem:(id<BinzDropdownMenuItem>)item{
    _item = item;
    // 标题
    self.textLabel.text = item.title;
    // 图标
    if ([item respondsToSelector:@selector(iconName)]) {
        self.imageView.image = [UIImage imageNamed:item.iconName];
    }
    // 高亮图标
    if ([item respondsToSelector:@selector(highlightedIconName)]) {
         self.imageView.highlightedImage = [UIImage imageNamed:item.highlightedIconName];
    }
    // 箭头
    if (item.subtitles.count > 0) { // 有箭头
        self.accessoryView = self.rightArrow;
    } else { // 无箭头
        self.accessoryView = nil;
    }
}

@end
