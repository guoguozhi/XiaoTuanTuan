//
//  UIButton+Extension.m
//  XiaoTuanTuanHD
//
//  Created by 张彬 on 2018/8/12.
//  Copyright © 2018年 bin.z. All rights reserved.
//

#import "UIButton+Extension.h"

@implementation UIButton (Extension)

- (UIColor *)titleColor{
    return nil;
}
- (void)setTitleColor:(UIColor *)titleColor{
    [self setTitleColor:titleColor forState:UIControlStateNormal];
}

- (UIColor *)highlightedTitleColor{
    return nil;
}

- (void)setHighlightedTitleColor:(UIColor *)highlightedTitleColor{
    [self setTitleColor:highlightedTitleColor forState:UIControlStateHighlighted];
}

- (UIColor *)selectedTitleColor{
    return nil;
}

- (void)setSelectedTitleColor:(UIColor *)selectedTitleColor{
    [self setTitleColor:selectedTitleColor forState:UIControlStateSelected];
}

- (NSString *)title{
    return nil;
}

- (void)setTitle:(NSString *)title{
    [self setTitle:title forState:UIControlStateNormal];
}

- (NSString *)highlightedTitle{
    return nil;
}

- (void)setHighlightedTitle:(NSString *)highlightedTitle{
    [self setTitle:highlightedTitle forState:UIControlStateHighlighted];
}

- (NSString *)selectedTitle{
    return nil;
}

- (void)setSelectedTitle:(NSString *)selectedTitle{
    [self setTitle:selectedTitle forState:UIControlStateSelected];
}

- (NSString *)imageName{
    return nil;
}

- (void)setImageName:(NSString *)imageName{
    [self setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
}

- (NSString *)highlightedImageName{
    return nil;
}

- (void)setHighlightedImageName:(NSString *)highlightedImageName{
    [self setImage:[UIImage imageNamed:highlightedImageName] forState:UIControlStateHighlighted];
}

- (NSString *)selectedImageName{
    return nil;
}

- (void)setSelectedImageName:(NSString *)selectedImageName{
    [self setImage:[UIImage imageNamed:selectedImageName] forState:UIControlStateSelected];
}

- (NSString *)backgroundImageName{
    return nil;
}

- (void)setBackgroundImageName:(NSString *)backgroundImageName{
    [self setBackgroundImage:[UIImage imageNamed:backgroundImageName] forState:UIControlStateNormal];
}

- (NSString *)highlightedBackgroundImageName{
    return nil;
}

- (void)setHighlightedBackgroundImageName:(NSString *)highlightedBackgroundImageName{
    [self setBackgroundImage:[UIImage imageNamed:highlightedBackgroundImageName] forState:UIControlStateHighlighted];
}

- (NSString *)selectedBackgroundImageName{
    return nil;
}

- (void)setSelectedBackgroundImageName:(NSString *)selectedBackgroundImageName{
    [self setBackgroundImage:[UIImage imageNamed:selectedBackgroundImageName] forState:UIControlStateSelected];
}

- (void)addTarget:(id)target upInsideAction:(SEL)upInsideAction{
    [self addTarget:target action:upInsideAction forControlEvents:UIControlEventTouchUpInside];
}

- (void)addTarget:(id)target downAction:(SEL)downAction{
    [self addTarget:target action:downAction forControlEvents:UIControlEventTouchDown];
}

@end
