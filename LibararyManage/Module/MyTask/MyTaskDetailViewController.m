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
@interface MyTaskDetailViewController ()

@end

@implementation MyTaskDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
