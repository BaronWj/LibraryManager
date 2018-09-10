//
//  MyTaskDetailViewController.m
//  LibararyManage
//
//  Created by 潘伟杰 on 2018/8/14.
//  Copyright © 2018年 renda. All rights reserved.
//

#import "MyTaskDetailViewController.h"
#import "LPActionSheet.h"
#import <Social/Social.h>
#import "TggStarEvaluationView.h"
#import "MethodDefine.h"
@interface MyTaskDetailViewController ()
@property (weak ,nonatomic) TggStarEvaluationView *tggStarEvaView;

@end

@implementation MyTaskDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    // 注意weakSelf
    __weak __typeof(self)weakSelf = self;
    // 初始化
    self.tggStarEvaView = [TggStarEvaluationView evaluationViewWithChooseStarBlock:^(NSUInteger count) {
        NSLog(@"\n\n给了铁哥哥：%ld星好评！！!\n\n",count);
       
    }];
    self.tggStarEvaView.frame = (CGRect){self.view.frame.size.width / 2 - 23 * 5+33,kScreenHeight - 121,23 * 10,45};
    [self.view addSubview:self.tggStarEvaView];
    
    // 设置展示的星星数量
     self.tggStarEvaView.starCount = 3;
    
    // 星星之间的间距，默认0.5
    // self.tggStarEvaView.spacing = 0.5;
    
    // 星星的点击事件使能,默认YES
    // self.tggStarEvaView.tapEnabled = NO;
    
//    // 下面这个不带回调，就不会打印了
//    TggStarEvaluationView *tggStarEvaView1 = [TggStarEvaluationView evaluationViewWithChooseStarBlock:nil];
//    tggStarEvaView1.frame = (CGRect){self.view.frame.size.width / 2 - 23 * 5,320 + 50,23 * 10,45};
//    [self.view addSubview:tggStarEvaView1];
        
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)shareAction:(id)sender {
    [self configUnbind];
}


- (void)configUnbind
{
    __weak typeof(self) weakSelf = self;
    NSDictionary *properties = @{FirstFontSize:@"14",
                                 FirstTextColor:@"0x999999",
                                 SecondFontSize:@"15",
                                 SecondTextColor:@"0x333333",
                                 ThirdFontSize:@"15",
                                 ThirdTextColor:@"0x448CFF",
                                 };
    [LPActionSheet showActionSheetWithTitle:@"分享" cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@[@"分享"] properties:properties handler:^(LPActionSheet *actionSheet, NSInteger index) {
        if(index == 1){
            [weakSelf shareContent];
        }
    }];
}


-(void)shareContent{
    NSString *testToShare = @"分享的标题";
    
    UIImage *imageToShare = [UIImage imageNamed:@"first"];
    
    NSURL *urlToShare = [NSURL URLWithString:@"http://www.baidu.com"];
    
    NSArray *activityItems = @[testToShare,imageToShare,urlToShare];
    
     UIActivityViewController *activityVc = [[UIActivityViewController alloc] initWithActivityItems:activityItems applicationActivities:nil];
     activityVc.modalInPopover = YES;

    [self presentViewController:activityVc animated:YES completion:nil];
    
    activityVc.completionWithItemsHandler = ^(UIActivityType  _Nullable activityType, BOOL completed, NSArray * _Nullable returnedItems, NSError * _Nullable activityError) {
        
        if (completed) {
            
            NSLog(@"分享成功");
            
        }else{
            
            NSLog(@"分享取消");
            
        }
        
        
        
    };
}

- (IBAction)createTask:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
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
