//
//  BinzDealListController.m
//  XiaoTuanTuanHD
//
//  Created by 张彬 on 2018/9/30.
//  Copyright © 2018 bin.z. All rights reserved.
//

#import "BinzDealListController.h"
#import "BinzDealCell.h"
#import "BinzEmptyView.h"
#import "BinzDealDetailController.h"

@interface BinzDealListController ()

/** 没有数据时的空view */
@property (nonatomic, weak) BinzEmptyView *dealEmptyView;

@end

@implementation BinzDealListController

static NSString * const reuseIdentifier = @"deal";

- (void)viewDidLoad {
    [super viewDidLoad];
    // 设置view的背景色
    self.view.backgroundColor = [UIColor whiteColor];
    // 设置collectionView的背景色
    self.collectionView.backgroundColor = [UIColor clearColor];
    // 注册cell
    [self.collectionView registerNib:[UINib nibWithNibName:@"BinzDealCell" bundle:nil] forCellWithReuseIdentifier:reuseIdentifier];
}

// 视图即将展示时的self.collectionView.width和视图已经完全展示时的self.collectionView.width是一样的么？是否一样取决于现在屏幕的方向和之后的屏幕方法？若是一致的，那么它们是一样的，否则不一样
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    CGFloat width = 0;
    // 竖屏
    if (UIInterfaceOrientationIsPortrait(self.preferredInterfaceOrientationForPresentation)) {
        width = MIN(self.collectionView.width, self.collectionView.height);
    } else { // 横屏
        width = MAX(self.collectionView.width, self.collectionView.height);
    }
    // 调整item之间的间距
    [self settingFlowLayoutTotalWidth:width toInterfaceOrientation:self.preferredInterfaceOrientationForPresentation];
}

#pragma mark - 初始化方法

- (instancetype)init{
    // 指定流式布局
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    // 设置cell的大小
    flowLayout.itemSize = CGSizeMake(316, 360);
    return [super initWithCollectionViewLayout:flowLayout];
}

#pragma mark - 懒加载

- (NSMutableArray<BinzDeal *> *)deals{
    if (!_deals) {
        _deals = [NSMutableArray<BinzDeal *> array];
    }
    return _deals;
}

- (BinzEmptyView *)dealEmptyView{
    if (!_dealEmptyView) {
        BinzEmptyView *dealEmptyView = [BinzEmptyView emptyView];
        dealEmptyView.image = [UIImage imageNamed:self.emptyImageName];
        // 插入到最下面
        [self.view insertSubview:dealEmptyView atIndex:0];
        self.dealEmptyView = dealEmptyView;
    }
    return _dealEmptyView;
}

#pragma mark - UICollectionViewDataSource 数据源

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    // 依据数据显示和隐藏emptyView
    if (self.deals.count > 0) {
        self.dealEmptyView.hidden = YES;
    } else {
        self.dealEmptyView.hidden = NO;
    }
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return [self.deals count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    // 通过可重用标识去缓存中取，若取不到就创建事先注册好的cell，因为没有注册，当时在collectionView中有定义collectionViewCell(它就相当于是事先注册好的cell)
    // 创建cell
    BinzDealCell *cell = (BinzDealCell *)[collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    // 传递数据
    cell.deal = self.deals[indexPath.item];
    // 返回cell
    return cell;
}

#pragma mark - UICollectionViewDelegate 代理

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    BinzDealDetailController *dealDetailController = [[BinzDealDetailController alloc] init];
    // 传递模型
    dealDetailController.deal = self.deals[indexPath.item];
    // 判断当前屏幕的方向是横屏时
    if (UIInterfaceOrientationIsLandscape(self.preferredInterfaceOrientationForPresentation)) {
        // 保持详情控制器和当前屏幕的方法是一致的
        [dealDetailController setInterfaceOrientation:self.preferredInterfaceOrientationForPresentation];
    }
    // 弹出团购详情控制器
    [self presentViewController:dealDetailController animated:YES completion:nil];
}

#pragma mark - 监听屏幕旋转

- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator{
    UIInterfaceOrientation toInterfaceOrientation = UIInterfaceOrientationPortrait;
    if (size.width > size.height) { // 横屏
        toInterfaceOrientation = UIInterfaceOrientationLandscapeLeft|UIInterfaceOrientationLandscapeRight;
    }
    [self settingFlowLayoutTotalWidth:self.collectionView.height toInterfaceOrientation:toInterfaceOrientation];
}

// 设置布局
- (void)settingFlowLayoutTotalWidth:(CGFloat) totalWidth toInterfaceOrientation:(UIInterfaceOrientation) toInterfaceOrientation{
    UICollectionViewFlowLayout *flowLayout = (UICollectionViewFlowLayout *)self.collectionViewLayout;
    // item间的竖直间距
    CGFloat itemVerticalSpacing = 20;
    // item最小的竖直间距
    flowLayout.minimumLineSpacing = itemVerticalSpacing;
    // 竖屏2列、横屏3列
    // 列数
    int columns = UIInterfaceOrientationIsPortrait(toInterfaceOrientation) ? 2 : 3;
    // item间的水平间距(注意: 应该使用旋转后的屏幕宽度，刚好是现在的屏幕高度)
    CGFloat itemHorizontalSpacing = (totalWidth - columns * flowLayout.itemSize.width) / (columns + 1);
    // item最小的水平间距(通过计算)
    flowLayout.minimumInteritemSpacing = itemHorizontalSpacing;
    // 外边距
    flowLayout.sectionInset = UIEdgeInsetsMake(itemVerticalSpacing, itemHorizontalSpacing, itemVerticalSpacing, itemHorizontalSpacing);
}

@end
