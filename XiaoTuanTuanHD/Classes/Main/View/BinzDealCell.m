//
//  BinzDealCell.m
//  XiaoTuanTuanHD
//
//  Created by 张彬 on 2018/9/8.
//  Copyright © 2018年 bin.z. All rights reserved.
//

#import "BinzDealCell.h"
#import "BinzDeal.h"
#import "UIImageView+WebCache.h"
#import "UIImage+Extension.h"
#import "Colours.h"

@interface BinzDealCell ()

/** 图片 */
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
/** 文字信息 */
@property (weak, nonatomic) IBOutlet UIView *infoView;
/** 标题 */
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
/** 描述信息 */
@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;
/** 现价 */
@property (weak, nonatomic) IBOutlet UILabel *currentPriceLabel;
/** 原价 */
@property (weak, nonatomic) IBOutlet UILabel *listPriceLabel;
/** 销售量 */
@property (weak, nonatomic) IBOutlet UILabel *purchaseCountLabel;
/** 最新团购标记图片 */
@property (weak, nonatomic) IBOutlet UIImageView *latestDealImageView;

@end

@implementation BinzDealCell

#pragma mark - 公共接口

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self initComponent];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self initComponent];
    }
    return self;
}

// 一些初始化设置
- (void)initComponent{
    self.descriptionLabel.numberOfLines = 0;
}

- (void)setDeal:(BinzDeal *)deal{
    _deal = deal;
    // 属性设置
    // 设置图片
    [self.imageView setImageWithURL:[NSURL URLWithString:deal.image_url] placeholderImage:[UIImage imageNamed:@"placeholder_deal"]];
    // 设置标题
    self.titleLabel.text = deal.title;
    // 设置描述信息
    self.descriptionLabel.text = deal.desc;
    // 设置现价
    self.currentPriceLabel.text = [NSString stringWithFormat:@"￥%d",[deal.current_price intValue]];
    // 设置原价
    self.listPriceLabel.text = [NSString stringWithFormat:@"￥%d",[deal.list_price intValue]];
    // 设置销售量
    self.purchaseCountLabel.text = [NSString stringWithFormat:@"已售%d",[deal.purchase_count intValue]];
    // 最新团购标记
    // 当前日期
    NSDate *currentDate = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"yyyy-MM-dd";
    // 当前日期字符串
    NSString *currentDateString = [dateFormatter stringFromDate:currentDate];
    self.latestDealImageView.hidden = ([deal.publish_date compare:currentDateString] == NSOrderedAscending);
}

- (void)drawRect:(CGRect)rect{
    // 将图片绘制到rect
    [[UIImage imageWithColor:BinzGlobalColor] drawInRect:rect];
}

@end
