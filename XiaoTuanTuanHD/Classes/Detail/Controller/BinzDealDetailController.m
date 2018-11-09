//
//  BinzDealDetailController.m
//  XiaoTuanTuanHD
//
//  Created by 张彬 on 2018/9/10.
//  Copyright © 2018年 bin.z. All rights reserved.
//

#import "BinzDealDetailController.h"
#import "BinzDeal.h"
#import "BinzRestriction.h"
#import "BinzDealService.h"
#import "BinzGetSingleDealParam.h"
#import "BinzGetSingleDealResult.h"
#import <UShareUI/UShareUI.h>
#import "UIImageView+WebCache.h"
#import "BinzLocalDealTool.h"

@interface BinzDealDetailController () <UIWebViewDelegate>{
    UIInterfaceOrientation _preferredInterfaceOrientation;
}

#pragma mark - 右侧的部分

/** 标题 */
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
/** 描述 */
@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;
/** 团购图片 */
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
/** 现价 */
@property (weak, nonatomic) IBOutlet UILabel *currentPriceLabel;
/** 原价 */
@property (weak, nonatomic) IBOutlet UILabel *listPriceLabel;
/** 随时退 */
@property (weak, nonatomic) IBOutlet UIButton *refundableAnyTimeButton;
/** 过期退 */
@property (weak, nonatomic) IBOutlet UIButton *refundableExpiresButton;
/** 剩余时间 */
@property (weak, nonatomic) IBOutlet UIButton *leftTimeButton;
/** 销售量 */
@property (weak, nonatomic) IBOutlet UIButton *purchaseCountButton;
/** 收藏按钮 */
@property (weak, nonatomic) IBOutlet UIButton *collectButton;
/** 返回 */
- (IBAction)back:(UIButton *)sender;
/** 立即抢购 */
- (IBAction)buy:(UIButton *)sender;
/** 收藏 */
- (IBAction)collect:(UIButton *)sender;
/** 分享 */
- (IBAction)share:(UIButton *)sender;

#pragma mark - 左侧部分

/** webView */
@property (weak, nonatomic) IBOutlet UIWebView *webView;
/** 圈圈 */
@property (nonatomic, weak) UIActivityIndicatorView *indicator;

@end

@implementation BinzDealDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 设置代理
    self.webView.delegate = self;
    // 设置背景色
    self.view.backgroundColor = BinzGlobalColor;
    self.webView.backgroundColor = BinzGlobalColor;
    // 初始化左边的内容
    [self initLeftContent];
    // 初始化右边的内容
    [self initRightContent];
    // 保存浏览历史
    [binzLocalDealTool saveHistoryDeal:self.deal];
}

- (void)initLeftContent{
    // 先更新左边的内容
    [self updateLeftContent];
    // 发送请求
    BinzGetSingleDealParam *param = [[BinzGetSingleDealParam alloc] init];
    param.deal_id = self.deal.deal_id;
    [BinzDealService getSingleDeal:param success:^(BinzGetSingleDealResult *result) {
        if (result.deals.count > 0) { // 为安全起见
            self.deal = [result.deals firstObject];
            // 再次更新左边的内容
            [self updateLeftContent];
        } else {
            [MBProgressHUD showError:@"没有找到指定的团购信息." toView:self.view];
        }
    } failure:^(NSError *error) {
        [MBProgressHUD showError:@"团购数据加载失败." toView:self.view];
    }];
}

// 更新左边的内容
- (void)updateLeftContent{
    // 设置标题
    self.titleLabel.text = self.deal.title;
    // 设置描述
    self.descriptionLabel.text = self.deal.desc;
    [self.imageView setImageWithURL:[NSURL URLWithString:self.deal.image_url] placeholderImage:[UIImage imageNamed:@"placeholder_deal"]];
    // 设置现价
    self.currentPriceLabel.text = [NSString stringWithFormat:@"￥%d", [self.deal.current_price intValue]];
    // 设置原价
    self.listPriceLabel.text = [NSString stringWithFormat:@"门店价￥%d", [self.deal.list_price intValue]];
    // 设置收藏
    if ([binzLocalDealTool isDealCollected:self.deal]) {
        self.collectButton.selected = YES;
    }
    // 设置随时退
    self.refundableAnyTimeButton.selected = self.deal.restrictions.is_refundable;
    // 设置过期退(同随时退)
    self.refundableExpiresButton.selected = self.deal.restrictions.is_refundable;
    
    // 过期时间
    NSString *deadlineString = self.deal.purchase_deadline;
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"yyyy-MM-dd";
    NSDate *deadline = [dateFormatter dateFromString:deadlineString];
    // 当前时间
    NSDate *date = [NSDate date];
    NSTimeInterval timeInterval = [deadline timeIntervalSinceDate:date];
    // 天数
    int days = timeInterval / (60 * 60 * 24);
    // 小时
    int hours = (timeInterval - days * 60 * 60 * 24) / (60 * 60);
    // 分钟
    int minutes = (timeInterval - days * 60 * 60 * 24 - hours * 60 * 60) / 60;
    // 设置剩余时间
    self.leftTimeButton.title = [NSString stringWithFormat:@"%d天%d时%d分", days, hours, minutes];
    // 设置销售量
    self.purchaseCountButton.title = [NSString stringWithFormat:@"售出%d", [self.deal.purchase_count intValue]];
}

- (void)initRightContent{
    // 显示圈圈
    [self.indicator startAnimating];
    // 先隐藏内部的scrollView，不能隐藏webView(一旦隐藏，指示器将不能显示)
    self.webView.scrollView.hidden = YES;
    // 加载第一个页面
    NSURL *URL = [NSURL URLWithString:self.deal.deal_h5_url];
    // 模拟网速慢的情况
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        NSURLRequest *request = [NSURLRequest requestWithURL:URL];
        [self.webView loadRequest:request];
    });
}

#pragma mark - 懒加载

- (UIActivityIndicatorView *)indicator{
    if (!_indicator) {
        // 页面加载的圈圈
        UIActivityIndicatorView *indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
        [self.webView addSubview:indicator];
        // 在父控件的中间(先添加到父控件中)
        [indicator autoCenterInSuperview];
        self.indicator = indicator;
    }
    return _indicator;
}

#pragma mark - UIWebViewDelegate

/**
 * 第一个页面的url: http://m.dianping.com/tuan/deal/19210295?utm_source=open&appKey=975791789
 * 第二个页面的url(更多图文详情): http://m.dianping.com/tuan/deal/moreinfo/19210295
 */
// 实现对请求的监听
// 是否应该加载请求
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    return YES;
}

// 页面加载完成
- (void)webViewDidFinishLoad:(UIWebView *)webView{
    if ([self.webView.request.URL.absoluteString isEqualToString:self.deal.deal_h5_url]) { // 第一个页面加载完成后，发送请求加载第二个页面
        // 团购ID
        NSString *dealID = self.deal.deal_id; //数字-数字
        NSString *substringOfDealID = [dealID substringFromIndex:[dealID rangeOfString:@"-"].location + 1];
        // 加载更多图文详情
        NSString *moreInfoURLString = [NSString stringWithFormat:@"http://m.dianping.com/tuan/deal/moreinfo/%@", substringOfDealID];
        NSURLRequest *newRequest = [NSURLRequest requestWithURL:[NSURL URLWithString:moreInfoURLString]];
        [self.webView loadRequest:newRequest];
    } else { // 第二个页面加载完成
        // 显示scrollView
        self.webView.scrollView.hidden = NO;
        // 删除不必要的元素节点
        // 待执行的js代码
        NSMutableString *js = [NSMutableString string];
        // 全部的链接信息
        [js appendString:@"var links = document.getElementsByTagName('link');                   "];
        // 最后一个链接(body中的第一个)
        [js appendString:@"var lastLink = links[links.length - 1];                              "];
        // 详情信息
        [js appendString:@"var detailInfos = document.getElementsByClassName('detail-info');    "];
        [js appendString:@"var bodyInnerHTML = lastLink.outerHTML;                              "];
        [js appendString:@"for (var i = 0; i < detailInfos.length; i++) {                       "];
        [js appendString:@"   bodyInnerHTML += detailInfos[i].outerHTML;                        "];
        [js appendString:@"}                                                                    "];
        [js appendString:@"document.body.innerHTML = bodyInnerHTML;                             "];
        [self.webView stringByEvaluatingJavaScriptFromString:js];
        // 移除圈圈
        [self.indicator removeFromSuperview];
    }
}

// 网页加载失败
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    // 移除圈圈
    [self.indicator removeFromSuperview];
    [MBProgressHUD showError:[NSString stringWithFormat:@"网页加载失败:%@", error.domain] toView:self.view];
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation{
    return _preferredInterfaceOrientation == UIInterfaceOrientationUnknown ? UIInterfaceOrientationLandscapeLeft : _preferredInterfaceOrientation;
}

- (IBAction)back:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)buy:(UIButton *)sender {
    
}

- (IBAction)collect:(UIButton *)sender {
    if (sender.selected) { // 选中(收藏)
        // 取消收藏
        [binzLocalDealTool cancelCollectDeal:self.deal];
    } else { // 非选中
        // 收藏
        [binzLocalDealTool saveCollectDeal:self.deal];
    }
    // 改变选中状态
    sender.selected = !sender.selected;
}

// 分享
- (IBAction)share:(UIButton *)sender {
    // 显示分享面板
    [UMSocialUIManager showShareMenuViewInWindowWithPlatformSelectionBlock:^(UMSocialPlatformType platformType, NSDictionary *userInfo) {
        // 根据获取的platformType确定所选平台进行下一步操作
        [self shareImageAndTextToPlatformType:platformType];
    }];
}

#pragma mark - 友盟分享  

// 分享图片和文本
- (void)shareImageAndTextToPlatformType:(UMSocialPlatformType)platformType
{
    // 创建分享消息对象
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    
    // 设置文本
    messageObject.text = self.deal.title;
    
    // 创建图片内容对象
    UMShareImageObject *shareObject = [[UMShareImageObject alloc] init];
    //如果有缩略图，则设置缩略图
    shareObject.thumbImage = self.imageView.image;
    [shareObject setShareImage:self.deal.image_url];
    
    // 分享消息对象设置分享内容对象
    messageObject.shareObject = shareObject;
    
    // 调用分享接口
    [[UMSocialManager defaultManager] shareToPlatform:platformType messageObject:messageObject currentViewController:self completion:^(id data, NSError *error) {
        if (error) {
            NSLog(@"UMShare failed with error %@", error);
        }else{
            NSLog(@"response data is %@", data);
        }
    }];
}

#pragma mark - 公共方法

- (void)setInterfaceOrientation:(UIInterfaceOrientation)orientation{
    _preferredInterfaceOrientation = orientation;
}

@end

/**
 
 // 全部的链接信息
 var links = document.getElementsByTagName("link");
 // 最后一个链接(body中的第一个)
 var lastLink = links[links.length - 1];
 // 详情信息
 var detailInfos = document.getElementsByClassName("detail-info");
 var bodyInnerHTML = lastLink.outerHTML;
 for (var i = 0; i < detailInfos.length; i++) {
 bodyInnerHTML += detailInfos[i].outerHTML;
 }
 document.body.innerHTML = bodyInnerHTML;
 
 */
