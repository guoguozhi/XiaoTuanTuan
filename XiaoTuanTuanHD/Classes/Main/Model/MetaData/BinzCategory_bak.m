//
//  BinzCategory.m
//  XiaoTuanTuanHD
//
//  Created by 张彬 on 2018/8/9.
//  Copyright © 2018年 bin.z. All rights reserved.
//

#import "BinzCategory_bak.h"

@implementation BinzCategory_bak

- (NSString *)title{
    return self.name;
}

- (NSArray<NSString *> *)subtitles{
    return self.subcategories;
}

- (NSString *)iconName{
    return self.small_icon;
}

- (NSString *)highlightedIconName{
    return self.small_highlighted_icon;
}

@end
