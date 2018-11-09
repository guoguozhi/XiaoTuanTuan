//
//  UIImage+Extension.h
//  BiBo
//
//  Created by 张彬 on 2017/4/29.
//  Copyright © 2017年 bin.z. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Extension)

+ (UIImage *) imageWithName:(NSString *) imageName;

// 得到拉伸的图片 deprecated
+ (UIImage *) stretchableImageWithName:(NSString *) imageName;

// 得到对称拉伸的图片 deprecated
//+ (UIImage *) stretchableImageWithName:(NSString *) imageName WithSymmetricalPoint:(CGPoint) symmetricalPoint;

// 得到改变大小的图片
+ (UIImage *) resizedImageWithName:(NSString *) imageName;

// 得到改变大小的图片
//+ (UIImage *) resizedImageWithName:(NSString *) imageName WithSymmetricalPoint:(CGPoint) symmetricalPoint;

+ (UIImage *)imageWithColor:(UIColor *)color;

@end
