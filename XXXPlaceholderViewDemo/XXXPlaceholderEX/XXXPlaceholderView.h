//
//  XXXPlaceholderView.h
//  YTableEx
//
//  Created by 赵云飞 on 2018/10/24.
//  Copyright © 2018年 2YF. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XXXPlaceholderView : UIView


+ (instancetype)emptyView;

+ (instancetype)noNetworkView;

+ (instancetype)emptyViewWithTopSpace:(float)topSpace;

+ (instancetype)noNetworkViewWithTopSpace:(float)topSpace;





@end









#pragma mark -
/**
 *
 * 此处代码来自SDAutoLayout,简单更改后缀
 * GitHub: https://github.com/gsdios/SDAutoLayout
 *
 */

@interface UIView (XXXFrame)

@property (nonatomic) CGFloat left_x;
@property (nonatomic) CGFloat top_x;
@property (nonatomic) CGFloat right_x;
@property (nonatomic) CGFloat bottom_x;
@property (nonatomic) CGFloat centerX_x;
@property (nonatomic) CGFloat centerY_x;

@property (nonatomic) CGFloat width_x;
@property (nonatomic) CGFloat height_x;


@property (nonatomic) CGPoint origin_x;
@property (nonatomic) CGSize size_x;

@end
