//
//  MyTaskViewController.h
//  LibararyManage
//
//  Created by 潘伟杰 on 2018/8/14.
//  Copyright © 2018年 renda. All rights reserved.
//

#import "BaseViewController.h"

@interface MyTaskViewController : BaseViewController<UITableViewDelegate,UITableViewDataSource>
@property (strong, nonatomic) NSMutableArray *tableDataArr;
@property (weak, nonatomic) IBOutlet UITableView *myTaskTableView;
- (IBAction)taskSegmentAction:(id)sender;

@end
