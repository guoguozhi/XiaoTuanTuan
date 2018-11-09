//
//  BinzCityViewController.m
//  XiaoTuanTuanHD
//
//  Created by 张彬 on 2018/8/20.
//  Copyright © 2018年 bin.z. All rights reserved.
//

#import "BinzCityViewController.h"
#import "BinzCityGroup.h"
#import "BinzMetaDataTool.h"
#import "BinzCitySearchViewController.h"
// 动画时长
#define binzAnimateDuration 0.3

@interface BinzCityViewController () <UISearchBarDelegate, UITableViewDataSource, UITableViewDelegate>

// 城市列表
@property (weak, nonatomic) IBOutlet UITableView *tableView;
// 搜索条
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
// 自定义导航条
@property (weak, nonatomic) IBOutlet UIView *customNavigationBar;
// 自定义导航条的约束
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *customNavigationBarTopLC;
// 城市列表数据
@property (strong, nonatomic) NSArray<BinzCityGroup *> *cityGroups;
// 蒙板
@property (weak, nonatomic) IBOutlet UIButton *cover;
// 城市搜索结果控制器
@property (weak, nonatomic) BinzCitySearchViewController *citySearchViewController;
// 点击蒙板
- (IBAction)coverDidClick:(UIButton *)sender;
// 隐藏城市列表(控制器)
- (IBAction)dissmissCityList:(UIButton *)sender;

@end

@implementation BinzCityViewController

#pragma mark - 懒加载

- (NSArray<BinzCityGroup *> *)cityGroups{
    if (!_cityGroups) {
        _cityGroups = binzMetaDataTool.cityGroups;
    }
    return _cityGroups;
}

- (BinzCitySearchViewController *)citySearchViewController{
    if (!_citySearchViewController) {
        BinzCitySearchViewController *citySearchViewController = [[BinzCitySearchViewController alloc] init];
        [self addChildViewController:citySearchViewController];
        self.citySearchViewController = citySearchViewController;
        
        // 约束被添加的view
        [self.view addSubview:_citySearchViewController.view];
        [_citySearchViewController.view autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero excludingEdge:ALEdgeTop];
        [_citySearchViewController.view autoPinEdge:ALEdgeTop toEdge:ALEdgeTop ofView:self.tableView];
    }
    return _citySearchViewController;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // 设置分组索引标题颜色
    self.tableView.sectionIndexColor = [UIColor blackColor];
}

- (IBAction)coverDidClick:(UIButton *)sender {
    // 和点击取消
    //[self.view endEditing:YES];
    [self searchBarCancelButtonClicked:self.searchBar];
}

- (IBAction)dissmissCityList:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - UISearchBarDelegate

// 开始编辑
- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar{
    // 显示取消按钮
    [self.searchBar setShowsCancelButton:YES animated:YES];
    // 设置背景
    [searchBar setBackgroundImage:[UIImage imageNamed:@"bg_login_textfield_hl"]];
    // 整体往上移动
    self.customNavigationBarTopLC.constant = - self.customNavigationBar.height;
    [UIView animateWithDuration:binzAnimateDuration animations:^{
        [self.view layoutIfNeeded];
        // 显示蒙板
        self.cover.alpha = 0.4;
    }];
}

// 结束编辑
- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar{
    // 隐藏取消按钮
    [self.searchBar setShowsCancelButton:NO animated:YES];
    // 设置背景
    [searchBar setBackgroundImage:[UIImage imageNamed:@"bg_login_textfield"]];
    // 整体慢慢往下移动
    self.customNavigationBarTopLC.constant = 0;
    [UIView animateWithDuration:binzAnimateDuration animations:^{
        // 不是setNeedsLayout
        [self.view layoutIfNeeded];
        // 隐藏蒙板
        self.cover.alpha = 0.0;
    }];
}

// 搜索框的文本改变
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    if (searchText.length > 0) {
        self.citySearchViewController.view.hidden = NO;
        // 传递关键字
        self.citySearchViewController.searchText = searchText;
    } else {
        self.citySearchViewController.view.hidden = YES;
    }
}

// 监听取消按钮的点击
- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar{
    // 退下键盘(结束编辑)
    [searchBar endEditing:YES]; // 会触发searchBarTextDidEndEditing方法
    //[self.view endEditing:YES];
    //[self.view.window endEditing:YES];
    //[searchBar resignFirstResponder];
}

// 可能在低版本的iOS中会影响(在低版本中，formSheet出来的控制器会禁止掉键盘的退出，有属性可以设置不让禁止)，而在高版本的iOS中不会影响最终效果
// 设置控制器在formSheet这种modal样式时，键盘自动退出是否禁用
- (BOOL)disablesAutomaticKeyboardDismissal{
    // 好像即便是禁用了，也能退出
    return NO;
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.cityGroups.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    BinzCityGroup *cityGroup = self.cityGroups[section];
    return cityGroup.cities.count;
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *identifier = @"city";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if(!cell){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
    }
    BinzCityGroup *cityGroup = self.cityGroups[indexPath.section];
    cell.textLabel.text = cityGroup.cities[indexPath.row];
    // 最近组的设置
    if ([self.tableView.dataSource respondsToSelector:@selector(tableView:titleForHeaderInSection:)]) {
        if ([[self.tableView.dataSource tableView:self.tableView titleForHeaderInSection:indexPath.section] isEqualToString:@"最近"]) {
            cell.textLabel.textColor = [UIColor redColor];
        } else {
            cell.textLabel.textColor = [UIColor blackColor];
        }
    }
    return cell;
}

#pragma mark - UITableViewDelegate

- (NSString *) tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    BinzCityGroup *cityGroup = self.cityGroups[section];
    return cityGroup.title;
}

// 设置分组索引标题
- (NSArray<NSString *> *)sectionIndexTitlesForTableView:(UITableView *)tableView{
    return [self.cityGroups valueForKey:@"title"];
}

// 选中行
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    // 销毁控制器
    [self dismissViewControllerAnimated:YES completion:nil];
    BinzCityGroup *cityGroup = self.cityGroups[indexPath.section];
    // 城市名称
    NSString *cityName = cityGroup.cities[indexPath.row];
    BinzCity *city = [binzMetaDataTool cityWithName:cityName];
    // 发出通知
    [BinzNotificationCenter postNotificationName:BinzCityDidSelectNotification object:self userInfo:@{BinzSelectedCity:city}];
}

@end
