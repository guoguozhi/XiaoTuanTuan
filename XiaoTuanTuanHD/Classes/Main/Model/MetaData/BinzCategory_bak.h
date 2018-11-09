//
//  BinzCategory.h
//  XiaoTuanTuanHD
//
//  Created by 张彬 on 2018/8/9.
//  Copyright © 2018年 bin.z. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BinzDropdownMenu.h"

@interface BinzCategory_bak : NSObject <BinzDropdownMenuItem>

/** 名称 */
@property (nonatomic, copy) NSString *name;
/** 大图标 */
@property (nonatomic, copy) NSString *icon;
/** 大图标高亮 */
@property (nonatomic, copy) NSString *highlighted_icon;
/** 小图标 */
@property (nonatomic, copy) NSString *small_icon;
/** 小图标高亮 */
@property (nonatomic, copy) NSString *small_highlighted_icon;
/** 子分类 */
@property (nonatomic, strong) NSArray *subcategories;

@end
