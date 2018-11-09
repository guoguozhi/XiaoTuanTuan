//
//  BinzDropdownMainCell.h
//  XiaoTuanTuanHD
//
//  Created by 张彬 on 2018/8/12.
//  Copyright © 2018年 bin.z. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BinzDropdownMenu.h"

@interface BinzDropdownMainCell : UITableViewCell

@property (nonatomic, strong) id<BinzDropdownMenuItem> item;

+ (instancetype)dropdownMainCellWithTableView:(UITableView *) tableView;

@end
