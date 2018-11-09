//
//  BinzDropdownSubCell.m
//  XiaoTuanTuanHD
//
//  Created by 张彬 on 2018/8/12.
//  Copyright © 2018年 bin.z. All rights reserved.
//

#import "BinzDropdownSubCell.h"

@implementation BinzDropdownSubCell

+ (instancetype)dropdownSubCellWithTableView:(UITableView *)tableView{
    static NSString *identifier = @"sub";
    BinzDropdownSubCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if(!cell){
        cell = [[BinzDropdownSubCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        // 设置普通背景
        UIImageView *backgroundView = [[UIImageView alloc] init];
        backgroundView.image = [UIImage imageNamed:@"bg_dropdown_rightpart"];
        [self setBackgroundView:backgroundView];
        // 设置选中背景
        UIImageView *selectedBackgroundView = [[UIImageView alloc] init];
        selectedBackgroundView.image = [UIImage imageNamed:@"bg_dropdown_right_selected"];
        [self setSelectedBackgroundView:selectedBackgroundView];
    }
    return self;
}

@end
