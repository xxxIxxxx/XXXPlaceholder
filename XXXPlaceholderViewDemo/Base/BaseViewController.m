//
//  BaseViewController.m
//  XXXPlaceholderViewDemo
//
//  Created by 赵云飞 on 2018/10/30.
//  Copyright © 2018 赵云飞. All rights reserved.
//

#import "BaseViewController.h"
#import "UIView+XXXPlaceholder.h"
#import "XXXPlaceholderView.h"
@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.xxx_emptyView = [XXXPlaceholderView emptyViewWithTopSpace:200.0];
    self.view.xxx_noNetworkView = [XXXPlaceholderView noNetworkViewWithTopSpace:200.0];
    
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
