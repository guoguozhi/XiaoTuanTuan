//
//  UIImage+Extension.m
//  BiBo
//
//  Created by 张彬 on 2017/4/29.
//  Copyright © 2017年 bin.z. All rights reserved.
//

#import "UIImage+Extension.h"

@implementation UIImage (Extension)

// 依据名称创建一张新图片
+ (UIImage *) imageWithName:(NSString *) imageName{
    UIImage *image = nil;
    if (iOS7) {
        NSString *newImageName = [imageName stringByAppendingString:@"_os7"];
        image  = [UIImage imageNamed:newImageName];
    }
    // 当image为nil时
    if (!image) {
         image  = [UIImage imageNamed:imageName];
    }
    return image;
}

+ (UIImage *) stretchableImageWithName:(NSString *) imageName{
    UIImage *image = [UIImage imageWithName:imageName];
    // stretchableImageWithLeftCapWidth deprecated
    UIImage *stretchableImage = [image stretchableImageWithLeftCapWidth:image.size.width * 0.5 topCapHeight:image.size.height * 0.5];
    return stretchableImage;
}

//+ (UIImage *)stretchableImageWithName:(NSString *)imageName WithSymmetricalPoint:(CGPoint)symmetricalPoint{
//    UIImage *image = [UIImage imageWithName:imageName];
//    // 设置左边拉伸 无效
//    UIImage *leftStretchableImage = [image stretchableImageWithLeftCapWidth:symmetricalPoint.x topCapHeight:symmetricalPoint.y];
//    // 设置右边拉伸 无效
//    UIImage *rightStretchableImage = [leftStretchableImage stretchableImageWithLeftCapWidth:image.size.width - symmetricalPoint.x topCapHeight:symmetricalPoint.y];
//    return rightStretchableImage;
//}

+ (UIImage *) resizedImageWithName:(NSString *)imageName{
    UIImage *image = [UIImage imageWithName:imageName];
    CGFloat top = image.size.height * 0.5;
    CGFloat bottom = top;
    CGFloat left = image.size.width * 0.5;
    CGFloat right = left;
    UIEdgeInsets edgeInsets  = UIEdgeInsetsMake(top, left, bottom, right);
     return [image resizableImageWithCapInsets:edgeInsets resizingMode:UIImageResizingModeStretch];
}

//+ (UIImage *)resizedImageWithName:(NSString *)imageName WithSymmetricalPoint:(CGPoint)symmetricalPoint{
//    UIImage *image = [UIImage imageWithName:imageName];
//    UIImage *leftResizedImage = [image resizableImageWithCapInsets:UIEdgeInsetsMake(symmetricalPoint.y, symmetricalPoint.x, image.size.height - symmetricalPoint.y, image.size.width - symmetricalPoint.x)];
//    UIImage *rightResizedImage = [leftResizedImage resizableImageWithCapInsets:UIEdgeInsetsMake(symmetricalPoint.y, image.size.width - symmetricalPoint.x, image.size.height - symmetricalPoint.y, symmetricalPoint.x)];
//    return rightResizedImage;
//}

+ (UIImage *)imageWithColor:(UIColor *)color{
    // 开启基于位图的图形上下文
    CGSize size = CGSizeMake(100, 100);
    UIGraphicsBeginImageContextWithOptions(size, NO, 0.0); // 透明
    [color set];
    // 绘制一个矩形区域
    UIRectFill(CGRectMake(0, 0, size.width, size.height));
    // 获取图片
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    // 关闭位图图形上下文
    UIGraphicsEndImageContext();
    return image;
}

@end
