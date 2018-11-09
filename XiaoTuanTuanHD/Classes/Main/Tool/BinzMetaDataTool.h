//
//  BinzMetaDataTool.h
//  XiaoTuanTuanHD
//
//  Created by 张彬 on 2018/8/9.
//  Copyright © 2018年 bin.z. All rights reserved.
//  元数据工具类

#import <Foundation/Foundation.h>
#import "BinzSingleton.h"

@class BinzCategory, BinzCity, BinzRegion, BinzSort;

@interface BinzMetaDataTool : NSObject

/** 分类 */
@property (nonatomic, strong, readonly) NSArray *categories;
/** 城市 */
@property (nonatomic, strong, readonly) NSArray *cities;
/** 城市组 */
@property (nonatomic, strong, readonly) NSArray *cityGroups;
/** 排序 */
@property (nonatomic, strong, readonly) NSArray *sorts;

BinzSingletonH(MetaDataTool)

/** 根据分类名称获取分类 */
- (BinzCategory *)categoryWithName:(NSString *)name;
/** 根据城市名称获取城市 */
- (BinzCity *)cityWithName:(NSString *)name;

#pragma mark - 保存到沙盒

/** 保存选中的大分类名称 */
- (BOOL)saveSelectedCategoryName:(NSString *)categoryName;
/** 读取选中的大分类名称 */
- (NSString *)selectedCategoryName;
/** 读取选中的大分类 */
- (BinzCategory *)selectedCategory;
/** 保存选中的子分类名称 */
- (BOOL)saveSelectedSubCategoryName:(NSString *)subCategoryName;
/** 读取选中的子分类名称 */
- (NSString *)selectedSubCateoryName;

/** 保存最近访问的城市 */
- (void)saveRecentVisitCityName:(NSString *)cityName;
/** 读取选中的城市(上一次最后访问的城市) 用户第一次进入主界面调用一次 */
- (BinzCity *)selectedCity;
/** 保存选中的区域名称 */
- (BOOL)saveSelectedRegionName:(NSString *)regionName;
/** 读取选中的区域名称 */
- (NSString *)selectedRegionName;
/** 读取选中的区域 */
- (BinzRegion *)selectedRegion;
/** 保存选中的子区域名称 */
- (BOOL)saveSelectedSubRegionName:(NSString *)subRegionName;
/** 读取选中的子区域名称 */
- (NSString *)selectedSubRegionName;

/** 保存选中的排序 */
- (void)saveSelectedSort:(BinzSort *)sort;
/** 读取选中的排序 */
- (BinzSort *)selectedSort;

@end
