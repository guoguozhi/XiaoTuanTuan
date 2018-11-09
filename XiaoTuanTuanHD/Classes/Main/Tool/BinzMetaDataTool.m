//
//  BinzMetaDataTool.m
//  XiaoTuanTuanHD
//
//  Created by 张彬 on 2018/8/9.
//  Copyright © 2018年 bin.z. All rights reserved.
//

#import "BinzMetaDataTool.h"
#import "MJExtension.h"
#import "BinzCategory.h"
#import "BinzCity.h"
#import "BinzRegion.h"
#import "BinzCityGroup.h"
#import "BinzSort.h"

#define BinzCategoryNameKey @"BinzCategoryNameKey"
#define BinzSubCategoryNameKey @"BinzSubCategoryNameKey"
#define BinzRegionNameKey @"BinzRegionNameKey"
#define BinzSubRegionNameKey @"BinzSubRegionNameKey"

#pragma mark - 路径规划

/*
 *  /Documents/user/recent_visit_cities.plist
 *  /Documents/user/selected_sort.plist
 */

// 最近访问的城市名称路径
#define BinzRecentVisitCityNamesPath [UserDirectory stringByAppendingPathComponent:@"recent_visit_cities.plist"]
// 选中的排序路径
#define BinzSelectedSortPath [UserDirectory stringByAppendingPathComponent:@"selected_sort.plist"]

@interface BinzMetaDataTool (){
    /** 所有的分类 */
    NSArray *_categories;
    /** 所有的城市 */
    NSArray *_cities;
    /** 所有的排序 */
    NSArray *_sorts;
}

/** 最近访问的城市(时刻和沙盒保持数据一致) 越靠前越最新访问*/
@property (nonatomic, strong) NSMutableArray *recentVisitCityNames;

@end

@implementation BinzMetaDataTool

- (NSArray *)categories{
    if (!_categories) {
        _categories = [BinzCategory mj_objectArrayWithFilename:@"metadata_get_categories_with_deals.plist"];
    }
    return _categories;
}

- (NSArray *)cities{
    if (!_cities) {
        _cities = [BinzCity mj_objectArrayWithFilename:@"cities.plist"];
    }
    return _cities;
}

- (NSArray *)cityGroups{
    // plist的城市组
    NSMutableArray *cityGroups = [BinzCityGroup mj_objectArrayWithFilename:@"cityGroups.plist"];
    // 从沙盒读取
    NSArray *recentVisitCities = [NSArray arrayWithContentsOfFile:BinzRecentVisitCityNamesPath];
    if (recentVisitCities.count > 0) {
        // 最近访问的城市组
        BinzCityGroup *recentVisitCityGroup = [[BinzCityGroup alloc] init];
        recentVisitCityGroup.title = @"最近";
        recentVisitCityGroup.cities = recentVisitCities;
        // 插入最近访问的城市组
        [cityGroups insertObject:recentVisitCityGroup atIndex:0];
    }
    return cityGroups;
}

- (NSArray *)sorts{
    if (!_sorts) {
        _sorts = [BinzSort mj_objectArrayWithFilename:@"sorts.plist"];
    }
    return _sorts;
}

BinzSingletonM(MetaDataTool)

#pragma mark - 懒加载

- (NSMutableArray *)recentVisitCityNames{
    if (!_recentVisitCityNames) {
        // 读取沙盒
        _recentVisitCityNames = [NSMutableArray arrayWithContentsOfFile:BinzRecentVisitCityNamesPath];
        if (!_recentVisitCityNames) { // 读取不到
            _recentVisitCityNames = [NSMutableArray array];
        }
    }
    return _recentVisitCityNames;
}

#pragma mark - 公共方法

- (BinzCategory *)categoryWithName:(NSString *)name{
    if ([name isEqualToString:@""]||name == nil) {
        return nil;
    }
    __block BinzCategory *category = nil;
    [self.categories enumerateObjectsUsingBlock:^(BinzCategory *category2, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([name isEqualToString:category2.name]) {
            category = category2;
            *stop = YES;
        }
    }];
    return category;
}

- (BinzCity *)cityWithName:(NSString *)name{
    if ([name isEqualToString:@""] || name == nil) {
        return nil;
    }
    for (int i = 0 ; i < self.cities.count; i++) {
        BinzCity *city = self.cities[i];
        if ([city.name isEqualToString:name]) {
            return city;
        }
    }
    return nil;
}

#pragma mark - 记录用户的分类

// 保存选中的大分类名称
- (BOOL)saveSelectedCategoryName:(NSString *)categoryName{
    [binzUserDefaults setObject:categoryName forKey:BinzCategoryNameKey];
    // 同步数据
    return [binzUserDefaults synchronize];
}

// 读取选中的大分类名称
- (NSString *)selectedCategoryName{
    NSString *selectedCategoryName = [binzUserDefaults objectForKey:BinzCategoryNameKey];
    if (selectedCategoryName == nil) {
        BinzCategory *category = [self.categories firstObject];
        selectedCategoryName = category.name;
    }
    return selectedCategoryName;
}

// 读取选中的大分类
- (BinzCategory *)selectedCategory{
    __block BinzCategory *selectedCategory = nil;
    NSString *categoryName = [self selectedCategoryName];
    [self.categories enumerateObjectsUsingBlock:^(BinzCategory *category, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([category.name isEqualToString:categoryName]) {
            selectedCategory = category;
            *stop = YES;
        }
    }];
    return selectedCategory;
}

// 保存选中的小分类名称
- (BOOL)saveSelectedSubCategoryName:(NSString *)subCategoryName{
    [binzUserDefaults setObject:subCategoryName forKey:BinzSubCategoryNameKey];
    return [binzUserDefaults synchronize];
}

// 读取选中的小分类名称
- (NSString *)selectedSubCateoryName{
    NSString *selectedSubCateoryName = [binzUserDefaults objectForKey:BinzSubCategoryNameKey];
    if (selectedSubCateoryName == nil) {
        BinzCategory *selectedCategory = [self selectedCategory];
        selectedSubCateoryName = [selectedCategory.subcategories firstObject];
    }
    return selectedSubCateoryName;
}

#pragma mark - 记录用户的城市、区域

// 保存最近访问的城市
- (void)saveRecentVisitCityName:(NSString *)cityName{
    NSLog(@"最近访问的城市:%@", BinzRecentVisitCityNamesPath);
    if (cityName == nil || [cityName isEqualToString:@""]) {
        return ;
    }
    // 删除重复的城市名称
    [self.recentVisitCityNames removeObject:cityName];
    // 添加到最前面
    [self.recentVisitCityNames insertObject:cityName atIndex:0];
    // 检测最近访问城市的个数
    if ([self.recentVisitCityNames count] > BinzDefaultRecentVisitNumberOfCities) {
        [self.recentVisitCityNames removeLastObject];
    }
    // 保存沙盒
    [self.recentVisitCityNames writeToFile:BinzRecentVisitCityNamesPath atomically:YES];
    
    // 保存选中城市的第一个区域名称及第一个区域的第一个子区域名称
    BinzCity *city = [self cityWithName:cityName];
    // 第一个区域
    BinzRegion *firstRegion = [city.regions firstObject];
    NSString *regionName = firstRegion.name;
    [binzUserDefaults setObject:regionName forKey:BinzRegionNameKey];
    // 第一个子区域
    NSString *subRegionName = [firstRegion.subregions firstObject];
    [binzUserDefaults setObject:subRegionName forKey:BinzSubRegionNameKey];
    [binzUserDefaults synchronize];
}

// 读取选中的城市
- (BinzCity *)selectedCity{
    NSString *selectedCityName = [self.recentVisitCityNames firstObject];
    BinzCity *selectedCity = [self cityWithName:selectedCityName];
    if (selectedCity == nil) {
        // 设置默认城市
        selectedCity = [self cityWithName:BinzDefaultCityName];
    }
    return selectedCity;
}

// 保存选中的区域名称
- (BOOL)saveSelectedRegionName:(NSString *)regionName{
    [binzUserDefaults setObject:regionName forKey:BinzRegionNameKey];
    return [binzUserDefaults synchronize];
}

// 读取选中的区域名称
- (NSString *)selectedRegionName{
    NSString *selectedRegionName = [binzUserDefaults objectForKey:BinzRegionNameKey];
    if (selectedRegionName == nil) {
        // 默认取选中城市的第一个区域
        BinzCity *selectedCity = [self selectedCity];
        BinzRegion *firstRegion = [selectedCity.regions firstObject];
        selectedRegionName = firstRegion.name;
    }
    return selectedRegionName;
}

// 读取选中的区域
- (BinzRegion *)selectedRegion{
    // 选中的城市
    BinzCity *selectedCity = [self selectedCity];
    // 选中的区域名称
    NSString *selectedRegionName = [self selectedRegionName];
    return [self regionWithRegionName:selectedRegionName inCityName:selectedCity.name];
}

// 获得某个城市的某个区域
- (BinzRegion *)regionWithRegionName:(NSString *)regionName inCityName:(NSString *)cityName{
    __block BinzRegion *returnRegion = nil;
    BinzCity *city = [self cityWithName:cityName];
    // 遍历区域
    [city.regions enumerateObjectsUsingBlock:^(BinzRegion *region, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([region.name isEqualToString:regionName]) {
            returnRegion = region;
            *stop = YES;
        }
    }];
    return returnRegion;
}

// 保存选中的子区域名称
- (BOOL)saveSelectedSubRegionName:(NSString *)subRegionName{
    [binzUserDefaults setObject:subRegionName forKey:BinzSubRegionNameKey];
    return [binzUserDefaults synchronize];
}

// 读取选中的子区域名称
- (NSString *)selectedSubRegionName{
    NSString *selectedSubRegionName = [binzUserDefaults objectForKey:BinzSubRegionNameKey];
    if (selectedSubRegionName == nil) {
        // 默认取第一个选中城市的第一个区域的第一个子区域
        BinzCity *selectedCity = [self selectedCity];
        // 第一个区域
        BinzRegion *firstRegion = [selectedCity.regions firstObject];
        if (firstRegion.subregions) { // 存在子区域
            // 第一个子区域名称
            selectedSubRegionName = [firstRegion.subregions firstObject];
        }
    }
    return selectedSubRegionName;
}

#pragma mark - 记录用户的排序

// 保存选中的排序
- (void)saveSelectedSort:(BinzSort *)sort{
    if (sort == nil) {
        return ;
    }
    [NSKeyedArchiver archiveRootObject:sort toFile:BinzSelectedSortPath];
}

// 读取选中的排序
- (BinzSort *)selectedSort{
    BinzSort *selectedSort = [NSKeyedUnarchiver unarchiveObjectWithFile:BinzSelectedSortPath];
    if (selectedSort == nil) {
        // 默认排序
        selectedSort = [self.sorts firstObject];
    }
    return selectedSort;
}

@end
