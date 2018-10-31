//
//  UIScrollView+XXXLoad.m
//  YTableEx
//
//  Created by 赵云飞 on 2018/10/30.
//  Copyright © 2018 2YF. All rights reserved.
//

#import "UIScrollView+XXXLoad.h"
#import <MJRefresh/MJRefresh.h>
@implementation UIScrollView (XXXLoad)

/**
 直接进入刷新状态
 */
- (void)xxx_beginRefreshing {
    [self.mj_header beginRefreshing];
}

/**
 配置下拉动画 及 下拉 上拉 事件
 @param refreshClick 刷新事件。isPullDown = Yes 为下拉
 */
- (void)xxx_loadDataClick:(nullable XXXLoadBlock)refreshClick {
    [self xxx_pullDownClick:^{
        if (refreshClick) {
            refreshClick(YES);
        }
    }];
    [self xxx_pullUpClick:^{
        if (refreshClick) {
            refreshClick(NO);
        }
    }];
}


/**
 配置下拉事件
 @param pullDownBlock 事件block
 */
- (void)xxx_pullDownClick:(nullable XXXPullDownBlock)pullDownBlock {
    MJRefreshHeader *header;
    
    MJRefreshGifHeader *gifHeader = [MJRefreshGifHeader headerWithRefreshingBlock:^{
            if (pullDownBlock) {
                pullDownBlock();
            }
    }];
    NSArray *arr = @[[UIImage imageNamed:@"bug"],[UIImage imageNamed:@"car"]];
    [gifHeader setImages:arr forState:MJRefreshStateIdle];
    [gifHeader setImages:arr forState:MJRefreshStatePulling];
    [gifHeader setImages:arr forState:MJRefreshStateRefreshing];
    [gifHeader setImages:arr forState:MJRefreshStateWillRefresh];
    
    gifHeader.lastUpdatedTimeLabel.hidden = YES;
    gifHeader.stateLabel.hidden = YES;
    header = gifHeader;
    
    
    self.mj_header = header;
}


/**
 配置上拉事件
 @param pullUpBlock 事件block
 */
- (void)xxx_pullUpClick:(nullable XXXPullUpBlock)pullUpBlock {
    self.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        if (pullUpBlock) {
            pullUpBlock();
        }
    }];
}


/**
 结束加载动画
 */
- (void)xxx_stopLoadAnimation {
    [self xxx_stopLoadAnimationWithBlock:nil];
}


/**
 结束加载动画
 @param clickBlock 占位图点击事件
 */
- (void)xxx_stopLoadAnimationWithBlock:(nullable XXXPlaceholderClickBlock)clickBlock {
    [self xxx_stopLoadAnimationWithError:nil clickBlock:clickBlock];
}


/**
 结束加载动画
 @param error 请求error结果
 @param clickBlock 占位图点击事件
 */

- (void)xxx_stopLoadAnimationWithError:(nullable NSError *)error clickBlock:(nullable XXXPlaceholderClickBlock)clickBlock {
    [self.mj_header endRefreshing];
    [self.mj_footer endRefreshing];
    if (error) {
        [self xxx_showNoNetWorkViewWithClickBlock:clickBlock];
    }else{
        [self xxx_reloadDataWithClickBlock:clickBlock];
    }
}

@end
