//
//  MyTaskViewController.m
//  LibararyManage
//
//  Created by 潘伟杰 on 2018/8/14.
//  Copyright © 2018年 renda. All rights reserved.
//

#import "MyTaskViewController.h"
#import "MyTaskDetailViewController.h"
#import "MyTaskTableViewCell.h"
#import "AddTaskViewController.h"
static NSString *identifier =@"myTaskTableViewCell";

@interface MyTaskViewController ()

@end

@implementation MyTaskViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.myTaskTableView.delegate = self;
    self.myTaskTableView.dataSource =self;
    [self loadData];
    [self.myTaskTableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    if ([segue.identifier isEqualToString:@"MyTaskDetailViewController"]) {
        MyTaskDetailViewController *detailsVC = segue.destinationViewController;
//        detailsVC.idString = sender;
    }

}


- (IBAction)taskSegmentAction:(id)sender {
    UISegmentedControl *segment= (UISegmentedControl *)sender;
    NSLog(@"%ld",segment.selectedSegmentIndex);
}


//#pragma mark 载入一些数据，用于显示在UITableView上
- (void)loadData {
    //初始化数组
    self.tableDataArr = [NSMutableArray array];
    //加入20个字符串到数组中
    for(int i = 0; i < 20; i++) {
        [self.tableDataArr addObject:[NSString stringWithFormat:@"学习小组%i", i]];
    }
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.tableDataArr count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    //从队列中取出单元格
    MyTaskTableViewCell *cell = [self.myTaskTableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
    //为单元格的label设置数据
    cell.myTaskTitle.text = [self.tableDataArr objectAtIndex:indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}
@end
