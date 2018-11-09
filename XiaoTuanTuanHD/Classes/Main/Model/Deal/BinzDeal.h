//
//  BinzDeal.h
//  XiaoTuanTuanHD
//
//  Created by 张彬 on 2018/8/5.
//  Copyright © 2018年 bin.z. All rights reserved.
//  团购

#import <Foundation/Foundation.h>

@class BinzRestriction;

@interface BinzDeal : NSObject

/** deal_id             string      团购单ID */
@property (nonatomic, copy) NSString *deal_id;
/** title               string      团购标题 */
@property (nonatomic, copy) NSString *title;
/** description         string      团购描述 */
@property (nonatomic, copy) NSString *desc;
/** city                string      城市名称，city为＂全国＂表示全国单，其他为本地单，城市范围见相关API返回结果 */
@property (nonatomic, copy) NSString *city;
/** list_price          float       团购包含商品原价值 */
@property (nonatomic, strong) NSNumber *list_price;
/** current_price       float       团购价格 */
@property (nonatomic, strong) NSNumber *current_price;
/** regions             list        团购适用商户所在行政区 */
@property (nonatomic, strong) NSArray *regions;
/** categories          list        团购所属分类 */
@property (nonatomic, strong) NSArray *categories;
/** purchase_count      int         团购当前已购买数(销售量) */
@property (nonatomic, strong) NSNumber *purchase_count;
/** publish_date        string      团购发布上线日期 */
@property (nonatomic, copy) NSString *publish_date;
/** purchase_deadline   string      团购单的截止购买日期 */
@property (nonatomic, copy) NSString *purchase_deadline;
/** distance            int         团购单所适用商户中距离参数坐标点最近的一家与坐标点的距离，单位为米；如不传入经纬度坐标，结果为-1；如团购单无关联商户，结果为MAXINT */
@property (nonatomic, strong) NSNumber *distance;
/** image_url           string      团购图片链接，最大图片尺寸450×280 */
@property (nonatomic, copy) NSString *image_url;
/** more_image_urls     list        更多大尺寸图片 */
@property (nonatomic, strong) NSArray *more_image_urls;
/** s_image_url         string      小尺寸团购图片链接，最大图片尺寸 160×100 */
@property (nonatomic, copy) NSString *s_image_url;
/** more_s_image_urls    list       更多小尺寸图片 */
@property (nonatomic, strong) NSArray *more_s_image_urls;
/** deal_url            string      团购Web页面链接，适用于网页应用 */
@property (nonatomic, copy) NSString *deal_url;
/** deal_h5_url         string      团购HTML5页面链接，适用于移动应用和联网车载应用 */
@property (nonatomic, copy) NSString *deal_h5_url;
/** commission_ratio    float       当前团单的佣金比例 */
@property (nonatomic, strong) NSNumber *commission_ratio;
/** businesses          list        团购所适用的商户列表 */
@property (nonatomic, strong) NSArray *businesses;
/** details             string      团购详情 */
@property (nonatomic, copy) NSString *details;
/** notice              string      重要通知(一般为团购信息的临时变更) */
@property (nonatomic, copy) NSString *notice;
/** is_popular          int         是否为热门团购，0：不是，1：是 */
@property (nonatomic, strong) NSNumber *is_popular;
/** restrictions        object      团购限制条件 */
@property (nonatomic, strong) BinzRestriction *restrictions;

@end
