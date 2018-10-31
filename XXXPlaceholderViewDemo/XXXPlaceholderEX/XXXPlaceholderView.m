//
//  XXXPlaceholderView.m
//  YTableEx
//
//  Created by 赵云飞 on 2018/10/24.
//  Copyright © 2018年 2YF. All rights reserved.
//

#import "XXXPlaceholderView.h"

@interface XXXPlaceholderView ()

///占位图片
@property (nonatomic, strong) UIImageView *placeholderImgV;
///占位lab
@property (nonatomic, strong) UILabel *tipLab;
///占位btn
@property (nonatomic, strong) UIButton *tryBtn;

@end


@implementation XXXPlaceholderView

+ (instancetype)emptyView {
    return [self emptyViewWithTopSpace:0];
}

+ (instancetype)noNetworkView {
    return [self noNetworkViewWithTopSpace:0];
}

+ (instancetype)emptyViewWithTopSpace:(float)topSpace {
    XXXPlaceholderView *emp = [XXXPlaceholderView new];
//图片来自    https://findicons.com/icon/207145/car#
    emp.placeholderImgV.image = [UIImage imageNamed:@"car"];
    if (topSpace == 0.0) topSpace = 110;
    emp.placeholderImgV.centerY_x = topSpace;
    emp.tipLab.text = @"这里什么也木有~\n轻触刷新~";
    
    return emp;
}

+ (instancetype)noNetworkViewWithTopSpace:(float)topSpace {
    XXXPlaceholderView *noNetwork = [XXXPlaceholderView new];
//图片来自    https://findicons.com/icon/207150/bug
    noNetwork.placeholderImgV.image = [UIImage imageNamed:@"bug"];
    if (topSpace == 0.0) topSpace = 110;
    noNetwork.placeholderImgV.centerY_x = topSpace;
    noNetwork.tipLab.text = @"网络异常...";
    noNetwork.tryBtn.hidden = NO;
    [noNetwork.tryBtn setTitle:@"重新加载" forState:UIControlStateNormal];
    
    return noNetwork;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self initViews];
    }
    return self;
}

- (void)initViews {
    
    UIImageView *emptyimgV = [UIImageView new];
    [self addSubview:emptyimgV];
    self.placeholderImgV = emptyimgV;
    
    UILabel *tipLab = [UILabel new];
    [self addSubview:tipLab];
    tipLab.font = [UIFont systemFontOfSize:12];
    tipLab.textColor = [UIColor colorWithRed:163/255.0 green:163/255.0 blue:163/255.0 alpha:1];
    tipLab.numberOfLines = 0;
    tipLab.textAlignment = NSTextAlignmentCenter;
    self.tipLab = tipLab;

    
    //MARK: 不用为btn添加点击事件
    UIButton *tryBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self addSubview:tryBtn];
    tryBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    tryBtn.hidden = YES;
    [tryBtn setTitleColor: [UIColor colorWithRed:102/255.0 green:204/255.0 blue:153/255.0 alpha:1] forState:UIControlStateNormal];
    self.tryBtn = tryBtn;
}


- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.size_x = self.superview.size_x;
    
    self.placeholderImgV.size_x = self.placeholderImgV.image.size;
    self.placeholderImgV.centerX_x = self.centerX_x;
    
    
    
    self.tipLab.width_x = self.size_x.width;
    [self.tipLab sizeToFit];
    self.tipLab.centerX_x = self.centerX_x;
    self.tipLab.top_x = self.placeholderImgV.bottom_x + 20;
    
    
    [self.tryBtn sizeToFit];
    self.tryBtn.centerX_x = self.centerX_x;
    self.tryBtn.top_x = self.tipLab.bottom_x + 43;
    
    
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end










#pragma mark -
@implementation UIView (XXXFrame)


- (CGFloat)left_x {
    return self.frame.origin.x;
}

- (void)setLeft_x:(CGFloat)x_x {
    CGRect frame = self.frame;
    frame.origin.x = x_x;
    self.frame = frame;
}

- (CGFloat)top_x {
    return self.frame.origin.y;
}

- (void)setTop_x:(CGFloat)y_x {
    CGRect frame = self.frame;
    frame.origin.y = y_x;
    self.frame = frame;
}

- (CGFloat)right_x {
    return self.frame.origin.x + self.frame.size.width;
}

- (void)setRight_x:(CGFloat)right_x {
    CGRect frame = self.frame;
    frame.origin.x = right_x - frame.size.width;
    self.frame = frame;
}

- (CGFloat)bottom_x {
    return self.frame.origin.y + self.frame.size.height;
}

- (void)setBottom_x:(CGFloat)bottom_x {
    CGRect frame = self.frame;
    frame.origin.y = bottom_x - frame.size.height;
    self.frame = frame;
}

- (CGFloat)centerX_x
{
    return self.left_x + self.width_x * 0.5;
}

- (void)setCenterX_x:(CGFloat)centerX_x
{
    self.left_x = centerX_x - self.width_x * 0.5;
}

- (CGFloat)centerY_x
{
    return self.top_x + self.height_x * 0.5;
}

- (void)setCenterY_x:(CGFloat)centerY_x
{
    self.top_x = centerY_x - self.height_x * 0.5;
}

- (CGFloat)width_x {
    return self.frame.size.width;
}

- (void)setWidth_x:(CGFloat)width_x {
    CGRect frame = self.frame;
    frame.size.width = width_x;
    self.frame = frame;
}

- (CGFloat)height_x {
    return self.frame.size.height;
}

- (void)setHeight_x:(CGFloat)height_x {
    CGRect frame = self.frame;
    frame.size.height = height_x;
    self.frame = frame;
}

- (CGPoint)origin_x {
    return self.frame.origin;
}

- (void)setOrigin_x:(CGPoint)origin_x {
    CGRect frame = self.frame;
    frame.origin = origin_x;
    self.frame = frame;
}

- (CGSize)size_x {
    return self.frame.size;
}

- (void)setSize_x:(CGSize)size_x {
    CGRect frame = self.frame;
    frame.size = size_x;
    self.frame = frame;
}


@end
