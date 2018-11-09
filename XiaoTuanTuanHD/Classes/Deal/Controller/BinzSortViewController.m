//
//  BinzSortViewController.m
//  XiaoTuanTuanHD
//
//  Created by 张彬 on 2018/8/12.
//  Copyright © 2018年 bin.z. All rights reserved.
//

#import "BinzSortViewController.h"
#import "BinzMetaDataTool.h"
#import "BinzSort.h"

#pragma mark - 排序按钮

@interface BinzSortButton : UIButton

@property (nonatomic, strong) BinzSort *sort;

@end

@implementation BinzSortButton

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.titleLabel.font = [UIFont systemFontOfSize:16];
        self.titleColor = [UIColor blackColor];
        self.selectedTitleColor = [UIColor whiteColor];
        self.backgroundImageName = @"btn_filter_normal";
        self.selectedBackgroundImageName = @"btn_filter_selected";
    }
    return self;
}

- (void)setSort:(BinzSort *)sort{
    _sort = sort;
    self.title = sort.label;
}

// 重写setHighlighted
- (void)setHighlighted:(BOOL)highlighted{
    
}

@end

#pragma mark - 排序控制器

@interface BinzSortViewController ()

/** 选中的排序按钮 */
@property (nonatomic, strong) BinzSortButton *selectedSortButton;

@end

@implementation BinzSortViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSArray *sorts = binzMetaDataTool.sorts;
    CGFloat buttonX = 10;
    CGFloat buttonWidth = self.view.width - 2 * buttonX;
    CGFloat buttonHeight = 30;
    CGFloat margin = 10;
    CGFloat contentHeight = 0;
    for (int i = 0 ; i < sorts.count; i++) {
        BinzSort *sort = sorts[i];
        BinzSortButton *sortButton = [[BinzSortButton alloc] init];
        sortButton.sort = sort;
        CGFloat buttonY = margin + i * (margin + buttonHeight);
        sortButton.frame = CGRectMake(buttonX, buttonY, buttonWidth, buttonHeight);
        [sortButton addTarget:self downAction:@selector(sortButtonDidClick:)];
        [self.view addSubview:sortButton];
        contentHeight = sortButton.maxY + margin;
    }
    UIScrollView *scrollView = (UIScrollView *)self.view;
    scrollView.contentSize = CGSizeMake(0, contentHeight);
    // 设置在popover中的大小
    self.preferredContentSize = self.view.size;
}

- (void)sortButtonDidClick:(BinzSortButton *) sortButton{
    // 取消之前的选中
    self.selectedSortButton.selected = NO;
    // 选中当前按钮
    sortButton.selected = YES;
    // 保存选中按钮
    self.selectedSortButton = sortButton;
    // 发出通知
    [BinzNotificationCenter postNotificationName:BinzSortDidSelectNotification object:self userInfo:@{BinzSelectedSort:sortButton.sort}];
}

- (void)setSelectedSort:(BinzSort *)selectedSort{
    _selectedSort = selectedSort;
    // 选中按钮
    for (int i = 0 ; i < self.view.subviews.count; i++) {
        UIView *subview = self.view.subviews[i];
        if (![subview isKindOfClass:[BinzSortButton class]]) {
            continue;
        }
        BinzSortButton *sortButton = (BinzSortButton *)subview;
        if (sortButton.sort == selectedSort) {
            // 取消之前的选中
            self.selectedSortButton.selected = NO;
            // 选中当前按钮
            sortButton.selected = YES;
            // 保存选中按钮
            self.selectedSortButton = sortButton;
        }
    }
}

@end
