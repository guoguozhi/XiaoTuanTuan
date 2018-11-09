//
//  BinzFindDealParam.h
//  XiaoTuanTuanHD
//
//  Created by 张彬 on 2018/8/5.
//  Copyright © 2018年 bin.z. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BinzFindDealParam : NSObject

/** city                string      包含团购信息的城市名称，可选范围见相关API返回结果 */
@property (nonatomic, copy) NSString *city;
/** destination_city    string      指定目的地城市名称，适用于“酒店”、“旅游”等分类，可选范围见相关API返回结果 */
@property (nonatomic, copy) NSString *destination_city;
/** latitude            float       纬度坐标，须与经度坐标同时传入 */
@property (nonatomic, strong) NSNumber *latitude;
/** longitude           float       经度坐标，须与纬度坐标同时传入 */
@property (nonatomic, strong) NSNumber *longitude;
/** radius              int         搜索半径，单位为米，最小值300，最大值5000，如不传入默认为1000 */
@property (nonatomic, strong) NSNumber *radius;
/** region              string      包含团购信息的城市区域名，可选范围见相关API返回结果（不含返回结果中包括的城市名称信息）*/
@property (nonatomic, copy) NSString *region;
/** category            string      包含团购信息的分类名，支持多个category合并查询，多个category用逗号分割。可选范围见相关API返回结果 */
@property (nonatomic, copy) NSString *category;
/** is_local            int         根据是否是本地单来筛选返回的团购，1:是，0:不是 */
@property (nonatomic, strong) NSNumber *is_local;
/** keyword             string      关键词，搜索范围包括商户名、商品名、地址等 */
@property (nonatomic, copy) NSString *keyword;
/** sort                int         结果排序，1:默认，2:价格低优先，3:价格高优先，4:购买人数多优先，5:最新发布优先，6:即将结束优先，7:离经纬度坐标距离近优先 */
@property (nonatomic, strong) NSNumber *sort;
/** limit               int         每页返回的团单结果条目数上限，最小值1，最大值40，如不传入默认为20 */
@property (nonatomic, strong) NSNumber *limit;
/** page                int         页码，如不传入默认为1，即第一页 */
@property (nonatomic, strong) NSNumber *page;
/** format              string      返回数据格式，可选值为json或xml，如不传入，默认值为json */
@property (nonatomic, copy) NSString *format;
 
@end
