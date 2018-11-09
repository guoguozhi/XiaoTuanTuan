//
//  BinzBusiness.h
//  XiaoTuanTuanHD
//
//  Created by 张彬 on 2018/8/5.
//  Copyright © 2018年 bin.z. All rights reserved.
//  商家

#import <Foundation/Foundation.h>

@interface BinzBusiness : NSObject

/** business_id             int         商户ID */
@property (nonatomic, strong) NSNumber *business_id;
/** name                    string      商户名 */
@property (nonatomic, copy) NSString *name;
/** branch_name             string      分店名 */
@property (nonatomic, copy) NSString *branch_name;
/** address                 string      地址 */
@property (nonatomic, copy) NSString *address;
/** telephone               string      带区号的电话 */
@property (nonatomic, copy) NSString *telephone;
/** city                    string      所在城市 */
@property (nonatomic, copy) NSString *city;
/** regions                 list        所在区域信息列表，如[徐汇区，徐家汇] */
@property (nonatomic, strong) NSArray *regions;
/** categories              list        所属分类信息列表，如[宁波菜，婚宴酒店] */
@property (nonatomic, strong) NSArray *categories;
/** latitude                float       纬度坐标 */
@property (nonatomic, strong) NSNumber *latitude;
/** longitude               float       经度坐标 */
@property (nonatomic, strong) NSNumber *longitude;
/** avg_rating              float       星级评分，5.0代表五星，4.5代表四星半，依此类推 */
@property (nonatomic, strong) NSNumber *avg_rating;
/** rating_img_url          string      星级图片链接 */
@property (nonatomic, copy) NSString *rating_img_url;
/** rating_s_img_url        string      小尺寸星级图片链接 */
@property (nonatomic, copy) NSString *rating_s_img_url;
/** product_grade           int         产品/食品口味评价，1:一般，2:尚可，3:好，4:很好，5:非常好 */
@property (nonatomic, strong) NSNumber *product_grade;
/** decoration_grade        int         环境评价，1:一般，2:尚可，3:好，4:很好，5:非常好 */
@property (nonatomic, strong) NSNumber *decoration_grade;
/** service_grade           int         服务评价，1:一般，2:尚可，3:好，4:很好，5:非常好 */
@property (nonatomic, strong) NSNumber *service_grade;
/** product_score           float       产品/食品口味评价单项分，精确到小数点后一位（十分制） */
@property (nonatomic, strong) NSNumber *product_score;
/** decoration_score        float       环境评价单项分，精确到小数点后一位（十分制） */
@property (nonatomic, strong) NSNumber *decoration_score;
/** service_score           float       服务评价单项分，精确到小数点后一位（十分制） */
@property (nonatomic, strong) NSNumber *service_score;
/** avg_price               int         人均价格，单位:元，若没有人均，返回-1 */
@property (nonatomic, strong) NSNumber *avg_price;
/** review_count            int         点评数量 */
@property (nonatomic, strong) NSNumber *review_count;
/** review_list_url         list        点评页面URL链接 */
@property (nonatomic, strong) NSArray *review_list_url;
/** hours                   string      营业时间（例：周一—周五 ：午市11：00—14：00） */
@property (nonatomic, copy) NSString *hours;
/** business_url            string      商户页面链接 */
@property (nonatomic, copy) NSString *business_url;
/** popular_dishes          string      推荐菜 */
@property (nonatomic, copy) NSString *popular_dishes;
/** photo_url               string      照片链接，照片最大尺寸700×700 */
@property (nonatomic, copy) NSString *photo_url;
/** specialties             string      商户标签（无线上网,可以刷卡,朋友聚餐） */
@property (nonatomic, copy) NSString *specialties;
/** s_photo_url             string      小尺寸照片链接，照片最大尺寸278×200 */
@property (nonatomic, copy) NSString *s_photo_url;
/** has_takeaway            int         是否有外卖，0:没有，1:有 */
@property (nonatomic, strong) NSNumber *has_takeaway;
/** photo_count             int         照片数量 */
@property (nonatomic, strong) NSNumber *photo_count;
/** has_queue               int         是否有排队，0:没有，1:有 */
@property (nonatomic, strong) NSNumber *has_queue;
/** photo_list_url          list        照片页面URL链接 */
@property (nonatomic, strong) NSArray *photo_list_url;
/** has_shanhui             int         是否有闪惠，0:没有，1:有 */
@property (nonatomic, strong) NSNumber *has_shanhui;
/** has_coupon              int         是否有优惠券，0:没有，1:有 */
@property (nonatomic, strong) NSNumber *has_coupon;
/** shanhui_title           string      闪惠标题（如：每满100减10、6.9折等） */
@property (nonatomic, copy) NSString *shanhui_title;
/** coupon_id               int         优惠券ID */
@property (nonatomic, strong) NSNumber *coupon_id;
/** qr_code                 string      二维码（base64形式） */
@property (nonatomic, copy) NSString *qr_code;
/** coupon_description      string      优惠券描述 */
@property (nonatomic, copy) NSString *coupon_description;
/** biz_hour                string      当天营业时间 */
@property (nonatomic, copy) NSString *biz_hour;
/** coupon_url              string      优惠券页面链接 */
@property (nonatomic, copy) NSString *coupon_url;
/** has_deal                int         是否有团购，0:没有，1:有 */
@property (nonatomic, strong) NSNumber *has_deal;
/** deal_count              int         商户当前在线团购数量 */
@property (nonatomic, strong) NSNumber *deal_count;
/** deals                   list        团购列表 */
@property (nonatomic, strong) NSArray *deals;
/** has_online_reservation  int         是否有在线预订，0:没有，1:有 */
@property (nonatomic, strong) NSNumber *has_online_reservation;
/** online_reservation_url  string      在线预订页面链接，目前仅返回HTML5站点链接 */
@property (nonatomic, copy) NSString *online_reservation_url;

@end
