//
//  BinzCitySearchViewController.m
//  XiaoTuanTuanHD
//
//  Created by 张彬 on 2018/8/23.
//  Copyright © 2018年 bin.z. All rights reserved.
//

#import "BinzCitySearchViewController.h"
#import "BinzCity.h"
#import "BinzMetaDataTool.h"

@interface BinzCitySearchViewController ()

/** 搜索结果城市 */
@property (nonatomic, strong) NSMutableArray<BinzCity *> *resultCities;

@end

@implementation BinzCitySearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

#pragma mark - lazy

-(NSMutableArray<BinzCity *> *)resultCities{
    if (!_resultCities) {
        _resultCities = [NSMutableArray<BinzCity *> array];
    }
    return _resultCities;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.resultCities.count;
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"city";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if(!cell){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
    }
    BinzCity *city = self.resultCities[indexPath.row];
    cell.textLabel.text = city.name;
    return cell;
}

#pragma mark - UITableViewDelegate

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return [NSString stringWithFormat:@"共%d条搜索结果",(int)self.resultCities.count];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    // 销毁控制器
    [self dismissViewControllerAnimated:YES completion:nil];
    BinzCity *city = self.resultCities[indexPath.row];
    // 发出通知
    [BinzNotificationCenter postNotificationName:BinzCityDidSelectNotification object:self userInfo:@{BinzSelectedCity:city}];
}

#pragma mark - 公共接口

- (void)setSearchText:(NSString *)searchText{
    _searchText = [searchText copy];
    // 清空搜索结果
    [self.resultCities removeAllObjects];
    // 依据搜索文本查看搜索结果
    // 所有的城市数据
    NSArray<BinzCity *> *cities = binzMetaDataTool.cities;
    // 过滤器(谓词、断言) 谓词语法
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"name contains %@ or pinYin.lowercaseString contains %@ or pinYinHead.lowercaseString contains %@", searchText, searchText.lowercaseString, searchText.lowercaseString];
    [self.resultCities addObjectsFromArray:[cities filteredArrayUsingPredicate:predicate]] ;
    // 刷新表格
    [self.tableView reloadData];
}

@end
