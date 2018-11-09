//
//  BinzCategoryViewController.h
//  XiaoTuanTuanHD
//
//  Created by 张彬 on 2018/8/12.
//  Copyright © 2018年 bin.z. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BinzCategory;

@interface BinzCategoryViewController : UIViewController

/** 选中的分类 */
@property (nonatomic, strong) BinzCategory *selectedCategory;
/** 选中的子分类名称 */
@property (nonatomic, strong) NSString *selectedSubCategoryName;

@end
