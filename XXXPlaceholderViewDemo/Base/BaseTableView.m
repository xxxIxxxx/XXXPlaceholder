//
//  BaseTableView.m
//  XXXPlaceholderViewDemo
//
//  Created by 赵云飞 on 2018/10/30.
//  Copyright © 2018 赵云飞. All rights reserved.
//

#import "BaseTableView.h"
#import "UIView+XXXPlaceholder.h"
#import "XXXPlaceholderView.h"
@implementation BaseTableView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    self = [super initWithFrame:frame style:style];
    if (self) {
        self.xxx_emptyView = [XXXPlaceholderView emptyView];
        self.xxx_noNetworkView = [XXXPlaceholderView noNetworkView];
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
