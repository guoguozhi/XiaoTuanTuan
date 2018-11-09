//
//  BinzDropdownMenu.h
//  XiaoTuanTuanHD
//
//  Created by 张彬 on 2018/8/12.
//  Copyright © 2018年 bin.z. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BinzDropdownMenu;

@protocol BinzDropdownMenuItem <NSObject>

@required
/** 标题 */
@property (nonatomic, copy, readonly) NSString *title;
/** 子标题数组 */
@property (nonatomic, strong, readonly) NSArray<NSString *> *subtitles;
@optional
/** normal状态的图标名称 */
@property (nonatomic, copy, readonly) NSString *iconName;
/** highlighted状态的图标名称 */
@property (nonatomic, copy, readonly) NSString *highlightedIconName;

@end

// 数据源
@protocol BinzDropdownMenuDataSource <NSObject>

@required
// 每一组有多少行模型数据
- (NSUInteger)dropdownMenu:(BinzDropdownMenu *) dropdownMenu numberOfRowsInSection:(NSUInteger) section;
// 每一行的模型数据
- (id<BinzDropdownMenuItem>)dropdownMenu:(BinzDropdownMenu *) dropdownMenu itemForRowAtIndexPath:(NSIndexPath *) indexPath;
@optional
// 一共有多少组模型数据
- (NSUInteger)numberOfSectionsInDropdownMenu:(BinzDropdownMenu *) dropdownMenu;

@end

// 代理
@protocol BinzDropdownMenuDelegate <NSObject>

@optional
/** 选中了大分类的indexPath */
- (void)dropdownMenu:(BinzDropdownMenu *)dropdownMenu didSelectAtIndexPathInMain:(NSIndexPath *)indexPath;
/** 选中了大分类mainIndexPath中的小分类subIndexPath */
- (void)dropdownMenu:(BinzDropdownMenu *)dropdownMenu didSelectAtIndexPathInSub:(NSIndexPath *) subIndexPath forMainIndexPath:(NSIndexPath *) mainIndexPath;

@end

@interface BinzDropdownMenu : UIView

/** 数据源 */
@property (nonatomic, weak) id<BinzDropdownMenuDataSource> dataSource;
/** 代理 */
@property (nonatomic, weak) id<BinzDropdownMenuDelegate> delegate;

/** 创建下拉菜单 */
+ (instancetype)dropdownMenu;

/** 加载数据 */
- (void)reloadData;

/** 选中哪个大分类 */
- (void)selectMainRowAtIndexPath:(NSIndexPath *) indexPath;
/** 选中哪个大分类下的小分类 */
- (void)selectSubRowAtIndexPath:(NSIndexPath *) subIndexPath ofMainRowAtIndexPath:(NSIndexPath *) mainIndexPath;

@end
