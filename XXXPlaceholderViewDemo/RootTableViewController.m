//
//  RootTableViewController.m
//  XXXPlaceholderViewDemo
//
//  Created by 赵云飞 on 2018/10/30.
//  Copyright © 2018 赵云飞. All rights reserved.
//

#import "RootTableViewController.h"
#import "ViewController.h"
@interface RootTableViewController ()

@property (nonatomic, copy) NSArray<NSString *> *dataArr;

@end

@implementation RootTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    self.title = @"XXXPlaceholderViewDemo";
    
    UILabel *headerLab = [UILabel new];
    headerLab.text = @"也适用collectionView,scrollView限垂直滚动\ndemo的占位图在基类\nBaseViewController/BaseTableView设置\n可单独设置";
    headerLab.numberOfLines = 0;
    headerLab.textColor = [UIColor lightTextColor];
    headerLab.backgroundColor = [UIColor orangeColor];
    headerLab.frame = CGRectMake(0, 0, self.tableView.frame.size.width, 200);
    self.tableView.tableHeaderView = headerLab;
    
    
    self.dataArr = @[@"tableView使用效果",
                     @"单view使用效果"];
    
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ViewController *vc = [ViewController new];
   
    if (indexPath.row == 0) {
        [vc x_tableView];
    }else {
        [vc x_view];
    }
    vc.title = self.dataArr[indexPath.row];
    [self.navigationController pushViewController:vc animated:YES];
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArr.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:0 reuseIdentifier:@"123"];
    cell.textLabel.text = self.dataArr[indexPath.row];
    return cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
