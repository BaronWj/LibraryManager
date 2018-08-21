//
//  SearchBookViewController.m
//  LibararyManage
//
//  Created by 潘伟杰 on 2018/8/17.
//  Copyright © 2018年 renda. All rights reserved.
//

#import "SearchBookViewController.h"
#import "UIColor+expanded.h"
@interface SearchBookViewController ()

@end

@implementation SearchBookViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithHexString:@"0x1E90FF"];
    _dataList = [NSMutableArray array];
    _searchList = [NSMutableArray array];
    
    self.dataList=[NSMutableArray arrayWithCapacity:100];
    
    //产生100个“数字+三个随机字母”
    for (NSInteger i=0; i<100; i++) {
        [self.dataList addObject:[NSString stringWithFormat:@"%ld%@",(long)i,[self shuffledAlphabet]]];
    }
    
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 22,[UIScreen  mainScreen].bounds.size.width ,[UIScreen  mainScreen].bounds.size.height)];
    _tableView.backgroundColor = [UIColor whiteColor];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    
    //创建UISearchController
    _searchController = [[UISearchController alloc]initWithSearchResultsController:nil];

    //设置代理
    _searchController.delegate = self;
    _searchController.searchResultsUpdater= self;
    
    //设置UISearchController的显示属性，以下3个属性默认为YES
    //搜索时，背景变暗色
    _searchController.dimsBackgroundDuringPresentation = NO;
    //搜索时，背景变模糊
    _searchController.obscuresBackgroundDuringPresentation = NO;
    //隐藏导航栏
    _searchController.hidesNavigationBarDuringPresentation = NO;
    
    _searchController.searchBar.frame = CGRectMake(self.searchController.searchBar.frame.origin.x, self.searchController.searchBar.frame.origin.y, self.searchController.searchBar.frame.size.width, 44.0);
    
//    _searchController.searchBar.backgroundColor = [UIColor colorWithHexString:@"0x1E90FF"];
    // 添加 searchbar 到 headerview
    self.tableView.tableHeaderView = _searchController.searchBar;
    
    [self.view addSubview:_tableView];
    
    
    // Do any additional setup after loading the view, typically from a nib.
}



-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
    self.searchController.active = true;  //把active设为yes
}

//产生3个随机字母
- (NSString *)shuffledAlphabet {
    
    NSMutableArray * shuffledAlphabet = [NSMutableArray arrayWithArray:@[@"A",@"B",@"C",@"D",@"E",@"F",@"G",@"H",@"I",@"J",@"K",@"L",@"M",@"N",@"O",@"P",@"Q",@"R",@"S",@"T",@"U",@"V",@"W",@"X",@"Y",@"Z"]];
    
    NSString *strTest = [[NSString alloc]init];
    for (int i=0; i<3; i++) {
        int x = arc4random() % 25;
        strTest = [NSString stringWithFormat:@"%@%@",strTest,shuffledAlphabet[x]];
    }
    
    return strTest;
    
}


//设置区域的行数
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (self.searchController.active) {
        return [self.searchList count];
    }else{
        return [self.dataList count];
    }
}


//返回单元格内容
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *flag=@"cell";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:flag];
    if (cell==nil) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:flag];
    }
    if (self.searchController.active) {
        [cell.textLabel setText:self.searchList[indexPath.row]];
    }
    else{
        [cell.textLabel setText:self.dataList[indexPath.row]];
    }
    return cell;
}


#pragma mark - UISearchControllerDelegate代理

//测试UISearchController的执行过程

- (void)willPresentSearchController:(UISearchController *)searchController
{
    NSLog(@"willPresentSearchController");
}

- (void)didPresentSearchController:(UISearchController *)searchController
{
    NSLog(@"didPresentSearchController");
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.searchController.searchBar becomeFirstResponder]; //放主线程执行这个
    });

}

- (void)willDismissSearchController:(UISearchController *)searchController
{
    NSLog(@"willDismissSearchController");
    [self.navigationController dismissViewControllerAnimated:NO completion:nil];
}

- (void)didDismissSearchController:(UISearchController *)searchController
{
    NSLog(@"didDismissSearchController");
}

- (void)presentSearchController:(UISearchController *)searchController
{
    NSLog(@"presentSearchController");
}


-(void)updateSearchResultsForSearchController:(UISearchController *)searchController {
    
    NSLog(@"updateSearchResultsForSearchController");
    NSString *searchString = [self.searchController.searchBar text];
    NSPredicate *preicate = [NSPredicate predicateWithFormat:@"SELF CONTAINS[c] %@", searchString];
    if (self.searchList!= nil) {
        [self.searchList removeAllObjects];
    }
    //过滤数据
    self.searchList= [NSMutableArray arrayWithArray:[_dataList filteredArrayUsingPredicate:preicate]];
    //刷新表格
    [self.tableView reloadData];
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
