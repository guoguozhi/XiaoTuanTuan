//
//  UIBarButtonItem+Extension.m
//  BiBo
//
//  Created by 张彬 on 2017/5/1.
//  Copyright © 2017年 bin.z. All rights reserved.
//

#import "UIBarButtonItem+Extension.h"

@implementation UIBarButtonItem (Extension)
/**
 *  创建barButtonItem
 *
 *  @param normalBackgroundImageName      普通状态背景图片名称
 *  @param highlightedBackgroundImageName 高亮状态背景图片名称
 *  @param target                     目标对象
 *  @param action                     方法
 *
 *  @return 返回UIBarButtonItem
 */
+ (UIBarButtonItem *) barButtonItemWithNormalBackgroundImageName:(NSString *) normalBackgroundImageName highlightedBackgroundImageName:(NSString *) highlightedBackgroundImageName target:(id) target action:(SEL) action {
    UIButton *barButton = [[UIButton alloc] init];
    barButton.contentMode = UIViewContentModeScaleAspectFit;
    [barButton setBackgroundImage:[UIImage imageNamed:normalBackgroundImageName] forState:UIControlStateNormal];
    [barButton setBackgroundImage:[UIImage imageNamed:highlightedBackgroundImageName] forState:UIControlStateHighlighted];
    barButton.size = barButton.currentBackgroundImage.size;
    // 监听按钮
    [barButton addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return [[UIBarButtonItem alloc] initWithCustomView:barButton];
}

+ (UIBarButtonItem *)barButtonItemWithNormalImageName:(NSString *)normalImageName highlightedImageName:(NSString *)highlightedImageName target:(id)target action:(SEL)action{
    UIButton *barButton = [[UIButton alloc] init];
    barButton.contentMode = UIViewContentModeScaleAspectFit;
    [barButton setImage:[UIImage imageNamed:normalImageName] forState:UIControlStateNormal];
    [barButton setImage:[UIImage imageNamed:highlightedImageName] forState:UIControlStateHighlighted];
    barButton.size = barButton.currentImage.size;
    // 监听按钮
    [barButton addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return [[UIBarButtonItem alloc] initWithCustomView:barButton];
}

@end
