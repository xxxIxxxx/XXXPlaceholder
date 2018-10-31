//
//  TableHeaderView.m
//  XXXPlaceholderViewDemo
//
//  Created by 赵云飞 on 2018/10/31.
//  Copyright © 2018 赵云飞. All rights reserved.
//

#import "TableHeaderView.h"

@implementation TableHeaderView

- (IBAction)noNetworkClick:(UIButton *)sender {
    sender.selected = !sender.selected;
    self.noDataBtn.selected = NO;
}

- (IBAction)noDataClick:(UIButton *)sender {
    sender.selected = !sender.selected;
    self.noNetBtn.selected = NO;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
