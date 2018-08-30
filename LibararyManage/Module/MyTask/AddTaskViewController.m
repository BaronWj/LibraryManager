//
//  AddTaskViewController.m
//  LibararyManage
//
//  Created by 潘伟杰 on 2018/8/14.
//  Copyright © 2018年 renda. All rights reserved.
//

#import "AddTaskViewController.h"
#import "TggStarEvaluationView.h"
#import "MethodDefine.h"
@interface AddTaskViewController ()
@property (weak ,nonatomic) TggStarEvaluationView *tggStarEvaView;

@end

@implementation AddTaskViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    __weak __typeof(self)weakSelf = self;
    // 初始化
    self.tggStarEvaView = [TggStarEvaluationView evaluationViewWithChooseStarBlock:^(NSUInteger count) {
        NSLog(@"\n\n给了铁哥哥：%ld星好评！！!\n\n",count);
        
    }];
    self.tggStarEvaView.frame = (CGRect){self.view.frame.size.width / 2 - 23 * 5+33,kScreenHeight - 121,23 * 10,45};
    [self.view addSubview:self.tggStarEvaView];
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
