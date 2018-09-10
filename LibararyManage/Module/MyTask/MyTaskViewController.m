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
#import <DateTools.h>

static NSString *identifier =@"myTaskTableViewCell";

@interface MyTaskViewController ()
{
    NSInteger taskType;
}
@end

@implementation MyTaskViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.myTaskTableView.delegate = self;
    self.myTaskTableView.dataSource =self;
    [self loadData:0];
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
        
        NSDictionary * dict = @{
                                @"title":@"任务",
                                @"content":@"完成任务详情",
                                @"grades":@(2),
                                @"finishState":@(1),
                                @"createTime":@"2018-9-10 20:12"
                                };
        
        detailsVC.myTaskDict = dict;
    }

}


- (IBAction)taskSegmentAction:(id)sender {
    UISegmentedControl *segment= (UISegmentedControl *)sender;
    NSLog(@"%ld",segment.selectedSegmentIndex);
    taskType = segment.selectedSegmentIndex;
    [self loadData:taskType];
}


//#pragma mark 载入一些数据，用于显示在UITableView上
- (void)loadData:(NSInteger)type {
    //初始化数组
    self.tableDataArr = [NSMutableArray array];
    //加入20个字符串到数组中
    for(int i = 0; i < 15; i++) {
        NSString * title = [NSString stringWithFormat:@"任务%d",i];
        NSString * content = @"完成二元一次方程组的课后练习";
        NSInteger grades = 0;
        if (i % 3==0) {
           grades = 3;
        }
        NSInteger finishState = 0;
        if (i % 2==0) {
            finishState = 1;
        }
        
        NSDictionary * dict = @{
                                @"title":title,
                                @"content":content,
                                @"grades":@(grades),
                                @"finishState":@(finishState),
                                @"createTime":@"2018-9-10 20:12"
                                };
//        [self.tableDataArr addObject:[NSString stringWithFormat:@"学习小组%i", i]];
        
        if (taskType == 1) {
            if (finishState == 0) {
                [self.tableDataArr addObject:dict];
            }
        }else if (taskType == 0){
            [self.tableDataArr addObject:dict];
        }else{
            [self.tableDataArr addObject:dict];
        }
    }
    [self.myTaskTableView reloadData];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.tableDataArr count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    //从队列中取出单元格
    MyTaskTableViewCell *cell = [self.myTaskTableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
    //为单元格的label设置数据
    cell.myTaskTitle.text = [self.tableDataArr objectAtIndex:indexPath.row][@"title"];
    if (taskType == 0) {
        if ( indexPath.row >= 0 && indexPath.row < 5) {
            cell.myTaskTitle.textColor = [UIColor redColor];
        }else if (indexPath.row >= 5 && indexPath.row < 10){
            cell.myTaskTitle.textColor = [UIColor blueColor];
        }else{
            cell.myTaskTitle.textColor = [UIColor greenColor];
        }
    }else{
        cell.myTaskTitle.textColor = [UIColor blackColor];
        cell.timeLabel.text =  [self.tableDataArr objectAtIndex:indexPath.row][@"createTime"];
    }
    
  
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}
@end
