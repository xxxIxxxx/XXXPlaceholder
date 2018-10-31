//
//  UIView+XXXPlaceholder.m
//  YTableEx
//
//  Created by 赵云飞 on 2018/10/24.
//  Copyright © 2018年 2YF. All rights reserved.
//

#import "UIView+XXXPlaceholder.h"
#import <objc/runtime.h>

#ifdef DEBUG
#define XXXLog(...) NSLog(__VA_ARGS__)
#else
#define XXXLog(...)
#endif

@implementation UIView (XXXPlaceholder)

- (void)xxx_reloadData {
    [self xxx_reloadDataWithClickBlock:nil];
}


- (void)xxx_reloadDataWithClickBlock:(nullable XXXPlaceholderClickBlock)clickBlock {
#ifdef DEBUG
    NSAssert(self.isTableViewOrCollectionView, @"必须为UITableView或UICollectionView,才能调用xxx_reloadData");
#endif
    if (self.isTableViewOrCollectionView) {
        [self xxx_saveOriginalValue];
        if ([self xxx_checkHaveData]) {
            [self xxx_removePlaceholderView];
        }else{
            [self xxx_showEmptyViewWithClickBlock:clickBlock];
        }
    }
}

///检查TableView Or CollectionView 是否有数据
- (BOOL)xxx_checkHaveData {
    if (self.isTableView) {
        UITableView *tableView = (UITableView *)self;
        [tableView reloadData];
        NSInteger section = [tableView numberOfSections];
        for (NSInteger i = 0; i<section; i++) {
            NSInteger row = [tableView numberOfRowsInSection:i];
            if (row > 0) {
                return YES;
            }
        }
    }else if (self.isCollectionView) {
        UICollectionView *collectionView = (UICollectionView *)self;
        [collectionView reloadData];
        NSInteger section = [collectionView numberOfSections];
        for (NSInteger i = 0; i< section; i++) {
            NSInteger row = [collectionView numberOfItemsInSection:section];
            if (row > 0) {
                return YES;
            }
        }
    }
    return NO;
}


- (void)xxx_showEmptyView {
    [self xxx_showEmptyViewWithClickBlock:nil];
}

- (void)xxx_showEmptyViewWithClickBlock:(nullable XXXPlaceholderClickBlock)clickBlock {
    [self xxx_showPlaceholderViewIsEmptyView:YES ClickBlock:clickBlock];
}

- (void)xxx_showNoNetWorkView {
    [self xxx_showNoNetWorkViewWithClickBlock:nil];
}

- (void)xxx_showNoNetWorkViewWithClickBlock:(nullable XXXPlaceholderClickBlock)clickBlock {
    [self xxx_showPlaceholderViewIsEmptyView:NO ClickBlock:clickBlock];
}

///添加占位图
- (void)xxx_showPlaceholderViewIsEmptyView:(BOOL)isEmptyView ClickBlock:(nullable XXXPlaceholderClickBlock)clickBlock {
    [self xxx_removePlaceholderView];
    //如果tableView、collectionView直接调用 xxx_show 这几个方法且有数据 则不添加占位图
    if ([self xxx_checkHaveData]) {
        return;
    }
    [self addSubview:isEmptyView?self.xxx_emptyView:self.xxx_noNetworkView];
    [self xxx_adjustPlaceholderViewFrame:isEmptyView?self.xxx_emptyView:self.xxx_noNetworkView];
    [self xxx_addActionPlaceholderView:isEmptyView?self.xxx_emptyView:self.xxx_noNetworkView click:clickBlock];
}

///移出占位图 还原初始状态
- (void)xxx_removePlaceholderView {
    
    [self.xxx_emptyView removeFromSuperview];
    [self.xxx_noNetworkView removeFromSuperview];
    if (self.isScrollView && self.xxx_isSaveOriValue) {
        [self.superview layoutSubviews];
        UIScrollView *scrollView = (UIScrollView *)self;
        scrollView.scrollEnabled = self.xxx_saveCanScroll;
        UIEdgeInsets insets = scrollView.contentInset;
        insets.bottom = self.xxx_saveInsetBottom;
        scrollView.contentInset = insets;
        if (self.isTableView) {
            UITableView *tableView = (UITableView *)self;
            tableView.separatorStyle = self.xxx_saveSeparatorStyle;
            [tableView reloadData];
        }
    }
    if (self.isCollectionView) {
        UICollectionView *collectionView = (UICollectionView *)self;
        [collectionView reloadData];
    }
    self.xxx_isSaveOriValue = NO;
}

///为占位图添加点击事件
- (void)xxx_addActionPlaceholderView:(UIView *)placeholderView click:(nullable XXXPlaceholderClickBlock)clickBlock {
    if (clickBlock) {
        self.xxx_placeholderClick = clickBlock;
    }
    BOOL haveBtn = NO;
    for (UIView *subV in placeholderView.subviews) {
        if ([subV isKindOfClass:UIButton.class]) {
            //存在Btn则为Btn添加点击事件
            [(UIButton *)subV addTarget:self action:@selector(xxx_Click) forControlEvents:UIControlEventTouchUpInside];
            haveBtn = YES;
            if (subV.hidden) {
                haveBtn = NO;
            }
        }
    }
    if (!haveBtn) {
        //不存在Btn 则为占位view添加点击事件
        placeholderView.userInteractionEnabled = YES;
        [placeholderView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(xxx_Click)]];
    }
}

///调整占位图位置
- (void)xxx_adjustPlaceholderViewFrame:(UIView *)placeholderView {
    if (self.isScrollView || self.isCollectionView || self.isTableView) {
        UIScrollView *scrollView = (UIScrollView *)self;
        [scrollView.superview layoutSubviews];
        if (self.xxx_unfoContentInset) {
            //抵消scrollView.contentInset
            CGRect frame = placeholderView.frame;
            frame.origin.y = frame.origin.y - scrollView.contentInset.top;
            placeholderView.frame = frame;
        }else if (scrollView.contentInset.top != 0.0) {
            static dispatch_once_t onceToken;
            dispatch_once(&onceToken, ^{
                XXXLog(@"\nXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX\n\n😄😄😄from:UIView+XXXPlaceholder.m\n😄😄😄当前scrollView存在contentInset\n😄😄😄如果占位图不跟随偏移 请将xxx_UnfoContentInset设为YES \n\nXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX");
            });
        }
        
        
        [self xxx_saveOriginalValue];
        
        if (placeholderView == self.xxx_emptyView && self.isTableView && !self.xxx_coverTableHeaderView) {
            //给出tableView.tableHeaderView的高度
            UITableView *tableView = (UITableView *)self;
            CGRect frame = placeholderView.frame;
            frame.origin.y = tableView.tableHeaderView.frame.size.height;
            placeholderView.frame = frame;
            //改变tableView.contentInset.bottom 使tableView可以滑动
            UIEdgeInsets insets = tableView.contentInset;
            if (CGSizeEqualToSize(placeholderView.frame.size, CGSizeZero)) {
                CGRect pFrame = placeholderView.frame;
                pFrame.size = tableView.frame.size;
                placeholderView.frame = pFrame;
            }
            insets.bottom = insets.bottom + placeholderView.frame.size.height;
            tableView.contentInset = insets;
        }
        //避免contentSize.height 过高 滑动露出破绽
        if (scrollView.contentSize.height > scrollView.frame.size.height && !self.isTableView) {
            scrollView.scrollEnabled = NO;
        }
    }
}

///保存scrollView初始状态
- (void)xxx_saveOriginalValue {
    
    if (self.isScrollView && !self.xxx_isSaveOriValue) {
        UIScrollView *scrollView = (UIScrollView *)self;
        self.xxx_saveCanScroll = scrollView.scrollEnabled;
        self.xxx_saveInsetBottom = scrollView.contentInset.bottom;
        if (self.isTableView) {
            UITableView *tableView = (UITableView *)self;
            self.xxx_saveSeparatorStyle = tableView.separatorStyle;
            tableView.separatorStyle = 0;
        }
        self.xxx_isSaveOriValue = YES;
    }
}


- (void)xxx_Click {
    if (self.xxx_placeholderClick) {
        self.xxx_placeholderClick();
    }
}


#pragma mark - get set

- (void)setXxx_unfoContentInset:(BOOL)xxx_unfoContentInset {
    objc_setAssociatedObject(self, @selector(xxx_unfoContentInset), @(xxx_unfoContentInset), OBJC_ASSOCIATION_ASSIGN);
}

- (BOOL)xxx_unfoContentInset {
    return [objc_getAssociatedObject(self, _cmd) boolValue];
}

- (void)setXxx_coverTableHeaderView:(BOOL)xxx_coverTableHeaderView {
    objc_setAssociatedObject(self, @selector(xxx_coverTableHeaderView), @(xxx_coverTableHeaderView), OBJC_ASSOCIATION_ASSIGN);
}

- (BOOL)xxx_coverTableHeaderView {
    return [objc_getAssociatedObject(self, _cmd) boolValue];
}

- (void)setXxx_placeholderClick:(XXXPlaceholderClickBlock)xxx_placeholderClick {
    objc_setAssociatedObject(self, @selector(xxx_placeholderClick), xxx_placeholderClick, OBJC_ASSOCIATION_COPY);
}

- (XXXPlaceholderClickBlock)xxx_placeholderClick {
    return objc_getAssociatedObject(self, @selector(xxx_placeholderClick));
}

- (void)setXxx_emptyView:(UIView *)xxx_emptyView {
    objc_setAssociatedObject(self, @selector(xxx_emptyView), xxx_emptyView, OBJC_ASSOCIATION_RETAIN);
}

- (UIView *)xxx_emptyView {
    return objc_getAssociatedObject(self, @selector(xxx_emptyView));
}

- (void)setXxx_noNetworkView:(UIView *)xxx_noNetworkView {
    objc_setAssociatedObject(self, @selector(xxx_noNetworkView), xxx_noNetworkView, OBJC_ASSOCIATION_RETAIN);
}

- (UIView *)xxx_noNetworkView {
    return objc_getAssociatedObject(self, @selector(xxx_noNetworkView));
}

- (void)setXxx_saveCanScroll:(BOOL)xxx_saveCanScroll {
    objc_setAssociatedObject(self, @selector(xxx_saveCanScroll), @(xxx_saveCanScroll), OBJC_ASSOCIATION_ASSIGN);
}

- (BOOL)xxx_saveCanScroll {
    return [objc_getAssociatedObject(self, _cmd) boolValue];
}

- (void)setXxx_saveInsetBottom:(float)xxx_saveInsetBottom {
    objc_setAssociatedObject(self, @selector(xxx_saveInsetBottom), @(xxx_saveInsetBottom), OBJC_ASSOCIATION_ASSIGN);
}

- (float)xxx_saveInsetBottom {
    return [objc_getAssociatedObject(self, _cmd) floatValue];
}

- (void)setXxx_saveSeparatorStyle:(UITableViewCellSeparatorStyle)xxx_saveSeparatorStyle {
    objc_setAssociatedObject(self, @selector(xxx_saveSeparatorStyle), @(xxx_saveSeparatorStyle), OBJC_ASSOCIATION_ASSIGN);
}

- (UITableViewCellSeparatorStyle)xxx_saveSeparatorStyle {
    return [objc_getAssociatedObject(self, _cmd) integerValue];
}

- (void)setXxx_isSaveOriValue:(BOOL)xxx_isSaveOriValue {
    objc_setAssociatedObject(self, @selector(xxx_isSaveOriValue), @(xxx_isSaveOriValue), OBJC_ASSOCIATION_ASSIGN);
}

- (BOOL)xxx_isSaveOriValue {
    return [objc_getAssociatedObject(self, _cmd) boolValue];
}

#pragma mark - other func

- (BOOL)isTableViewOrCollectionView {
    return self.isTableView || self.isCollectionView;
}

- (BOOL)isScrollView {
    return [self isKindOfClass:UIScrollView.class];
}
- (BOOL)isTableView {
    return [self isKindOfClass:UITableView.class];
}
- (BOOL)isCollectionView {
    return [self isKindOfClass:UICollectionView.class];
}

@end
