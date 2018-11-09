//
//  XiaoTuanTuanHDTests.m
//  XiaoTuanTuanHDTests
//
//  Created by 张彬 on 2018/8/1.
//  Copyright © 2018年 bin.z. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "BinzAPITool.h"
#import "BinzMetaDataTool.h"

@interface XiaoTuanTuanHDTests : XCTestCase

@end

@implementation XiaoTuanTuanHDTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
    
    [self getCitiesWithBusinesses];
    //[self getRegionsWithBusinesses];
    //[self getCategoriesWithBusinesses];
    //[self getCitiesWithDeals];
    //[self getRegionsWithDeals];
    //[self getCategoriesWithDeals];
    //NSArray *categories = [BinzMetaDataTool categories];
    BinzMetaDataTool *metaDataTool = [BinzMetaDataTool shareMetaDataTool];
    NSArray *cities = metaDataTool.cities;
    NSArray *cityGroups = metaDataTool.cityGroups;
    NSArray *sorts = metaDataTool.sorts;
    
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

// 获取支持商户搜索的最新城市列表
- (void)getCitiesWithBusinesses{
    BinzAPITool *apiTool = [BinzAPITool shareAPITool];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    // 发送请求
    [apiTool requestWithURL:@"v1/metadata/get_cities_with_deals"params:params success:^(NSDictionary *json) {
        [json writeToFile:@"/Users/guoguozhi/Desktop/获取支持商户搜索的最新城市列表_metadata_get_cities_with_businesses.plist" atomically:YES];
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}

// 获取支持商户搜索的最新城市下属区域列表
- (void)getRegionsWithBusinesses{
    BinzAPITool *apiTool = [BinzAPITool shareAPITool];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    // 发送请求
    [apiTool requestWithURL:@"v1/metadata/get_regions_with_businesses"params:params success:^(NSDictionary *json) {
        [json writeToFile:@"/Users/guoguozhi/Desktop/获取支持商户搜索的最新城市下属区域列表_metadata_get_regions_with_businesses.plist" atomically:YES];
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}

// 获取支持商户搜索的最新分类列表
- (void)getCategoriesWithBusinesses{
    BinzAPITool *apiTool = [BinzAPITool shareAPITool];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    // 发送请求
    [apiTool requestWithURL:@"v1/metadata/get_cities_with_deals" params:params success:^(NSDictionary *json) {
        [json writeToFile:@"/Users/guoguozhi/Desktop/获取支持商户搜索的最新分类列表_metadata_get_categories_with_businesses.plist" atomically:YES];
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}

// 获取支持团购搜索的最新城市列表
- (void)getCitiesWithDeals{
    BinzAPITool *apiTool = [BinzAPITool shareAPITool];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    // 发送请求
    [apiTool requestWithURL:@"v1/metadata/get_cities_with_deals" params:params success:^(NSDictionary *json) {
        [json writeToFile:@"/Users/guoguozhi/Desktop/获取支持团购搜索的最新城市列表_metadata_get_cities_with_deals.plist" atomically:YES];
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}

// 获取支持团购搜索的最新城市下属区域列表
- (void)getRegionsWithDeals{
    BinzAPITool *apiTool = [BinzAPITool shareAPITool];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    // 发送请求
    [apiTool requestWithURL:@"v1/metadata/get_regions_with_deals" params:params success:^(NSDictionary *json) {
        [json writeToFile:@"/Users/guoguozhi/Desktop/获取支持团购搜索的最新城市下属区域列表_metadata_get_regions_with_deals.plist" atomically:YES];
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}

// 获取支持团购搜索的最新分类列表
- (void)getCategoriesWithDeals{
    BinzAPITool *apiTool = [BinzAPITool shareAPITool];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    // 发送请求
    [apiTool requestWithURL:@"v1/metadata/get_categories_with_deals" params:params success:^(NSDictionary *json) {
        [json writeToFile:@"/Users/guoguozhi/Desktop/获取支持团购搜索的最新分类列表_metadata_get_categories_with_deals.plist" atomically:YES];
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}

@end
