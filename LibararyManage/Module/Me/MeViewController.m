//
//  MeViewController.m
//  LibararyManage
//
//  Created by 潘伟杰 on 2018/8/14.
//  Copyright © 2018年 renda. All rights reserved.
//

#import "MeViewController.h"
#import "MeTableViewCell.h"
static NSString *identifier =@"meTableViewCell";

@interface MeViewController ()

@end

@implementation MeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.meTableView.delegate = self;
    self.meTableView.dataSource =self;
    [self loadData];
    [self.meTableView reloadData];
}


//#pragma mark 载入一些数据，用于显示在UITableView上
- (void)loadData {
    //初始化数组
    self.tableDataArr = [NSMutableArray array];
    
    NSArray * dataSource = @[@[@{@"imageUrl":@"head_default",@"title":@"王小明"}],@[@{@"imageUrl":@"head_default",@"title":@"修改密码"},@{@"imageUrl":@"head_default",@"title":@"清除缓存"},@{@"imageUrl":@"head_default",@"title":@"软件版本"}],@[@{@"imageUrl":@"head_default",@"title":@"退出登录"}]];
    //加入20个字符串到数组中
//    for(int i = 0; i < 20; i++) {
        [self.tableDataArr setArray:dataSource];
//    }
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.tableDataArr.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0 && indexPath.section == 0) {
        return 70;
    }else{
        return 55;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.tableDataArr[section] count];

//    return [self.tableDataArr count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    //从队列中取出单元格
    MeTableViewCell *cell = [self.meTableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
    //为单元格的label设置数据
    if(indexPath.row ==0 && indexPath.section == 0){
        cell.imageView.image = [UIImage imageNamed:self.tableDataArr[indexPath.section][indexPath.row][@"imageUrl"]];
        cell.textLabel.textAlignment = NSTextAlignmentLeft;

    }else if (indexPath.section == [self.tableDataArr count]-1){
        cell.textLabel.textAlignment = NSTextAlignmentCenter;
        cell.textLabel.textColor = [UIColor redColor];
    }
    cell.textLabel.text = self.tableDataArr[indexPath.section][indexPath.row][@"title"];
    return cell;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
