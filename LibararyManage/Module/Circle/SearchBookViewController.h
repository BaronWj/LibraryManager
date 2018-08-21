//
//  SearchBookViewController.h
//  LibararyManage
//
//  Created by 潘伟杰 on 2018/8/17.
//  Copyright © 2018年 renda. All rights reserved.
//

#import "BaseViewController.h"

@interface SearchBookViewController : BaseViewController
<UITableViewDelegate,UITableViewDataSource,UISearchControllerDelegate,UISearchResultsUpdating>
//tableView
@property (strong, nonatomic)  UITableView *tableView;

//searchController
@property (strong, nonatomic)  UISearchController *searchController;

//数据源
@property (strong,nonatomic) NSMutableArray  *dataList;

@property (strong,nonatomic) NSMutableArray  *searchList;


@end
