//
//  UIBarButtonItem+Extension.h
//  BiBo
//
//  Created by 张彬 on 2017/5/1.
//  Copyright © 2017年 bin.z. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (Extension)

+ (UIBarButtonItem *) barButtonItemWithNormalBackgroundImageName:(NSString *) normalBackgroundImageName highlightedBackgroundImageName:(NSString *) highlightedBackgroundImageName target:(id) target action:(SEL) action;

+ (UIBarButtonItem *) barButtonItemWithNormalImageName:(NSString *) normalImageName highlightedImageName:(NSString *) highlightedImageName target:(id) target action:(SEL) action;

@end
