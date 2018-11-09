//
//  BinzDealViewControllerCollectionViewController.m
//  XiaoTuanTuanHD
//
//  Created by 张彬 on 2018/8/6.
//  Copyright © 2018年 bin.z. All rights reserved.
//
#import "BinzDealViewController.h"
#import "BinzDealTopMenu.h"
#import "AwesomeMenu.h"
#import "AwesomeMenuItem.h"
#import "BinzCategoryViewController.h"
#import "BinzRegionViewController.h"
#import "BinzSortViewController.h"
#import "BinzCityViewController.h"
#import "BinzMetaDataTool.h"
#import "BinzCategory.h"
#import "BinzCity.h"
#import "BinzRegion.h"
#import "BinzSort.h"
#import "BinzDealService.h"
#import "BinzFindDealParam.h"
#import "BinzFindDealResult.h"
#import "BinzDeal.h"
#import "BinzDealCell.h"
#import "MJExtension.h"
#import "MJRefresh.h"
#import "BinzNavigationController.h"
#import "BinzCollectDealController.h"
#import "BinzHistoryDealController.h"

@interface BinzDealViewController ()<AwesomeMenuDelegate,UICollectionViewDataSource,UICollectionViewDelegate>

/** 分类菜单 */
@property (nonatomic, weak) BinzDealTopMenu *categoryMenu;
/** 区域菜单 */
@property (nonatomic, weak) BinzDealTopMenu *regionMenu;
/** 排序菜单 */
@property (nonatomic, weak) BinzDealTopMenu *sortMenu;
/** 分类弹出框 */
@property (nonatomic, strong) UIPopoverController *categoryPopoverController;
/** 区域弹出框 */
@property (nonatomic, strong) UIPopoverController *regionPopoverController;
/** 排序弹出框 */
@property (nonatomic, strong) UIPopoverController *sortPopoverController;

/** 选中的分类 */
@property (nonatomic, strong) BinzCategory *selectedCategory;
/** 选中的子分类名称 */
@property (nonatomic, strong) NSString *selectedSubCategoryName;
/** 选中的城市 */
@property (nonatomic, strong) BinzCity *selectedCity;
/** 选中的区域 */
@property (nonatomic, strong) BinzRegion *selectedRegion;
/** 选中的子区域名称 */
@property (nonatomic, copy) NSString *selecteSubRegionName;
/** 选中的排序 */
@property (nonatomic, strong) BinzSort *selectedSort;
/** 总记录数 */
@property (nonatomic, assign) int totalCount;
/** 最后一次的请求参数 */
@property (nonatomic, strong) BinzFindDealParam *lastestFindDealParam;

@end

@implementation BinzDealViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 设置导航栏左边的内容
    [self setupNavLeft];
    // 设置导航栏右边的内容
    [self setupNavRight];
    // 设置用户菜单
    [self setupUserMenu];
    // 集成MJ刷新控件
    [self addRefreshComponent];
    // 监听通知
    [self observeNotification];
    // 依据默认条件第一次查询团购数据
    [self.collectionView.mj_header beginRefreshing];
}

#pragma mark - 刷新控件

- (void)addRefreshComponent{
    MJRefreshNormalHeader *header = [[MJRefreshNormalHeader alloc] init];
    // 设置状态
    [header setTitle:@"下拉可刷新." forState:MJRefreshStateIdle];
    [header setTitle:@"松开手就开始刷新." forState:MJRefreshStatePulling];
    [header setTitle:@"即将刷新." forState:MJRefreshStateWillRefresh];
    [header setTitle:@"正在刷新." forState:MJRefreshStateRefreshing];
    [header setTitle:@"刷新完毕." forState:MJRefreshStateNoMoreData];
    // 设置最后更新时间
    header.lastUpdatedTimeText = ^NSString *(NSDate *lastUpdatedTime) {
        NSDate *date = [NSDate date];
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        dateFormatter.dateFormat = @"hh:mm:ss";
        return [NSString stringWithFormat:@"最后更新时间: 今天 %@", [dateFormatter stringFromDate:date]];
    };
    // 设置刷新回调
    [header setRefreshingTarget:self refreshingAction:@selector(loadNewDeals)];
    self.collectionView.mj_header = header;
    MJRefreshAutoNormalFooter *footer = [[MJRefreshAutoNormalFooter alloc] init];
    // 设置状态
    [footer setTitle:@"上拉可刷新." forState:MJRefreshStateIdle];
    [footer setTitle:@"松开手就开始刷新." forState:MJRefreshStatePulling];
    [footer setTitle:@"即将刷新." forState:MJRefreshStateWillRefresh];
    [footer setTitle:@"正在刷新." forState:MJRefreshStateRefreshing];
    [footer setTitle:@"刷新完毕." forState:MJRefreshStateNoMoreData];
    // 设置刷新回调
    [footer setRefreshingTarget:self refreshingAction:@selector(loadMoreDeals)];
    self.collectionView.mj_footer = footer;
}

#pragma mark - 通知

// 监听通知
- (void)observeNotification{
    BinzAddSelfAsObserver(categoryDidSelect:, BinzCategoryDidSelectNotification);
    BinzAddSelfAsObserver(regionDidSelect:, BinzRegionDidSelectNotification);
    BinzAddSelfAsObserver(cityDidSelect:, BinzCityDidSelectNotification);
    BinzAddSelfAsObserver(sortDidSelect:, BinzSortDidSelectNotification);
}

#pragma mark - 通知监听

// 分类选中
- (void)categoryDidSelect:(NSNotification *) notification{
    // 保存选中的区域
    BinzCategory *selectedCategory = notification.userInfo[BinzSelectedMainCategory];
    self.selectedCategory = selectedCategory;
    NSString *selectedSubCategoryName = notification.userInfo[BinzSelectedSubCategory];
    self.selectedSubCategoryName = selectedSubCategoryName;
    // 设置导航条的分类
    // 设置标题
    self.categoryMenu.titleLabel.text = self.selectedCategory.title;
    // 设置子标题
    self.categoryMenu.subtitleLabel.text = self.selectedSubCategoryName;
    // 销毁分类弹出框
    [self.categoryPopoverController dismissPopoverAnimated:YES];
    // 加载团购数据
    [self.collectionView.mj_header beginRefreshing];
#pragma mark - 待改进
    // 保存选中的区域名称、子区域名称
    BOOL saveSelectedCategoryNameResult = [binzMetaDataTool saveSelectedCategoryName:selectedCategory.name];
    if (saveSelectedCategoryNameResult) {
       [binzMetaDataTool saveSelectedSubCategoryName:selectedSubCategoryName];
    }
}

// 区域选中
- (void)regionDidSelect:(NSNotification *) notification{
    BinzRegion *selectedRegion = notification.userInfo[BinzSelectedRegion];
    // 保存选中的区域
    self.selectedRegion = selectedRegion;
    NSString *selectedSubRegionName = notification.userInfo[BinzSelectedSubRegion];
    self.selecteSubRegionName = selectedSubRegionName;
    // 设置导航条的区域
    self.regionMenu.titleLabel.text = [NSString stringWithFormat:@"%@ - %@", self.selectedCity.name, self.selectedRegion.title];
    self.regionMenu.subtitleLabel.text = self.selecteSubRegionName;
    // 销毁区域弹出框
    [self.regionPopoverController dismissPopoverAnimated:YES];
    // 加载团购数据
    [self.collectionView.mj_header beginRefreshing];
    // 保存区域名称、子区域名称
    BOOL saveSelectedRegionNameResult = [binzMetaDataTool saveSelectedRegionName:selectedRegion.name];
    if (saveSelectedRegionNameResult) {
        [binzMetaDataTool saveSelectedSubRegionName:selectedSubRegionName];
    }
}

// 选中城市
- (void)cityDidSelect:(NSNotification *) notification{
    BinzCity *selectedCity = notification.userInfo[BinzSelectedCity];
    // 保存选中的城市
    self.selectedCity = selectedCity;
    BinzRegion *region = [selectedCity.regions firstObject];
    // 第一个区域名称
    NSString *regionName = region.name;
    // 第一个区域的子区域名称
    NSString *subRegionName = [region.subregions firstObject];
    self.regionMenu.titleLabel.text = [NSString stringWithFormat:@"%@-%@", selectedCity.name, regionName];
    self.regionMenu.subtitleLabel.text = subRegionName;
    // 加载团购数据
    [self.collectionView.mj_header beginRefreshing];
    // 保存选中的城市到沙盒
    [binzMetaDataTool saveRecentVisitCityName:selectedCity.name];
}

// 选中排序
- (void)sortDidSelect:(NSNotification *) notification{
    BinzSort *selectedSort = notification.userInfo[BinzSelectedSort];
    // 保存选中的排序
    self.selectedSort = selectedSort;
    self.sortMenu.subtitleLabel.text = selectedSort.label;
    // 关闭排序弹框
    [self.sortPopoverController dismissPopoverAnimated:YES];
    // 加载团购数据
    [self.collectionView.mj_header beginRefreshing];
}

#pragma mark - 加载数据

// 加载最新的团购数据
- (void)loadNewDeals{
    BinzFindDealParam *param = [self createFindDealParam];
    param.page = @(1);
    [BinzDealService findDeal:param success:^(BinzFindDealResult *result) {
        // 判断是否是最后一次请求，非最后一次，忽略响应数据
        if (self.lastestFindDealParam != param) {
            return ;
        }
        // 注意代码的位置(必须放在刷新表格之前)
        self.totalCount = [result.total_count intValue];
        NSArray<BinzDeal *> *deals = result.deals;
        // 因条件改变，查询了新数据，展示新数据，旧数据废弃
        // 因大众点评的接口未提供查询比某条数据更新的数据的接口，因此，每次下拉刷新都是将之前的数据清空，不管之前已经加载了多少条数据
        [self.deals removeAllObjects];
        [self.deals addObjectsFromArray:deals];
        // 刷新collectionView
        [self.collectionView reloadData];
        [self.collectionView.mj_header endRefreshing];
    } failure:^(NSError *error) {
        NSString *errorMessage = [NSString stringWithFormat:@"团购数据加载失败:%@", error.domain];
        // 因MBProgressHUD的问题，在横屏时需要使用showXXX toView，而不能使用showXXX，否则字体颠倒，因横屏时控制器的view是横屏显示的，所有字体也会跟着横屏
        [MBProgressHUD showError:errorMessage toView:self.view];
        [self.collectionView.mj_header endRefreshing];
    }];
    // 保存上一次的请求参数
    self.lastestFindDealParam = param;
}

// 加载更多的团购数据
- (void)loadMoreDeals{
    BinzFindDealParam *param = [self createFindDealParam];
    param.page = @([self.lastestFindDealParam.page intValue] + 1);
    [BinzDealService findDeal:param success:^(BinzFindDealResult *result) {
        if (self.lastestFindDealParam != param) {
            return ;
        }
        // 注意代码的位置
        self.totalCount = [result.total_count intValue];
        NSArray<BinzDeal *> *deals = result.deals;
        [self.deals addObjectsFromArray:deals];
        //NSLog(@"loadMoreDeals -- 总记录数:%d 显示的记录数:%d 上一次显示的记录数:%d", (int)result.total_count, (int)self.deals.count, self.lastestTotalCount);
        // 刷新collectionView
        [self.collectionView reloadData];
        [self.collectionView.mj_footer endRefreshing];
    } failure:^(NSError *error) {
        NSString *errorMessage = [NSString stringWithFormat:@"团购数据加载失败:%@", error.domain];
        [MBProgressHUD showError:errorMessage toView:self.view];
        [self.collectionView.mj_footer endRefreshing];
        // 特别注意，当请求失败以后，需回滚页码值
        param.page = @([param.page intValue] - 1);
    }];
    // 保存上一次的请求参数
    self.lastestFindDealParam = param;
}

// 团购参数条件
- (BinzFindDealParam *)createFindDealParam{
    // 请求参数
    BinzFindDealParam *param = [[BinzFindDealParam alloc] init];
    // 分类条件
    if (self.selectedCategory && ![self.selectedCategory.name isEqualToString:@"全部分类"]) { // 大分类有值但不能是"全部分类"
        if (self.selectedSubCategoryName && ![self.selectedSubCategoryName isEqualToString:@"全部"]) { // 小分类有值但不能是"全部"
            param.category = self.selectedSubCategoryName;
        } else {
            param.category = self.selectedCategory.name;
        }
    }
    // 城市条件
    if (self.selectedCity) {
        param.city = self.selectedCity.name;
    }
    // 区域条件
    if (self.selectedRegion && ![self.selectedRegion.name isEqualToString:@"全部"]) { // 区域有值但不能是"全部"
        if (self.selecteSubRegionName && ![self.selecteSubRegionName isEqualToString:@"全部"]) { // 子区域名称有值但不能是"全部"
            param.region = self.selecteSubRegionName;
        } else {
            param.region = self.selectedRegion.name;
        }
    }
    // 排序条件
    param.sort = self.selectedSort.value;
    param.limit = @(10);
    //NSLog(@"param:%@",param.mj_keyValues);
    return param;
}

#pragma mark - 懒加载

- (UIPopoverController *)categoryPopoverController{
    if (!_categoryPopoverController) {
        BinzCategoryViewController *categoryViewController = [[BinzCategoryViewController alloc] init];
        _categoryPopoverController = [[UIPopoverController alloc] initWithContentViewController:categoryViewController];
    }
    return _categoryPopoverController;
}

- (UIPopoverController *)regionPopoverController{
    if (!_regionPopoverController) {
        BinzRegionViewController *regionViewController = [[BinzRegionViewController alloc] init];
        __weak typeof(self) vc = self;
        regionViewController.changeCityComplentionHandler = ^{
            // 销毁区域弹出框
            [vc.regionPopoverController dismissPopoverAnimated:YES];
            // 展示城市列表控制器
            BinzCityViewController *citiesViewController = [[BinzCityViewController alloc] init];
            citiesViewController.modalPresentationStyle = UIModalPresentationFormSheet;
            [vc presentViewController:citiesViewController animated:YES completion:nil];
        };
        _regionPopoverController = [[UIPopoverController alloc] initWithContentViewController:regionViewController];
    }
    return _regionPopoverController;
}

- (UIPopoverController *)sortPopoverController{
    if (!_sortPopoverController) {
        BinzSortViewController *sortViewController = [[BinzSortViewController alloc] init];
        _sortPopoverController = [[UIPopoverController alloc] initWithContentViewController:sortViewController];
    }
    return _sortPopoverController;
}

#pragma mark - 导航栏左边

- (void)setupNavLeft {
    self.navigationItem.leftBarButtonItems = @[
                                                [self logoItem],
                                                [self categoryItem],
                                                [self regionItem],
                                                [self sortItem]
                                              ];
}

 // logo
- (UIBarButtonItem *)logoItem {
    UIBarButtonItem *logoItem = [UIBarButtonItem barButtonItemWithNormalImageName:@"icon_meituan_logo" highlightedImageName:@"icon_meituan_logo" target:nil action:nil];
    logoItem.customView.width = 100;
    return logoItem;
}

// 分类
- (UIBarButtonItem *)categoryItem {
    BinzDealTopMenu *categoryMenu = [BinzDealTopMenu dealTopMenu];
    [categoryMenu addTarget:self action:@selector(categoryMenuClick)];
    UIBarButtonItem *categoryItem = [[UIBarButtonItem alloc] initWithCustomView:categoryMenu];
    self.categoryMenu = categoryMenu;
    self.selectedCategory = [binzMetaDataTool selectedCategory];
    self.selectedSubCategoryName = [binzMetaDataTool selectedSubCateoryName];
    categoryMenu.titleLabel.text = self.selectedCategory.name;
    categoryMenu.subtitleLabel.text = self.selectedSubCategoryName;
    return categoryItem;
}

// 区域
- (UIBarButtonItem *)regionItem {
    BinzDealTopMenu *regionMenu = [BinzDealTopMenu dealTopMenu];
    regionMenu.imageButton.imageName = @"icon_district";
    regionMenu.imageButton.highlightedImageName = @"icon_district_highlighted";
    self.selectedCity = [binzMetaDataTool selectedCity];
    self.selectedRegion = [binzMetaDataTool selectedRegion];
    self.selecteSubRegionName = [binzMetaDataTool selectedSubRegionName];
    // 城市名称-区域名称
    regionMenu.titleLabel.text = [NSString stringWithFormat:@"%@-%@", self.selectedCity.name, self.selectedRegion.name];
    regionMenu.subtitleLabel.text = self.selecteSubRegionName;
    [regionMenu addTarget:self action:@selector(regionMenuClick)];
    UIBarButtonItem *regionItem = [[UIBarButtonItem alloc] initWithCustomView:regionMenu];
    self.regionMenu = regionMenu;
    return regionItem;
}

// 排序
- (UIBarButtonItem *) sortItem{
    BinzDealTopMenu *sortMenu = [BinzDealTopMenu dealTopMenu];
    sortMenu.titleLabel.text = @"排序";
    self.selectedSort = [binzMetaDataTool selectedSort];
    sortMenu.subtitleLabel.text = self.selectedSort.label;
    sortMenu.imageButton.imageName = @"icon_sort";
    sortMenu.imageButton.highlightedImageName = @"icon_sort_highlighted";
    [sortMenu addTarget:self action:@selector(sortMenuClick)];
    UIBarButtonItem *sortItem = [[UIBarButtonItem alloc] initWithCustomView:sortMenu];
    self.sortMenu = sortMenu;
    return sortItem;
}

#pragma mark - 导航栏左边事件监听

// 点击分类菜单
- (void)categoryMenuClick{
    // 传递数据(选中的大分类、小分类)
    BinzCategoryViewController *categoryViewController = (BinzCategoryViewController *)self.categoryPopoverController.contentViewController;
    categoryViewController.selectedCategory = self.selectedCategory;
    categoryViewController.selectedSubCategoryName = self.selectedSubCategoryName;
    [self.categoryPopoverController presentPopoverFromRect:self.categoryMenu.bounds inView:self.categoryMenu permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
}

// 点击区域菜单
- (void)regionMenuClick{
    // 传递数据
    BinzRegionViewController *regionViewController =  (BinzRegionViewController *)self.regionPopoverController.contentViewController;
    // 设置正在展示的区域
    NSString *cityName = self.selectedCity.name;
    regionViewController.displayRegions = [binzMetaDataTool cityWithName:cityName].regions;
    // 设置选中的区域
    regionViewController.selectedRegion = self.selectedRegion;
    // 设置选中的子区域名称
    regionViewController.selecteSubRegionName = self.selecteSubRegionName;
    // 显示区域弹出框
    [self.regionPopoverController presentPopoverFromRect:self.regionMenu.bounds inView:self.regionMenu permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
}

- (void)sortMenuClick{
    // 传递数据
    BinzSortViewController *sortViewController = (BinzSortViewController *)self.sortPopoverController.contentViewController;
    sortViewController.selectedSort = self.selectedSort;
    [self.sortPopoverController presentPopoverFromRect:self.sortMenu.bounds inView:self.sortMenu permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
}

#pragma mark - 导航栏右边

- (void)setupNavRight{
    UIBarButtonItem *mapItem = [UIBarButtonItem barButtonItemWithNormalImageName:@"icon_map" highlightedImageName:@"icon_map_highlighted" target:self action:@selector(mapDidClick)];
    mapItem.customView.width = 50;
    UIBarButtonItem *searchItem = [UIBarButtonItem barButtonItemWithNormalImageName:@"icon_search" highlightedImageName:@"icon_search_highlighted" target:self action:@selector(searchDidClick)];
    searchItem.customView.width = 50;
    
    self.navigationItem.rightBarButtonItems = @[mapItem,searchItem];
}

#pragma mark - 导航栏右边事件监听

- (void)mapDidClick{
    NSLog(@"mapDidClick -- ");
}

- (void)searchDidClick{
    NSLog(@"searchDidClick -- ");
}

#pragma mark - 用户菜单

- (void)setupUserMenu{
    AwesomeMenuItem *mineMenuItem = [self createMenuItemWithContentImage:@"icon_pathMenu_mine_normal" highlightedContentImage:@"icon_pathMenu_mine_highlighted"];
    AwesomeMenuItem *collectMenuItem = [self createMenuItemWithContentImage:@"icon_pathMenu_collect_normal" highlightedContentImage:@"icon_pathMenu_collect_highlighted"];
    AwesomeMenuItem *scanMenuItem = [self createMenuItemWithContentImage:@"icon_pathMenu_scan_normal" highlightedContentImage:@"icon_pathMenu_scan_highlighted"];
    AwesomeMenuItem *moreMenuItem = [self createMenuItemWithContentImage:@"icon_pathMenu_more_normal" highlightedContentImage:@"icon_pathMenu_more_highlighted"];
    AwesomeMenuItem *startMenuItem = [[AwesomeMenuItem alloc] initWithImage:[UIImage imageNamed:@"icon_pathMenu_background_normal"] highlightedImage:[UIImage imageNamed:@"icon_pathMenu_background_highlighted"] ContentImage:[UIImage imageNamed:@"icon_pathMenu_mainMine_normal"] highlightedContentImage:[UIImage imageNamed:@"icon_pathMenu_mainMine_highlighted"]];
    NSArray<AwesomeMenuItem *> *menuItems = @[mineMenuItem, collectMenuItem, scanMenuItem, moreMenuItem];
    AwesomeMenu *menu = [[AwesomeMenu alloc] initWithFrame:CGRectZero startItem:startMenuItem menuItems:menuItems];
    // 设置透明度
    menu.alpha = 0.6;
    [self.view addSubview:menu];
    // 不旋转加号按钮
    menu.rotateAddButton = NO;
    // 整个菜单的角度(菜单大小) 小问题 图标分开不均匀
    menu.menuWholeAngle = M_PI_2;
    // 约束大小
    CGFloat menuHeight = 200;
    [menu autoSetDimensionsToSize:CGSizeMake(200, menuHeight)];
    // 约束左边
    [menu autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:0];
    // 约束底部
    [menu autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:0];
    
    // 加号按钮的背景图片
    UIImageView *startMenuBackgroundImageView = [[UIImageView alloc] init];
    startMenuBackgroundImageView.image = [UIImage imageNamed:@"icon_pathMenu_background"];
    [menu insertSubview:startMenuBackgroundImageView atIndex:0];
    // 约束背景图片
    [startMenuBackgroundImageView autoSetDimensionsToSize:startMenuBackgroundImageView.image.size];
    // 约束背景左边
    [startMenuBackgroundImageView autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:0];
    // 约束背景底部
    [startMenuBackgroundImageView autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:0];
    
    menu.startPoint = CGPointMake(startMenuBackgroundImageView.image.size.width * 0.5, menuHeight - startMenuBackgroundImageView.image.size.height * 0.5);
    // 设置代理
    menu.delegate = self;
}

- (AwesomeMenuItem *)createMenuItemWithContentImage:(NSString *) contentImage highlightedContentImage:(NSString *) highlightedContentImage{
    return [[AwesomeMenuItem alloc] initWithImage:[UIImage imageNamed:@"bg_pathMenu_black_normal"] highlightedImage:nil ContentImage:[UIImage imageNamed:contentImage] highlightedContentImage:[UIImage imageNamed:highlightedContentImage]];
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    // 依据条件显示或隐藏footer
    if (self.deals.count < self.totalCount) {
        self.collectionView.mj_footer.hidden = NO;
    } else { // 隐藏
        self.collectionView.mj_footer.hidden = YES;
    }
    return [super numberOfSectionsInCollectionView:collectionView];
}

#pragma mark - AwesomeMenuDelegate

- (void)awesomeMenu:(AwesomeMenu *)menu didSelectIndex:(NSInteger)idx{
    [self awesomeMenuWillAnimateClose:menu];
#warning 先写死，后面改
    if (idx == 1) { // 收藏记录
        BinzCollectDealController *collectDealController = [[BinzCollectDealController alloc] init];
        BinzNavigationController *navigationController = [[BinzNavigationController alloc] initWithRootViewController:collectDealController];
        [self presentViewController:navigationController animated:YES completion:nil];
    }else if (idx == 2) { // 历史记录
        BinzHistoryDealController *historyDealController = [[BinzHistoryDealController alloc] init];
        BinzNavigationController *navigationController = [[BinzNavigationController alloc] initWithRootViewController:historyDealController];
        [self presentViewController:navigationController animated:YES completion:nil];
    }
}

- (void)awesomeMenuDidFinishAnimationClose:(AwesomeMenu *)menu{
    NSLog(@"awesomeMenuDidFinishAnimationClose");
    // 设置菜单透明度
    [UIView animateWithDuration:0.25 animations:^{
        menu.alpha = 0.6;
    }];
}

- (void)awesomeMenuDidFinishAnimationOpen:(AwesomeMenu *)menu{
    NSLog(@"awesomeMenuDidFinishAnimationOpen");
}

- (void)awesomeMenuWillAnimateOpen:(AwesomeMenu *)menu{
    NSLog(@"awesomeMenuWillAnimateOpen");
    menu.contentImage = [UIImage imageNamed:@"icon_pathMenu_cross_normal"];
    menu.highlightedContentImage = [UIImage imageNamed:@"icon_pathMenu_cross_highlighted"];
    // 设置菜单透明度
    [UIView animateWithDuration:0.25 animations:^{
        menu.alpha = 1.0;
    }];
}

- (void)awesomeMenuWillAnimateClose:(AwesomeMenu *)menu{
    NSLog(@"awesomeMenuWillAnimateClose");
    menu.contentImage = [UIImage imageNamed:@"icon_pathMenu_mainMine_normal"];
    menu.highlightedContentImage = [UIImage imageNamed:@"icon_pathMenu_mainMine_highlighted"];
}

- (void)dealloc{
    BinzRemoveSelfAsObserver;
}

- (NSString *)emptyImageName{
    return @"icon_deals_empty";
}

@end
