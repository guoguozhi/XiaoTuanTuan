//
//  AppDelegate.m
//  XiaoTuanTuanHD
//
//  Created by 张彬 on 2018/8/1.
//  Copyright © 2018年 bin.z. All rights reserved.
//

#import "AppDelegate.h"
#import <UMCommon/UMCommon.h>
#import <UMShare/UMShare.h>
#import "UIImageView+WebCache.h"
#import "BinzNavigationController.h"
#import "BinzDealViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // 创建一个窗口
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];    
    // 创建团购控制器
    BinzDealViewController *dealViewController = [[BinzDealViewController alloc] init];
    // 创建导航控制器
    BinzNavigationController *navigationController = [[BinzNavigationController alloc] initWithRootViewController:dealViewController];
    // 设置窗口的根控制器
    self.window.rootViewController = navigationController;
    // 设置窗口显示
    [self.window makeKeyAndVisible];
    // UMConfigure 通用设置，请参考SDKs集成做统一初始化。
    // 以下仅列出U-Share初始化部分
    // U-Share 平台设置
    [self configUSharePlatforms];
    [self confitUShareSettings];
    
    // Custom code
    
    // 设置window的背景色
    self.window.backgroundColor = [UIColor whiteColor];
    // 设置导航条的主题
    UINavigationBar *navigationBarAppearance = [UINavigationBar appearance];
    [navigationBarAppearance setBackgroundImage:[UIImage imageNamed:@"bg_navigationBar_normal"] forBarMetrics:UIBarMetricsDefault];
    
    // 设置barButtonItem的主题
    UIBarButtonItem *barButtonItemAppearance = [UIBarButtonItem appearance];
    NSMutableDictionary *barButtonItemTitleTextDictionary = [NSMutableDictionary dictionary];
    // 设置文字颜色
    barButtonItemTitleTextDictionary[NSForegroundColorAttributeName] = [UIColor blackColor];
    // 设置字体
    barButtonItemTitleTextDictionary[NSFontAttributeName] = [UIFont systemFontOfSize:16];
    [barButtonItemAppearance setTitleTextAttributes:barButtonItemTitleTextDictionary forState:UIControlStateNormal];
    // 一些目录设置
    [self settingForDirectories];
    return YES;
}

// 目录初始化相关
- (void)settingForDirectories{
    NSString *libraryDirectoryPath = [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) firstObject];
    // 检测是否创建了user目录
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if (![fileManager fileExistsAtPath:UserDirectory]) {
        [fileManager createDirectoryAtPath:UserDirectory withIntermediateDirectories:YES attributes:nil error:nil];
    }
}

- (void)configUSharePlatforms{
    /**
     *  应用                     appKey      appSecret
     *  WuliBo                  74394085    22baeb0dd274e71f96aaf369a7f5969
     *  小败家                   209984239   c0266a33d07d569de0f7ea2512415f45
     *  baijiaxiaoshu           4246055124  9c46df3cbc0a5cbc8c87da39f303faa7
     */
    /* 设置新浪的appKey和appSecret */
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_Sina appKey:@"74394085" appSecret:@"22baeb0dd274e71f96aaf369a7f5969" redirectURL:@"https://sns.whalecloud.com/sina2/callback"];
}

- (void)confitUShareSettings{
    /*
     * 打开图片水印
     */
    //[UMSocialGlobal shareInstance].isUsingWaterMark = YES;
    
    /*
     * 关闭强制验证https，可允许http图片分享，但需要在info.plist设置安全域名
     <key>NSAppTransportSecurity</key>
     <dict>
       <key>NSAllowsArbitraryLoads</key>
       <true/>
     </dict>
     */
    [UMSocialGlobal shareInstance].isUsingHttpsWhenShareContent = NO;
    // appKey: 5b9e0209b27b0a22ac00036b (XiaoTuanTuanHD)
    // 设置打开日志
    //[UMConfigure setLogEnabled:YES];
    // 注册友盟appKey
    [UMConfigure initWithAppkey:@"5b9e0209b27b0a22ac00036b" channel:@"App Store"];
}

#pragma mark - UM的回调函数

// 支持所有iOS系统
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation{
    //6.3的新的API调用，是为了兼容国外平台(例如:新版facebookSDK,VK等)的调用[如果用6.2的api调用会没有回调],对国内平台没有影响
    BOOL result = [[UMSocialManager defaultManager] handleOpenURL:url sourceApplication:sourceApplication annotation:annotation];
    if (!result) {
        // 其他如支付等SDK的回调
    }
    return result;
}

// 仅支持iOS9以上系统，iOS8及以下系统不会回调
- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey, id> *)options{
    //6.3的新的API调用，是为了兼容国外平台(例如:新版facebookSDK,VK等)的调用[如果用6.2的api调用会没有回调],对国内平台没有影响
    BOOL result = [[UMSocialManager defaultManager]  handleOpenURL:url options:options];
    if (!result) {
        // 其他如支付等SDK的回调
    }
    return result;
}
// 支持目前所有iOS系统
- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url{
    BOOL result = [[UMSocialManager defaultManager] handleOpenURL:url];
    if (!result) {
        // 其他如支付等SDK的回调
    }
    return result;
}

- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application{
    // 取消所有的下载
    [[SDWebImageManager sharedManager] cancelAll];
    // 清除内存缓存
    [[SDImageCache sharedImageCache] clearMemory];
}

@end
