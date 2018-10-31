//
//  UIScrollView+XXXLoad.h
//  YTableEx
//
//  Created by 赵云飞 on 2018/10/30.
//  Copyright © 2018 2YF. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIView+XXXPlaceholder.h"
NS_ASSUME_NONNULL_BEGIN


typedef void(^XXXPullDownBlock)(void);
typedef void(^XXXPullUpBlock)(void);
typedef void(^XXXLoadBlock)(BOOL isPullDown);

@interface UIScrollView (XXXLoad)

/**
 配置下拉动画 及 下拉 上拉 事件
 @param refreshBlock 刷新事件。isPullDown = Yes 为下拉
 */
- (void)xxx_loadDataClick:(nullable XXXLoadBlock)refreshBlock;

/**
 直接进入刷新状态
 */
- (void)xxx_beginRefreshing;


/**
 配置下拉事件
 @param pullDownBlock 事件block
 */
- (void)xxx_pullDownClick:(nullable XXXPullDownBlock)pullDownBlock;


/**
 配置上拉事件
 @param pullUpBlock 事件block
 */
- (void)xxx_pullUpClick:(nullable XXXPullUpBlock)pullUpBlock;


/**
 结束加载动画
 */
- (void)xxx_stopLoadAnimation;


/**
 结束加载动画
 @param clickBlock 占位图点击事件
 */
- (void)xxx_stopLoadAnimationWithBlock:(nullable XXXPlaceholderClickBlock)clickBlock;


/**
 结束加载动画
 @param error 请求error结果
 @param clickBlock 占位图点击事件
 */
- (void)xxx_stopLoadAnimationWithError:(nullable NSError *)error clickBlock:(nullable XXXPlaceholderClickBlock)clickBlock;


@end

NS_ASSUME_NONNULL_END
