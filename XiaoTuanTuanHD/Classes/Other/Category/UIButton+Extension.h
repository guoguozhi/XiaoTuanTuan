//
//  UIButton+Extension.h
//  XiaoTuanTuanHD
//
//  Created by 张彬 on 2018/8/12.
//  Copyright © 2018年 bin.z. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (Extension)

// 文字颜色
/** normal状态的文本颜色 */
@property (nonatomic, strong) UIColor *titleColor;
/** highlighted状态的文本颜色 */
@property (nonatomic, strong) UIColor *highlightedTitleColor;
/** selected状态的文本颜色 */
@property (nonatomic, strong) UIColor *selectedTitleColor;
// 文字
/** normal状态的文本 */
@property (nonatomic, copy) NSString *title;
/** highlighted状态的文本 */
@property (nonatomic, copy) NSString *highlightedTitle;
/** selected状态的文本 */
@property (nonatomic, copy) NSString *selectedTitle;
// 图标
/** normal状态的图标 */
@property (nonatomic, copy) NSString *imageName;
/** highlighted状态的图标 */
@property (nonatomic, copy) NSString *highlightedImageName;
/** selected状态的图标 */
@property (nonatomic, copy) NSString *selectedImageName;
// 背景
/** normal状态的背景 */
@property (nonatomic, copy) NSString *backgroundImageName;
/** highlighted状态的背景 */
@property (nonatomic, copy) NSString *highlightedBackgroundImageName;
/** selected状态的背景 */
@property (nonatomic, copy) NSString *selectedBackgroundImageName;

- (void)addTarget:(id)target upInsideAction:(SEL)upInsideAction;
- (void)addTarget:(id)target downAction:(SEL)downAction;

@end
