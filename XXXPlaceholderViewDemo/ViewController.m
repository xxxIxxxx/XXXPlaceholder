//
//  ViewController.m
//  XXXPlaceholderViewDemo
//
//  Created by 赵云飞 on 2018/10/30.
//  Copyright © 2018 赵云飞. All rights reserved.
//

#import "ViewController.h"
#import "Base/BaseTableView.h"
#import "XXXPlaceholderEX/UIScrollView+XXXLoad.h"
#import <MJRefresh/MJRefresh.h>
#import "TableHeaderView.h"
#import "XXXPlaceholderEX/XXXPlaceholderView.h"
@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>
#define XXXWeakSelf __weak typeof(self) weakSelf = self;

@property (nonatomic, strong) BaseTableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataArr;
@property (nonatomic, strong) TableHeaderView *tableHeaderView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.dataArr = @[].mutableCopy;
    
    
    
}


#pragma mark - tableView使用效果
- (void)x_tableView {
    self.tableView = [[BaseTableView alloc] initWithFrame:self.view.bounds style:0];
    [self.view addSubview:self.tableView];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    self.tableHeaderView = [[NSBundle mainBundle] loadNibNamed:@"TableHeaderView" owner:nil options:nil].firstObject;
    self.tableView.tableHeaderView = self.tableHeaderView;

    //配置MJRefresh
    XXXWeakSelf
    [self.tableView xxx_loadDataClick:^(BOOL isPullDown) {
        if (isPullDown) {
            [weakSelf.dataArr removeAllObjects];
        }
        [weakSelf loadData];
    }];
    [self.tableView.mj_header beginRefreshing];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:0 reuseIdentifier:@"12"];
    cell.textLabel.text = [NSString stringWithFormat:@"===== %ld =====",indexPath.row];
    return cell;
}

- (NSInteger )tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArr.count;
}

- (void)loadData {
    
    NSArray *arr = [@"x,x,x,x,x,x,x,x,x,x" componentsSeparatedByString:@","];
    [self.dataArr addObjectsFromArray:arr];
    [self.dataArr addObjectsFromArray:arr];
    
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        
        if (self.tableHeaderView.noNetBtn.selected || self.tableHeaderView.noDataBtn.selected) {
            //模拟无数据    无网络时如果列表有数据不会显示占位图 所以移除数据
            [self.dataArr removeAllObjects];
        }
        
        XXXWeakSelf
        
        /*
        if (self.tableHeaderView.noNetBtn.selected) {
         //模拟无网络
            [weakSelf.tableView xxx_showNoNetWorkViewWithClickBlock:^{
                [weakSelf.tableView xxx_beginRefreshing];
            }];
        }else{
            [self.tableView xxx_reloadDataWithClickBlock:^{
                [weakSelf.tableView xxx_beginRefreshing];
            }];
        }
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
         */
        
        
//        导入XXXPlaceholder
//        即可用下边的代码来处理表的占位图 等效于注释代码
        
        NSError *error;
        if (self.tableHeaderView.noNetBtn.selected) {
            error = [NSError errorWithDomain:@"模拟网络错误" code:1 userInfo:nil];
        }
        [self.tableView xxx_stopLoadAnimationWithError:error clickBlock:^{
            [weakSelf.tableView xxx_beginRefreshing];
        }];
        
        // 自行判断是否需要隐藏 mj_footer 当没有更多数据时隐藏
//        self.tableView.mj_footer.hidden = YES;
        
    });
    
}

#pragma mark - 单view使用效果
- (void)x_view {

    
    BOOL isEmpty = arc4random()%2;
    
    XXXWeakSelf
    
    if (isEmpty) {
        [self.view xxx_showEmptyViewWithClickBlock:^{
            [weakSelf x_view];
        }];
    }else{
        [self.view xxx_showNoNetWorkViewWithClickBlock:^{
            [weakSelf x_view];
        }];
    }
    
}





- (void)dealloc {
    NSLog(@"======== dealloc =========");
}



@end
