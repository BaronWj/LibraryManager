//
//  BaseViewController.m
//  LibararyManage
//
//  Created by 潘伟杰 on 2018/8/14.
//  Copyright © 2018年 renda. All rights reserved.
//

#import "BaseViewController.h"
#import "UINavigationBar+handle.h"
#import "UIColor+expanded.h"

@interface BaseViewController () 

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    1E90FF  注释天蓝色
    [self.navigationController.navigationBar navBarBackGroundColor:[UIColor colorWithHexString:@"0x1E90FF"] image:nil];//颜色
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
//    [self.navigationController.navigationBar navBarMyLayerHeight:90];//背景高度
    //    [self.navigationController.navigationBar navBarAlpha:0];//透明度
    //    [self.navigationController.navigationBar navBarBottomLineHidden:YES];//隐藏底线
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
