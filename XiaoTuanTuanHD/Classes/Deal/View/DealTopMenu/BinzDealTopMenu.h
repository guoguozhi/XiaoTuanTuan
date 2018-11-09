//
//  BinzDealTopMenu.h
//  XiaoTuanTuanHD
//
//  Created by 张彬 on 2018/8/11.
//  Copyright © 2018年 bin.z. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BinzDealTopMenu : UIView

/** 图标按钮 */
@property (weak, nonatomic) IBOutlet UIButton *imageButton;
/** 标题 */
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
/** 子标题 */
@property (weak, nonatomic) IBOutlet UILabel *subtitleLabel;

+ (instancetype)dealTopMenu;
// 点击按钮
- (void)addTarget:(id) target action:(SEL) selector;

@end
