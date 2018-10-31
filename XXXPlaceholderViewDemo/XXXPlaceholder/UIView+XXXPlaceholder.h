//
//  UIView+XXXPlaceholder.h
//  YTableEx
//
//  Created by 赵云飞 on 2018/10/24.
//  Copyright © 2018年 2YF. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^XXXPlaceholderClickBlock)(void);

@interface UIView (XXXPlaceholder)

///不跟随ContentInset偏移    默认跟随偏移 该值为NO
@property (nonatomic, assign) BOOL xxx_unfoContentInset;

///覆盖tableHeaderView    默认不覆盖 该值为NO
@property (nonatomic, assign) BOOL xxx_coverTableHeaderView;

///点击事件Block
@property (nonatomic, copy, nullable) XXXPlaceholderClickBlock xxx_placeholderClick;

///无数据时展示的View
@property (nonatomic, strong, nullable) UIView *xxx_emptyView;

///无网络时展示的View
@property (nonatomic, strong, nullable) UIView *xxx_noNetworkView;

/**
 刷新数据源 tableView、collectionView专用
 */
- (void)xxx_reloadData;

/**
 刷新数据源 tableView、collectionView专用
 @param clickBlock 占位图点击事件Block
 */
- (void)xxx_reloadDataWithClickBlock:(nullable XXXPlaceholderClickBlock)clickBlock;

/**
 展示无数据占位图
 */
- (void)xxx_showEmptyView;

/**
 展示无数据占位图
 @param clickBlock 占位图点击事件Block
 */
- (void)xxx_showEmptyViewWithClickBlock:(nullable XXXPlaceholderClickBlock)clickBlock;

/**
 展示无网络占位图
 */
- (void)xxx_showNoNetWorkView;

/**
 展示无网络占位图
 @param clickBlock 占位图点击事件Block
 */
- (void)xxx_showNoNetWorkViewWithClickBlock:(nullable XXXPlaceholderClickBlock)clickBlock;

/**
 移出所有占位图
 */
- (void)xxx_removePlaceholderView;






///保存scrollView.scrollEnabled 初始状态
@property (nonatomic, assign, readonly) BOOL xxx_saveCanScroll;

///保存scrollView.contentInset.bottom 初始值
@property (nonatomic, assign, readonly) float xxx_saveInsetBottom;

///保存tableView.separatorStyle 初始状态
@property (nonatomic, assign, readonly) UITableViewCellSeparatorStyle xxx_saveSeparatorStyle;

///记录是否保存初始状态
@property (nonatomic, assign, readonly) BOOL xxx_isSaveOriValue;

- (BOOL)isScrollView;
- (BOOL)isTableView;
- (BOOL)isCollectionView;
- (BOOL)isTableViewOrCollectionView;
@end


