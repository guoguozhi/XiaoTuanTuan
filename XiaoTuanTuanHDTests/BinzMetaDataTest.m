//
//  BinzMetaDataTest.m
//  XiaoTuanTuanHDTests
//
//  Created by 张彬 on 2018/8/9.
//  Copyright © 2018年 bin.z. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "BinzMetaDataTool.h"
#import "BinzCity.h"
#import "BinzCityGroup.h"
#import "BinzCategory.h"
#import "BinzSort.h"

@interface BinzMetaDataTest : XCTestCase

@end

@implementation BinzMetaDataTest

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
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

- (void)testLazyLoadMetaData{
    BinzMetaDataTool *metaDataTool = [BinzMetaDataTool shareMetaDataTool];
    XCTAssert(metaDataTool.categories.count > 0, @"分类数据加载失败!");
    XCTAssert(metaDataTool.cities.count > 0, @"城市数据加载失败!");
    XCTAssert(metaDataTool.cityGroups.count > 0, @"城市分组数据加载失败!");
    XCTAssert(metaDataTool.sorts.count > 0, @"排序数据加载失败!");
    
    XCTAssert([[metaDataTool.categories firstObject] isKindOfClass:[BinzCategory class]], @"分类数据的类型错误!");
}

@end
